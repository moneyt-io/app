import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/accounting_type.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/form_field_container.dart';
import '../../navigation/navigation_service.dart';

class ChartAccountFormScreen extends StatefulWidget {
  final ChartAccount? account;
  
  const ChartAccountFormScreen({
    Key? key,
    this.account,
  }) : super(key: key);
  
  @override
  State<ChartAccountFormScreen> createState() => _ChartAccountFormScreenState();
}

class _ChartAccountFormScreenState extends State<ChartAccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  
  String _selectedAccountingType = AccountingType.assets.id;
  int _level = 1;
  int? _selectedParentId;
  bool _isAutoCode = true;
  bool _isLoading = false;
  String? _error;
  
  // Lista de cuentas padre disponibles
  List<ChartAccount> _parentAccounts = [];
  
  bool get isEditing => widget.account != null;
  
  late final ChartAccountUseCases _chartAccountUseCases;
  
  @override
  void initState() {
    super.initState();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    
    if (isEditing) {
      // Prellenar datos para edición
      _nameController.text = widget.account!.name;
      _codeController.text = widget.account!.code;
      _selectedAccountingType = widget.account!.accountingTypeId;
      _level = widget.account!.level;
      _selectedParentId = widget.account!.parentId;
      _isAutoCode = false; // En edición, el código no es automático
    }
    
    _loadParentAccounts();
  }
  
  Future<void> _loadParentAccounts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final accounts = await _chartAccountUseCases.getAllChartAccounts();
      
      // Para padres, solo usar cuentas con nivel < 3 (ejemplo)
      final parentAccounts = accounts.where((a) => a.level < 3).toList();
      
      if (mounted) {
        setState(() {
          _parentAccounts = parentAccounts;
          _isLoading = false;
        });
      }
      
      // Si estamos creando una nueva cuenta, generar código automáticamente
      if (!isEditing && _isAutoCode) {
        _generateCode();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  
  // Generar código automáticamente según tipo y nivel
  void _generateCode() async {
    if (!_isAutoCode) return;
    
    try {
      if (_selectedParentId != null) {
        // Si hay cuenta padre, buscar su código y añadir un sufijo
        final parentAccount = _parentAccounts.firstWhere(
          (account) => account.id == _selectedParentId,
          orElse: () => throw Exception('Cuenta padre no encontrada'),
        );
        
        // Contar cuántos hermanos ya existen del mismo tipo
        final siblings = await _chartAccountUseCases.getChildAccounts(parentAccount.id);
        final nextNumber = siblings.length + 1;
        
        setState(() {
          _codeController.text = '${parentAccount.code}.$nextNumber';
        });
      } else {
        // Si es cuenta raíz, generar código basado en tipo
        final accountsOfType = await _chartAccountUseCases.getChartAccountsByType(_selectedAccountingType);
        final rootAccounts = accountsOfType.where((a) => a.isRootAccount).toList();
        final nextNumber = rootAccounts.length + 1;
        
        setState(() {
          _codeController.text = '$_selectedAccountingType$nextNumber';
        });
      }
      
      // Actualizar nivel
      _updateLevel();
    } catch (e) {
      // Si ocurre un error, usar un código genérico
      setState(() {
        _codeController.text = '${_selectedAccountingType}NEW';
        _updateLevel();
      });
    }
  }
  
  // Actualizar nivel basado en el padre seleccionado
  void _updateLevel() {
    if (_selectedParentId != null) {
      final parentAccount = _parentAccounts.firstWhere(
        (account) => account.id == _selectedParentId,
        orElse: () => throw Exception('Cuenta padre no encontrada'),
      );
      
      setState(() {
        _level = parentAccount.level + 1;
      });
    } else {
      setState(() {
        _level = 1; // Nivel 1 para cuentas raíz
      });
    }
  }
  
  Future<void> _saveAccount() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedParentId == null && _level > 1) {
      setState(() {
        _error = 'Debe seleccionar una cuenta padre para este nivel';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      
      ChartAccount savedAccount;
      if (isEditing) {
        // Actualizar cuenta existente
        final account = ChartAccount(
          id: widget.account!.id,
          parentId: _selectedParentId,
          accountingTypeId: _selectedAccountingType,
          code: _codeController.text.trim(),
          level: _level,
          name: _nameController.text.trim(),
          active: true,
          createdAt: widget.account!.createdAt,
          updatedAt: now,
          deletedAt: null,
        );
        
        await _chartAccountUseCases.updateChartAccount(account);
        savedAccount = account;
      } else {
        // Crear nueva cuenta
        if (_level == 1) {
          // Cuenta de primer nivel
          savedAccount = await _chartAccountUseCases.generateAccountForCategory(
            _nameController.text.trim(),
            _selectedAccountingType,
          );
        } else {
          // Cuenta de nivel inferior, necesita un padre
          if (_selectedParentId == null) {
            throw Exception('Se requiere una cuenta padre');
          }
          
          // Obtener el código del padre primero
          final parent = await _chartAccountUseCases.getChartAccountById(_selectedParentId!);
          if (parent == null) {
            throw Exception('No se encontró la cuenta padre');
          }
          
          savedAccount = await _chartAccountUseCases.createChartAccount(
            parentCode: parent.code, // Añadido el parámetro faltante
            name: _nameController.text.trim(),
            accountingTypeId: _selectedAccountingType,
          );
        }
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? 'Cuenta actualizada con éxito' : 'Cuenta creada con éxito'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        
        NavigationService.goBack(savedAccount);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    if (_isLoading && !_isAutoCode) {
      return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Editar Cuenta' : 'Nueva Cuenta'),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Cuenta' : 'Nueva Cuenta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorScheme.onErrorContainer,
                      ),
                      onPressed: () => setState(() => _error = null),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Tipo de cuenta contable
            FormFieldContainer(
              child: DropdownButtonFormField<String>(
                value: _selectedAccountingType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Cuenta',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_balance),
                ),
                items: AccountingType.values.map((type) {
                  return DropdownMenuItem(
                    value: type.id,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: isEditing ? null : (value) {
                  if (value != null) {
                    setState(() {
                      _selectedAccountingType = value;
                      _selectedParentId = null; // Resetear padre al cambiar tipo
                      _generateCode();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un tipo de cuenta';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Cuenta padre (opcional)
            FormFieldContainer(
              child: DropdownButtonFormField<int?>(
                value: _selectedParentId,
                decoration: const InputDecoration(
                  labelText: 'Cuenta Padre (opcional)',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_tree),
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('Ninguna (Cuenta Raíz)'),
                  ),
                  ..._parentAccounts
                    .where((a) => a.accountingTypeId == _selectedAccountingType) // Filtrar por mismo tipo
                    // Si estamos editando, no mostrar la cuenta actual ni sus descendientes como posible padre
                    .where((a) => !isEditing || (a.id != widget.account!.id))
                    .map((account) {
                      return DropdownMenuItem(
                        value: account.id,
                        child: Text('${account.code} - ${account.name}'),
                      );
                    }).toList(),
                ],
                onChanged: isEditing ? null : (value) {
                  setState(() {
                    _selectedParentId = value;
                    _generateCode();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Código contable
            FormFieldContainer(
              child: TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Código',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.code),
                  suffixIcon: !isEditing ? Switch(
                    value: _isAutoCode,
                    onChanged: (value) {
                      setState(() {
                        _isAutoCode = value;
                        if (_isAutoCode) {
                          _generateCode();
                        }
                      });
                    },
                  ) : null,
                ),
                readOnly: _isAutoCode && !isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un código';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            if (!isEditing)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(
                      _isAutoCode ? Icons.auto_awesome : Icons.edit,
                      size: 14,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isAutoCode ? 'Código generado automáticamente' : 'Código manual',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            
            // Nivel jerárquico (solo informativo)
            FormFieldContainer(
              child: TextFormField(
                initialValue: _level.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nivel Jerárquico',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.layers),
                ),
                readOnly: true,
                enabled: false,
              ),
            ),
            const SizedBox(height: 16),
            
            // Nombre de la cuenta
            FormFieldContainer(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Cuenta',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _isLoading ? null : _saveAccount,
          isLoading: _isLoading,
          type: AppButtonType.filled,
          isFullWidth: true,
        ),
      ),
    );
  }
}
