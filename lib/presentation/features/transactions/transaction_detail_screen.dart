import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionEntry transaction;

  const TransactionDetailScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();

  Category? _category;
  Wallet? _wallet;
  Wallet? _targetWallet;
  Contact? _contact;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedData();
  }

  Future<void> _loadRelatedData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final transaction = widget.transaction;
      final mainDetail = transaction.mainDetail;

      // Cargar categoría si aplica
      if (mainDetail != null && !transaction.isTransfer && mainDetail.categoryId > 0) {
        _category = await _categoryUseCases.getCategoryById(mainDetail.categoryId);
      }

      // Cargar wallet de origen
      if (mainDetail != null && mainDetail.paymentId > 0) {
        _wallet = await _walletUseCases.getWalletById(mainDetail.paymentId);
      }

      // Cargar wallet destino si es transferencia
      if (transaction.isTransfer && transaction.targetDetail?.paymentId != null) {
        final targetPaymentId = transaction.targetDetail!.paymentId;
        _targetWallet = await _walletUseCases.getWalletById(targetPaymentId);
      }

      // Cargar contacto si está relacionado
      if (transaction.contactId != null) {
        _contact = await _contactUseCases.getContactById(transaction.contactId!);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar datos: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _navigateToEdit() {
    NavigationService.navigateTo(
      AppRoutes.transactionForm,
      arguments: {
        'transaction': widget.transaction,
        'type': widget.transaction.documentTypeId,
      },
    ).then((value) {
      if (value != null) {
        NavigationService.goBack(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final transaction = widget.transaction;

    String typeTitle;
    Color typeColor;
    IconData typeIcon;

    switch (transaction.documentTypeId) {
      case 'I':
        typeTitle = 'Ingreso';
        typeColor = Colors.green;
        typeIcon = Icons.arrow_upward;
        break;
      case 'E':
        typeTitle = 'Gasto';
        typeColor = Colors.red;
        typeIcon = Icons.arrow_downward;
        break;
      case 'T':
        typeTitle = 'Transferencia';
        typeColor = Colors.blue;
        typeIcon = Icons.swap_horiz;
        break;
      default:
        typeTitle = 'Transacción';
        typeColor = colorScheme.primary;
        typeIcon = Icons.receipt;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de $typeTitle'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEdit,
            tooltip: 'Editar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabecera con monto y tipo
                  _buildHeader(transaction, typeColor, typeIcon, textTheme),
                  
                  const SizedBox(height: 24),
                  
                  // Información general
                  _buildSection(
                    title: 'Información General',
                    icon: Icons.info_outline,
                    content: _buildGeneralInfo(transaction, textTheme),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Detalles de la transacción
                  _buildSection(
                    title: 'Detalles',
                    icon: Icons.receipt_long,
                    content: _buildTransactionDetails(transaction, textTheme),
                  ),
                  
                  // Si hay contacto asociado
                  if (_contact != null) ...[
                    const SizedBox(height: 16),
                    _buildSection(
                      title: 'Contacto',
                      icon: Icons.person_outline,
                      content: _buildContactInfo(textTheme),
                    ),
                  ],
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(
    TransactionEntry transaction,
    Color typeColor,
    IconData typeIcon,
    TextTheme textTheme,
  ) {
    return Card(
      elevation: 0,
      color: typeColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: typeColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  typeIcon,
                  size: 28,
                  color: typeColor,
                ),
                const SizedBox(width: 8),
                Text(
                  transaction.isIncome 
                      ? 'Ingreso' 
                      : transaction.isExpense 
                          ? 'Gasto' 
                          : 'Transferencia',
                  style: textTheme.titleLarge?.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                  .format(transaction.amount),
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: typeColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${transaction.currencyId} · ${DateFormat('dd/MM/yyyy').format(transaction.date)}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildGeneralInfo(TransactionEntry transaction, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoRow(
            label: 'Fecha',
            value: DateFormat('dd/MM/yyyy').format(transaction.date),
            icon: Icons.calendar_today,
          ),
          if (transaction.description != null && transaction.description!.isNotEmpty)
            _buildInfoRow(
              label: 'Descripción',
              value: transaction.description!,
              icon: Icons.description,
            ),
          _buildInfoRow(
            label: 'Número de Transacción',
            value: transaction.secuencial.toString().padLeft(6, '0'),
            icon: Icons.numbers,
          ),
          _buildInfoRow(
            label: 'Fecha de Creación',
            value: DateFormat('dd/MM/yyyy HH:mm').format(transaction.createdAt),
            icon: Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(TransactionEntry transaction, TextTheme textTheme) {
    final items = <Widget>[];

    // Cuenta origen
    if (_wallet != null) {
      items.add(
        _buildInfoRow(
          label: transaction.isTransfer ? 'Cuenta Origen' : 'Cuenta',
          value: _wallet!.name,
          icon: Icons.account_balance_wallet,
        ),
      );
    }

    // Cuenta destino (solo para transferencias)
    if (transaction.isTransfer && _targetWallet != null) {
      items.add(
        _buildInfoRow(
          label: 'Cuenta Destino',
          value: _targetWallet!.name,
          icon: Icons.account_balance_wallet,
        ),
      );
    }

    // Categoría (solo para ingresos y gastos)
    if (!transaction.isTransfer && _category != null) {
      items.add(
        _buildInfoRow(
          label: 'Categoría',
          value: _category!.name,
          icon: Icons.category,
        ),
      );
    }

    // Si es transferencia, mostrar montos de origen y destino
    if (transaction.isTransfer && transaction.details.length >= 2) {
      final sourceDetail = transaction.sourceDetail;
      final targetDetail = transaction.targetDetail;

      if (sourceDetail != null) {
        items.add(
          _buildInfoRow(
            label: 'Monto Origen',
            value: '${sourceDetail.amount} ${sourceDetail.currencyId}',
            icon: Icons.money,
          ),
        );
      }

      if (targetDetail != null) {
        items.add(
          _buildInfoRow(
            label: 'Monto Destino',
            value: '${targetDetail.amount} ${targetDetail.currencyId}',
            icon: Icons.money,
          ),
        );

        // Si hay tasa de cambio diferente a 1.0
        if (targetDetail.rateExchange != 1.0) {
          items.add(
            _buildInfoRow(
              label: 'Tasa de Cambio',
              value: '1 ${sourceDetail?.currencyId ?? ''} = ${targetDetail.rateExchange} ${targetDetail.currencyId}',
              icon: Icons.currency_exchange,
            ),
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildContactInfo(TextTheme textTheme) {
    if (_contact == null) return const SizedBox();
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoRow(
            label: 'Nombre',
            value: _contact!.name,
            icon: Icons.person,
          ),
          if (_contact!.email != null && _contact!.email!.isNotEmpty)
            _buildInfoRow(
              label: 'Email',
              value: _contact!.email!,
              icon: Icons.email,
            ),
          if (_contact!.phone != null && _contact!.phone!.isNotEmpty)
            _buildInfoRow(
              label: 'Teléfono',
              value: _contact!.phone!,
              icon: Icons.phone,
            ),
          if (_contact!.note != null && _contact!.note!.isNotEmpty)
            _buildInfoRow(
              label: 'Nota',
              value: _contact!.note!,
              icon: Icons.note,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
