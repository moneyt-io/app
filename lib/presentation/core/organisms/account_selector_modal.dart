import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/credit_card.dart';
import '../atoms/app_button.dart';
import '../molecules/search_field.dart';
import '../design_system/theme/app_dimensions.dart';

/// Modelo para representar una cuenta seleccionable
/// (ya sea wallet o tarjeta de crédito)
class SelectableAccount {
  final int id;
  final String name;
  final String? description;
  final String currencyId;
  final bool isCreditCard;
  final double? balance;
  
  const SelectableAccount({
    required this.id,
    required this.name,
    this.description,
    required this.currencyId,
    required this.isCreditCard,
    this.balance,
  });
  
  factory SelectableAccount.fromWallet(Wallet wallet, {double? balance}) {
    return SelectableAccount(
      id: wallet.id,
      name: wallet.name,
      description: wallet.description,
      currencyId: wallet.currencyId,
      isCreditCard: false,
      balance: balance,
    );
  }
  
  factory SelectableAccount.fromCreditCard(CreditCard creditCard, {double? balance}) {
    return SelectableAccount(
      id: creditCard.id,
      name: creditCard.name,
      description: creditCard.description,
      currencyId: creditCard.currencyId,
      isCreditCard: true,
      balance: balance,
    );
  }
}

/// Modal para seleccionar una cuenta (wallet o tarjeta de crédito)
class AccountSelectorModal extends StatefulWidget {
  final List<SelectableAccount> accounts;
  final String title;
  final String confirmButtonText;
  final SelectableAccount? initialSelection;
  
  const AccountSelectorModal({
    Key? key,
    required this.accounts,
    this.title = 'Seleccionar cuenta',
    this.confirmButtonText = 'Confirmar',
    this.initialSelection,
  }) : super(key: key);
  
  /// Método estático para mostrar el modal y obtener la cuenta seleccionada
  static Future<SelectableAccount?> show({
    required BuildContext context,
    required List<SelectableAccount> accounts,
    String title = 'Seleccionar cuenta',
    String confirmButtonText = 'Confirmar',
    SelectableAccount? initialSelection,
  }) async {
    return await showModalBottomSheet<SelectableAccount>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AccountSelectorModal(
        accounts: accounts,
        title: title,
        confirmButtonText: confirmButtonText,
        initialSelection: initialSelection,
      ),
    );
  }
  
  @override
  State<AccountSelectorModal> createState() => _AccountSelectorModalState();
}

class _AccountSelectorModalState extends State<AccountSelectorModal> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  SelectableAccount? _selectedAccount;
  
  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.initialSelection;
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  // Filtrar cuentas por búsqueda
  List<SelectableAccount> get _filteredAccounts {
    if (_searchQuery.isEmpty) {
      return widget.accounts;
    }
    return widget.accounts.where((account) {
      return account.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (account.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();
  }
  
  // Organizar cuentas por tipo (wallets y tarjetas)
  Map<String, List<SelectableAccount>> get _organizedAccounts {
    final wallets = <SelectableAccount>[];
    final creditCards = <SelectableAccount>[];
    
    for (final account in _filteredAccounts) {
      if (account.isCreditCard) {
        creditCards.add(account);
      } else {
        wallets.add(account);
      }
    }
    
    return {
      'Billeteras': wallets,
      'Tarjetas de Crédito': creditCards,
    };
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final maxHeight = MediaQuery.of(context).size.height * 0.85;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLarge),
          topRight: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra superior con título y botón de cerrar
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.spacing16,
              AppDimensions.spacing16,
              AppDimensions.spacing16, 
              AppDimensions.spacing8
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          
          // Barra de búsqueda
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.spacing16,
              AppDimensions.spacing8,
              AppDimensions.spacing16,
              AppDimensions.spacing16,
            ),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar cuentas...',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Lista de cuentas
          Flexible(
            child: _filteredAccounts.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.spacing24),
                    child: Text(
                      'No se encontraron cuentas',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
                  shrinkWrap: true,
                  children: [
                    // Para cada tipo de cuenta (wallet, tarjeta)
                    for (final entry in _organizedAccounts.entries)
                      if (entry.value.isNotEmpty) ...[
                        // Encabezado de la sección
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppDimensions.spacing8,
                            bottom: AppDimensions.spacing8,
                            left: AppDimensions.spacing8,
                          ),
                          child: Text(
                            entry.key,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        // Items de la sección
                        ...entry.value.map((account) => _buildAccountItem(account)),
                        
                        SizedBox(height: AppDimensions.spacing16),
                      ],
                  ],
                ),
          ),
          
          // Botón de confirmar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              child: AppButton(
                text: widget.confirmButtonText,
                onPressed: _selectedAccount != null
                  ? () => Navigator.of(context).pop(_selectedAccount)
                  : null,
                type: AppButtonType.primary,
                isFullWidth: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Construir un ítem de cuenta (wallet o tarjeta)
  Widget _buildAccountItem(SelectableAccount account) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final isSelected = _selectedAccount?.id == account.id && 
                      _selectedAccount?.isCreditCard == account.isCreditCard;
    
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: AppDimensions.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: BorderSide(
          color: isSelected
            ? colorScheme.primary
            : colorScheme.outline.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedAccount = account;
          });
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacing12),
          child: Row(
            children: [
              // Icono (diferente para wallets y tarjetas)
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: account.isCreditCard
                    ? colorScheme.secondaryContainer
                    : colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  account.isCreditCard
                    ? Icons.credit_card
                    : Icons.account_balance_wallet,
                  color: account.isCreditCard
                    ? colorScheme.onSecondaryContainer
                    : colorScheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeSmall,
                ),
              ),
              SizedBox(width: AppDimensions.spacing12),
              
              // Información de la cuenta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (account.description != null && account.description!.isNotEmpty) ...[
                      SizedBox(height: AppDimensions.spacing2),
                      Text(
                        account.description!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              
              // Verificación si está seleccionado
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                  size: AppDimensions.iconSizeMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
