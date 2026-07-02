import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/enums/recurrence_frequency.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;

import '../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../core/utils/financial_emoji_dictionary.dart';
import '../../../core/services/ai_transaction_service.dart';
import 'dart:async';
import 'widgets/v2_account_selection_sheet.dart';
import 'widgets/v2_category_selection_sheet.dart';
import 'widgets/v2_recurrence_sheet.dart';
import '../shared/widgets/v2_date_selection_sheet.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../core/providers/currency_provider.dart';
import '../../features/wallets/wallet_provider.dart';
import '../../../core/utils/number_formatter.dart';
import '../../core/l10n/generated/strings.g.dart';

import '../../../domain/entities/transaction.dart';

class NewTransactionScreen extends StatefulWidget {
  final String initialType;
  final double? initialAmount;
  final String? initialDescription;
  final int? initialCategoryId;
  final List<AICategorySuggestionItem>? initialCategorySuggestions;
  final int? initialWalletId;
  final int? transactionIdToEdit;
  final DateTime? initialDate;
  final bool autoOpenKeyboard;
  final String? initialRecurrenceFrequency; // e.g. 'monthly', 'weekly', etc.

  const NewTransactionScreen({
    super.key,
    this.initialType = 'E',
    this.initialAmount,
    this.initialDescription,
    this.initialCategoryId,
    this.initialCategorySuggestions,
    this.initialWalletId,
    this.transactionIdToEdit,
    this.initialDate,
    this.autoOpenKeyboard = true,
    this.initialRecurrenceFrequency,
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

  // Para manejar categorías sugeridas por IA
  String? _pendingSuggestedCategoryName;
  List<AICategorySuggestionItem> _aiCategorySuggestions = [];
  Timer? _debounceTimer;
  bool _hasManuallySelectedCategory = false;
  bool _isAnalyzingCategory = false;

  // Recurrence frequency (null = not recurring)
  RecurrenceFrequency? _selectedRecurrence;

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
    if (_selectedType == 'T')
      _selectedType =
          'E'; // Not handling transfer in this simplified MVP screen yet

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

    if (widget.initialCategorySuggestions != null && widget.initialCategorySuggestions!.isNotEmpty) {
      _aiCategorySuggestions = List.from(widget.initialCategorySuggestions!);
      // Auto select the first one
      final first = _aiCategorySuggestions.first;
      if (first.categoryId != null) {
        _selectedCategoryId = first.categoryId;
      } else if (first.newCategoryName != null) {
        _pendingSuggestedCategoryName = first.newCategoryName;
      }
    }

    // Restore recurrence frequency if editing an existing recurring transaction
    if (widget.initialRecurrenceFrequency != null) {
      _selectedRecurrence =
          RecurrenceFrequency.fromKey(widget.initialRecurrenceFrequency);
    }

    _loadData();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    // Read providers synchronously before async calls
    final walletProvider = context.read<WalletProvider>();
    final txProvider = context.read<TransactionProvider>();
    
    try {
      final walletsResult = await _walletUseCases.getAllWallets();
      final categoriesResult = await _categoryUseCases.getAllCategories();
      final creditCardResult =
          await GetIt.instance<CreditCardUseCases>().getAllCreditCards();

      final Map<int, SelectableAccount> accountsMap = {};
      for (final wallet in walletsResult) {
        if (wallet.active && wallet.parentId != null) {
          accountsMap[wallet.id] = SelectableAccount.fromWallet(wallet,
              balance: walletProvider.walletBalances[wallet.id] ?? 0.0,
              accountNumber: '1234');
        }
      }
      for (final card in creditCardResult) {
        accountsMap[-card.id] = SelectableAccount.fromCreditCard(card,
            balance: 0, availableCredit: 0, cardNumber: '5678');
      }

      if (mounted) {
        setState(() {
          _categories = categoriesResult;
          _accountsMap = accountsMap;

          if (widget.initialWalletId != null &&
              _accountsMap.containsKey(widget.initialWalletId!)) {
            _selectedAccount = _accountsMap[widget.initialWalletId!];
          } else if (_accountsMap.isNotEmpty) {
            // Find most used wallet in recent transactions
            final txs = txProvider.transactions;
            int? mostUsedId;
            
            if (txs.isNotEmpty) {
              final Map<int, int> frequencies = {};
              for (final t in txs) {
                if (t.details.isNotEmpty && t.details.first.paymentTypeId == 'W') {
                  final pid = t.details.first.paymentId;
                  if (_accountsMap.containsKey(pid)) {
                    frequencies[pid] = (frequencies[pid] ?? 0) + 1;
                  }
                }
              }
              if (frequencies.isNotEmpty) {
                final sorted = frequencies.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));
                mostUsedId = sorted.first.key;
              }
            }
            
            if (mostUsedId != null) {
              _selectedAccount = _accountsMap[mostUsedId];
            } else {
              _selectedAccount = _accountsMap.values.first;
            }
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


  void _onDescriptionChanged(String text) {
    _debounceTimer?.cancel();
    if (_hasManuallySelectedCategory) return;
    
    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      if (text.trim().isNotEmpty) {
        _analyzeDescriptionWithAI(text.trim());
      }
    });
  }

  Future<void> _analyzeDescriptionWithAI(String description) async {
    if (!mounted) return;
    setState(() => _isAnalyzingCategory = true);
    
    final service = AITransactionService();
    // Enviar todas las categorías hijas del tipo actual
    final typeCategories = _categories.where((c) => c.documentTypeId == _selectedType && c.parentId != null).toList();
    
    final results = await service.suggestCategoriesForTransaction(description, typeCategories);
    
    if (mounted && results.isNotEmpty && !_hasManuallySelectedCategory) {
      setState(() {
        _aiCategorySuggestions = results;
        final first = results.first;
        if (first.categoryId != null) {
          _selectedCategoryId = first.categoryId;
          _pendingSuggestedCategoryName = null;
        } else if (first.newCategoryName != null) {
          _selectedCategoryId = null;
          _pendingSuggestedCategoryName = first.newCategoryName;
        }
        _isAnalyzingCategory = false;
      });
    } else if (mounted) {
      setState(() => _isAnalyzingCategory = false);
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

  // Opens the recurrence bottom sheet
  Future<void> _selectRecurrence() async {
    final result = await V2RecurrenceSheet.show(
      context,
      currentFrequency: _selectedRecurrence,
    );
    // sheet returns null when user picks "No repeat"; only update when sheet was not dismissed
    if (mounted) {
      setState(() => _selectedRecurrence = result);
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
        ? availableCategories
            .where((c) => c.id == _selectedCategoryId)
            .firstOrNull
        : null;

    final result = await V2CategorySelectionSheet.show(
      context,
      categories: availableCategories,
      initialSelection: currentSelection,
    );

    final newCats = await _categoryUseCases.getAllCategories();
    if (mounted) {
      setState(() {
        _categories = newCats;
        if (result != null) {
          _selectedCategoryId = result.id;
        }
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
    if (_selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day) {
      return t.v2.transactions.today;
    }
    return DateFormat('dd MMM').format(_selectedDate);
  }

  Future<void> _saveTransaction() async {
    final amountText = _amountController.text.replaceAll(',', '');
    final amount = double.tryParse(amountText) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.invalidAmount)));
      return;
    }
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.selectAccount)));
      return;
    }
    if (_selectedCategoryId == null && _pendingSuggestedCategoryName == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(t.v2.transactions.selectCategory)));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final transactionProvider = context.read<TransactionProvider>();

      // Crear la categoría virtual si es necesario
      if (_selectedCategoryId == null &&
          _pendingSuggestedCategoryName != null) {
        try {
          final allCats = await _categoryUseCases.getAllCategories();
          final rootName = _selectedType == 'E' ? 'Expense' : 'Income';
          Category? root = allCats
              .where((c) =>
                  c.parentId == null &&
                  c.name == rootName &&
                  c.documentTypeId == _selectedType)
              .firstOrNull;

          if (root == null) {
            final newRoot = Category(
              id: 0,
              name: rootName,
              documentTypeId: _selectedType,
              chartAccountId: 0,
              icon: Icons.folder.codePoint.toString(),
              active: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            root = await _categoryUseCases.createCategory(newRoot);
          }

          final emoji = FinancialEmojiDictionary.getEmojiForKeyword(
                  _pendingSuggestedCategoryName!) ??
              '🏷️';

          final newCat = Category(
            id: 0,
            name: _pendingSuggestedCategoryName!,
            documentTypeId: _selectedType,
            parentId: root.id,
            chartAccountId: 0,
            icon: emoji,
            active: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          final createdCategory =
              await _categoryUseCases.createCategory(newCat);
          _selectedCategoryId = createdCategory.id;

          // Actualizar el provider para que las demás vistas (como Dashboard y la lista de transacciones)
          // reconozcan la nueva categoría y no la muestren como "Otros"
          await transactionProvider.refreshCategories();

          // Limpiamos el pendiente
          _pendingSuggestedCategoryName = null;
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.v2.transactions.errorCreatingCategory(error: e.toString()))));
            setState(() => _isSaving = false);
          }
          return;
        }
      }

      int paymentId;
      String paymentTypeId;

      if (_selectedAccount!.isCreditCard) {
        paymentId = _selectedAccount!
            .id; // Needs mapping if credit card IDs are negative
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
          flow: _selectedType == 'E'
              ? 'F'
              : 'T', // Flow ('F' for expenses, 'T' for incomes)
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
            recurrenceFrequency: _selectedRecurrence?.key,
          );
        } else {
          await transactionProvider.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            walletId: paymentId,
            categoryId: _selectedCategoryId!,
            recurrenceFrequency: _selectedRecurrence?.key,
          );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.transactionIdToEdit != null
                ? t.v2.transactions.transactionUpdated
                : t.v2.transactions.transactionSaved)));
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.v2.transactions.error(error: e.toString()))));
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
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(widget.transactionIdToEdit != null
              ? t.v2.transactions.editTransaction
              : t.v2.transactions.newTransaction),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Get up to 7 categories for the current type
    final typeCategories = _categories
        .where((c) => c.documentTypeId == _selectedType && c.parentId != null)
        .toList();
    final displayCategories = typeCategories.take(7).toList();

    // Ensure selected category is always in the display list
    if (_selectedCategoryId != null &&
        !displayCategories.any((c) => c.id == _selectedCategoryId)) {
      // Buscar en _categories sin importar el tipo, por si la IA se equivocó de tipo
      final selectedCat =
          _categories.where((c) => c.id == _selectedCategoryId).firstOrNull;
      if (selectedCat != null) {
        if (displayCategories.length >= 7) {
          displayCategories.removeLast(); // Keep size to 7
        }
        displayCategories.insert(0, selectedCat);
      }
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.transactionIdToEdit != null
            ? t.v2.transactions.editTransaction
            : t.v2.transactions.newTransaction),
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
                      _buildMetaPill(context, _getDateLabel(),
                          Icons.calendar_today, _selectDate),
                      // Recurrence chip — only shown when a frequency is selected
                      if (_selectedRecurrence != null)
                        _buildMetaPill(
                          context,
                          '${_selectedRecurrence!.emoji} ${_recurrenceLabel(_selectedRecurrence!)}',
                          null,
                          _selectRecurrence,
                          isActive: true,
                        )
                      else
                        _buildMetaPill(
                          context,
                          t.v2.transactions.recurrence,
                          Icons.repeat,
                          _selectRecurrence,
                        ),
                      _buildMetaPill(
                          context,
                          _selectedAccount?.name ?? t.v2.transactions.selectWallet,
                          Icons.account_balance_wallet_outlined,
                          _selectAccount),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Amount Entry
                  Text(
                    t.v2.transactions.amount,
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
                        _selectedAccount != null 
                            ? NumberFormatter.getSymbol(_selectedAccount!.currencyId)
                            : NumberFormatter.getSymbol(context.watch<CurrencyProvider>().currencyId),
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          autofocus: widget.autoOpenKeyboard,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: _selectedType == 'E'
                                ? theme.colorScheme.error
                                : const Color(0xFF00714D),
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
                    t.v2.transactions.description,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _descriptionController,
                    onChanged: _onDescriptionChanged,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: t.v2.transactions.addNote,
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.outlineVariant
                            .withValues(alpha: 0.6),
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
                    t.v2.transactions.category,
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
                      if (_isAnalyzingCategory)
                         const AILoadingPill(),
                         
                      if (_aiCategorySuggestions.isNotEmpty)
                        ..._aiCategorySuggestions.map((sugg) {
                          final isSelected = (sugg.categoryId != null && _selectedCategoryId == sugg.categoryId) ||
                                             (sugg.newCategoryName != null && _pendingSuggestedCategoryName == sugg.newCategoryName);
                                             
                          if (sugg.categoryId != null) {
                            final cat = _categories.where((c) => c.id == sugg.categoryId).firstOrNull;
                            if (cat == null) return const SizedBox.shrink();
                            return _buildCategoryPill(
                              context,
                              IconToEmojiMapper.getEmoji(cat.icon),
                              cat.name,
                              isSelected,
                              () => setState(() {
                                _selectedCategoryId = cat.id;
                                _pendingSuggestedCategoryName = null;
                                _hasManuallySelectedCategory = true;
                              }),
                            );
                          } else if (sugg.newCategoryName != null) {
                            return _buildSuggestedCategoryPill(
                              context, 
                              sugg.newCategoryName!,
                              isSelected: isSelected,
                              onTap: () => setState(() {
                                _selectedCategoryId = null;
                                _pendingSuggestedCategoryName = sugg.newCategoryName;
                                _hasManuallySelectedCategory = true;
                              }),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        
                      if (_aiCategorySuggestions.isEmpty && _pendingSuggestedCategoryName != null)
                        _buildSuggestedCategoryPill(
                            context, _pendingSuggestedCategoryName!),
                      
                      if (_aiCategorySuggestions.isEmpty)
                        ...displayCategories.map((c) => _buildCategoryPill(
                              context,
                              IconToEmojiMapper.getEmoji(c.icon),
                              c.name,
                              _selectedCategoryId == c.id,
                              () => setState(() {
                                _selectedCategoryId = c.id;
                                _pendingSuggestedCategoryName = null;
                                _hasManuallySelectedCategory = true;
                              }),
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
                bottom: MediaQuery.of(context).viewInsets.bottom > 0
                    ? 16
                    : MediaQuery.of(context).padding.bottom + 16),
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: _isSaving
                          ? null
                          : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                            ),
                      color: _isSaving ? const Color(0xFF2B63F1).withValues(alpha: 0.5) : null,
                      boxShadow: _isSaving
                          ? null
                          : [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveTransaction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                t.v2.transactions.save,
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
          color:
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment:
                  isExpense ? Alignment.centerLeft : Alignment.centerRight,
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
                        color: isExpense
                            ? theme.colorScheme.error
                            : theme.colorScheme.outline,
                        fontWeight:
                            isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: Text(t.v2.transactions.expense),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: !isExpense
                            ? const Color(0xFF00714D)
                            : theme.colorScheme.outline,
                        fontWeight:
                            !isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: Text(t.v2.transactions.income),
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

  Widget _buildMetaPill(
      BuildContext context, String label, IconData? icon, VoidCallback onTap,
      {Color? color, Color? textColor, bool isActive = false}) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final pillColor = isActive
        ? activeColor.withValues(alpha: 0.12)
        : color ?? theme.colorScheme.surfaceContainerLow;
    final pillBorder = isActive
        ? activeColor.withValues(alpha: 0.6)
        : theme.colorScheme.outlineVariant.withValues(alpha: 0.3);
    final contentColor = isActive
        ? activeColor
        : textColor ?? theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: pillColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: pillBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: contentColor,
                fontWeight: isActive ? FontWeight.w700 : null,
              ),
            ),
            if (icon != null) ...
              [
                const SizedBox(width: 4),
                Icon(icon, size: 18, color: contentColor),
              ],
          ],
        ),
      ),
    );
  }

  /// Returns the i18n label for the given [RecurrenceFrequency].
  String _recurrenceLabel(RecurrenceFrequency freq) {
    final t = context.t;
    switch (freq) {
      case RecurrenceFrequency.daily:     return t.v2.transactions.recurrenceDaily;
      case RecurrenceFrequency.weekly:    return t.v2.transactions.recurrenceWeekly;
      case RecurrenceFrequency.monthly:   return t.v2.transactions.recurrenceMonthly;
      case RecurrenceFrequency.bimonthly: return t.v2.transactions.recurrenceBimonthly;
      case RecurrenceFrequency.quarterly: return t.v2.transactions.recurrenceQuarterly;
      case RecurrenceFrequency.yearly:    return t.v2.transactions.recurrenceYearly;
    }
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
          border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_horiz, color: theme.colorScheme.outline, size: 20),
            const SizedBox(width: 4),
            Text(t.v2.transactions.more,
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.outline)),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedCategoryPill(BuildContext context, String name, {bool isSelected = false, VoidCallback? onTap}) {
    final theme = Theme.of(context);
    final emoji = FinancialEmojiDictionary.getEmojiForKeyword(name) ?? '✨';
    final selected = isSelected || (_aiCategorySuggestions.isEmpty && _selectedCategoryId == null);

    return GestureDetector(
      onTap: onTap ?? () {
        setState(() {
          _selectedCategoryId = null; // Volver a seleccionarla
          _pendingSuggestedCategoryName = name;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? null
                  : theme.colorScheme.surfaceContainerLow,
              gradient: selected
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    )
                  : null,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected
                    ? Colors.transparent
                    : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 6),
                Text(
                  name,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: selected
                        ? Colors.white
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white
                    : const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                "NUEVO",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: selected
                      ? const Color(0xFF1D4ED8)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPill(BuildContext context, String emoji, String label,
      bool selected, VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? null
              : theme.colorScheme.surfaceContainerLow,
          gradient: selected
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                )
              : null,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? Colors.transparent
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected
                    ? Colors.white
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AILoadingPill extends StatefulWidget {
  const AILoadingPill({super.key});

  @override
  State<AILoadingPill> createState() => _AILoadingPillState();
}

class _AILoadingPillState extends State<AILoadingPill> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)], // Morado a Azul AI
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
             BoxShadow(
               color: const Color(0xFF8B5CF6).withValues(alpha: 0.3), 
               blurRadius: 8, 
               offset: const Offset(0, 4)
             )
          ]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('✨', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              'Analizando...', 
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              )
            ),
          ],
        ),
      ),
    );
  }
}

