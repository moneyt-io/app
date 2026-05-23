import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../core/organisms/account_selector_modal.dart' show SelectableAccount;

import '../../../core/utils/icon_to_emoji_mapper.dart';
import 'widgets/v2_account_selection_sheet.dart';
import 'widgets/v2_category_selection_sheet.dart';
import '../shared/widgets/v2_date_selection_sheet.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../core/providers/currency_provider.dart';
import '../../../core/utils/number_formatter.dart';

import '../../../domain/entities/transaction.dart';

class NewTransactionScreen extends StatefulWidget {
  final String initialType;
  final double? initialAmount;
  final String? initialDescription;
  final int? initialCategoryId;
  final int? initialWalletId;
  final int? transactionIdToEdit;
  final DateTime? initialDate;
  
  const NewTransactionScreen({
    super.key,
    this.initialType = 'E',
    this.initialAmount,
    this.initialDescription,
    this.initialCategoryId,
    this.initialWalletId,
    this.transactionIdToEdit,
    this.initialDate,
  });

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'E'; // 'E' for Expense, 'I' for Income
  
  SelectableAccount? _selectedAccount;
  int? _selectedCategoryId;

  List<Category> _categories = [];
  Map<int, SelectableAccount> _accountsMap = {};
  
  bool _isLoading = true;
  bool _isSaving = false;

  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType == 'all' ? 'E' : widget.initialType;
    if (_selectedType == 'T') _selectedType = 'E'; // Not handling transfer in this simplified MVP screen yet
    
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate!;
    }
    
    if (widget.initialAmount != null) {
      _amountController.text = widget.initialAmount.toString();
    }
    if (widget.initialDescription != null) {
      _descriptionController.text = widget.initialDescription!;
    }
    _selectedCategoryId = widget.initialCategoryId;
    
    _loadData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final walletsResult = await _walletUseCases.getAllWallets();
      final categoriesResult = await _categoryUseCases.getAllCategories();
      final creditCardResult = await GetIt.instance<CreditCardUseCases>().getAllCreditCards();

      final Map<int, SelectableAccount> accountsMap = {};
      for (final wallet in walletsResult) {
        if (wallet.active && wallet.parentId != null) {
          accountsMap[wallet.id] = SelectableAccount.fromWallet(wallet, balance: 0, accountNumber: '1234');
        }
      }
      for (final card in creditCardResult) {
        accountsMap[-card.id] = SelectableAccount.fromCreditCard(card, balance: 0, availableCredit: 0, cardNumber: '5678');
      }

      if (mounted) {
        setState(() {
          _categories = categoriesResult;
          _accountsMap = accountsMap;
          
          if (widget.initialWalletId != null && _accountsMap.containsKey(widget.initialWalletId!)) {
            _selectedAccount = _accountsMap[widget.initialWalletId!];
          } else if (_accountsMap.isNotEmpty) {
            _selectedAccount = _accountsMap.values.first;
          }
          
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await V2DateSelectionSheet.showSingle(
      context,
      initialDate: _selectedDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectAccount() async {
    final accounts = _accountsMap.values.toList();
    final result = await V2AccountSelectionSheet.show(
      context,
      accounts: accounts,
      initialSelection: _selectedAccount,
    );
    if (result != null) {
      setState(() => _selectedAccount = result);
    }
  }

  Future<void> _selectMoreCategories() async {
    // Solo mostrar las que sean del tipo seleccionado y preferiblemente hijas si hay agupamiento root
    // Para no romper legacy y ser V2, usamos parentId != null (o todas para estar seguros)
    // El filtro base es por tipo de documento.
    final availableCategories = _categories
        .where((c) => c.documentTypeId == _selectedType && c.parentId != null)
        .toList();

    final currentSelection = _selectedCategoryId != null
        ? availableCategories.where((c) => c.id == _selectedCategoryId).firstOrNull
        : null;

    final result = await V2CategorySelectionSheet.show(
      context,
      categories: availableCategories,
      initialSelection: currentSelection,
    );

    if (result != null) {
      setState(() {
        _selectedCategoryId = result.id;
      });
    }
  }

  void _toggleType() {
    setState(() {
      _selectedType = _selectedType == 'E' ? 'I' : 'E';
      _selectedCategoryId = null; // reset category on type change
    });
  }

  String _getDateLabel() {
    final now = DateTime.now();
    if (_selectedDate.year == now.year && _selectedDate.month == now.month && _selectedDate.day == now.day) {
      return "Hoy";
    }
    return DateFormat('dd MMM').format(_selectedDate);
  }

  Future<void> _saveTransaction() async {
    final amountText = _amountController.text.replaceAll(',', '');
    final amount = double.tryParse(amountText) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, ingresa un monto válido.')));
      return;
    }
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, selecciona una cuenta.')));
      return;
    }
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, selecciona una categoría.')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final transactionProvider = context.read<TransactionProvider>();
      
      int paymentId;
      String paymentTypeId;

      if (_selectedAccount!.isCreditCard) {
        paymentId = _selectedAccount!.id; // Needs mapping if credit card IDs are negative
        if (paymentId < 0) paymentId = -paymentId; // Fix if using negative IDs
        paymentTypeId = 'C';
      } else {
        paymentId = _selectedAccount!.id;
        paymentTypeId = 'W';
      }

      if (widget.transactionIdToEdit != null) {
        // Update existing transaction (replicating legacy mapping exactly)
        final updatedEntity = TransactionEntity(
          id: widget.transactionIdToEdit,
          type: _selectedType, // Document Type ('E' or 'I')
          flow: _selectedType == 'E' ? 'F' : 'T', // Flow ('F' for expenses, 'T' for incomes)
          amount: amount,
          accountId: paymentId,
          categoryId: _selectedCategoryId,
          description: _descriptionController.text,
          transactionDate: _selectedDate,
        );
        await transactionProvider.updateTransaction(updatedEntity);
      } else {
        // Create new transaction
        if (_selectedType == 'E') {
          await transactionProvider.createExpense(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            paymentId: paymentId,
            paymentTypeId: paymentTypeId,
            categoryId: _selectedCategoryId!,
          );
        } else {
          await transactionProvider.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            walletId: paymentId,
            categoryId: _selectedCategoryId!,
          );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.transactionIdToEdit != null ? 'Transacción actualizada.' : 'Transacción guardada exitosamente.')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (_isLoading) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
          title: Text(widget.transactionIdToEdit != null ? "Editar Transacción" : "Nueva Transacción"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Get up to 7 categories for the current type
    final typeCategories = _categories.where((c) => c.documentTypeId == _selectedType && c.parentId != null).toList();
    final displayCategories = typeCategories.take(7).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.transactionIdToEdit != null ? "Editar Transacción" : "Nueva Transacción"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Selectors
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildMetaPill(context, _getDateLabel(), Icons.calendar_today, _selectDate),
                      _buildMetaPill(
                        context, 
                        _selectedAccount?.name ?? "Seleccionar Billetera", 
                        Icons.account_balance_wallet_outlined, 
                        _selectAccount
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  
                  // Amount Entry
                  Text(
                    "MONTO",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        NumberFormatter.getSymbol(context.watch<CurrencyProvider>().currencyId),
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          autofocus: true,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: _selectedType == 'E' ? theme.colorScheme.error : const Color(0xFF00714D),
                          ),
                          decoration: InputDecoration(
                            hintText: "0.00",
                            hintStyle: theme.textTheme.displayLarge?.copyWith(
                              color: theme.colorScheme.surfaceContainerHighest,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSubtleTypeToggle(context),
                  const SizedBox(height: 40),
                  
                  // Description Entry
                  Text(
                    "DESCRIPCIÓN",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _descriptionController,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                    decoration: InputDecoration(
                      hintText: "Agregar nota...",
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Category Selection
                  Text(
                    "CATEGORÍA",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ...displayCategories.map((c) => _buildCategoryPill(
                            context,
                            IconToEmojiMapper.getEmoji(c.icon),
                            c.name,
                            _selectedCategoryId == c.id,
                            () => setState(() => _selectedCategoryId = c.id),
                          )),
                      // More Categories Button
                      _buildAddCategoryButton(context, _selectMoreCategories),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Action Bar
          Container(
            padding: EdgeInsets.only(
              left: 20, 
              right: 20, 
              top: 16, 
              bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 16 : MediaQuery.of(context).padding.bottom + 16
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
                    ),
                    child: _isSaving
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Guardar",
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtleTypeToggle(BuildContext context) {
    final theme = Theme.of(context);
    final isExpense = _selectedType == 'E';
    
    return GestureDetector(
      onTap: _toggleType,
      child: Container(
        width: 200,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isExpense ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 96,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: isExpense ? theme.colorScheme.error : theme.colorScheme.outline,
                        fontWeight: isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: const Text("Gasto"),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: !isExpense ? const Color(0xFF00714D) : theme.colorScheme.outline,
                        fontWeight: !isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: const Text("Ingreso"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaPill(BuildContext context, String label, IconData icon, VoidCallback onTap, {Color? color, Color? textColor}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: textColor ?? theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Icon(icon, size: 18, color: textColor ?? theme.colorScheme.onSurface),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCategoryButton(BuildContext context, VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_horiz, color: theme.colorScheme.outline, size: 20),
            const SizedBox(width: 4),
            Text("Más", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(BuildContext context, String emoji, String label, bool selected, VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected 
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          boxShadow: selected ? [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
