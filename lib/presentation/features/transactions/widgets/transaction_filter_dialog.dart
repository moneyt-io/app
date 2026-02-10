import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import 'package:moneyt_pfm/domain/entities/category.dart';
import 'package:moneyt_pfm/domain/entities/contact.dart';
import 'package:moneyt_pfm/domain/entities/wallet.dart';
import 'package:moneyt_pfm/domain/usecases/category_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/contact_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/wallet_usecases.dart';
import 'package:moneyt_pfm/presentation/core/atoms/app_app_bar.dart';
import 'package:moneyt_pfm/presentation/core/atoms/app_floating_label_field.dart';
import 'package:moneyt_pfm/presentation/core/atoms/app_floating_label_selector.dart';
import 'package:moneyt_pfm/presentation/core/formatters/currency_input_formatter.dart';
import 'package:moneyt_pfm/presentation/core/molecules/form_action_bar.dart';
import 'package:moneyt_pfm/presentation/core/organisms/account_selector_modal.dart'
    show SelectableAccount;
import 'package:moneyt_pfm/presentation/features/categories/widgets/category_selection_dialog.dart'
    as cat_dialog;
import 'package:moneyt_pfm/presentation/features/contacts/widgets/contact_selection_dialog.dart'
    as contact_dialog;
import 'package:moneyt_pfm/presentation/core/molecules/date_selection_dialog.dart';
import '../../../core/l10n/generated/strings.g.dart';
import '../models/transaction_filter_model.dart';
import 'account_selection_dialog.dart';
import '../../../core/molecules/transaction_type_selection_item.dart';

class TransactionFilterDialog extends StatefulWidget {
  final TransactionFilterModel initialFilter;

  const TransactionFilterDialog({super.key, required this.initialFilter});

  @override
  State<TransactionFilterDialog> createState() =>
      _TransactionFilterDialogState();
}

class _TransactionFilterDialogState extends State<TransactionFilterDialog> {
  late TransactionFilterModel _currentFilter;
  final _minAmountController = TextEditingController();
  final _maxAmountController = TextEditingController();

  bool _isLoading = true;
  List<Category> _categories = [];
  List<Contact> _contacts = [];
  Map<int, Wallet> _walletsMap = {};

  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter;
    _minAmountController.text = _currentFilter.minAmount?.toString() ?? '';
    _maxAmountController.text = _currentFilter.maxAmount?.toString() ?? '';
    _loadData();
  }

  @override
  void dispose() {
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final walletsResult = await _walletUseCases.getAllWallets();
      final categoriesResult = await _categoryUseCases.getAllCategories();
      final contactsResult = await _contactUseCases.getAllContacts();

      final walletsMap = {for (var wallet in walletsResult) wallet.id: wallet};

      if (mounted) {
        setState(() {
          _categories = categoriesResult;
          _contacts = contactsResult;
          _walletsMap = walletsMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error loading data: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  void _onQuickFilterSelected(QuickDateFilter filter) {
    // Usamos la fecha local para determinar el día, mes y año actual del usuario.
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    switch (filter) {
      case QuickDateFilter.thisMonth:
        // Creamos el rango en UTC para que coincida con la BD.
        startDate = DateTime.utc(now.year, now.month, 1);
        // El final del mes es el inicio del siguiente mes en UTC.
        endDate = DateTime.utc(now.year, now.month + 1, 1).subtract(const Duration(microseconds: 1));
        break;
      case QuickDateFilter.lastMonth:
        startDate = DateTime.utc(now.year, now.month - 1, 1);
        endDate = DateTime.utc(now.year, now.month, 1).subtract(const Duration(microseconds: 1));
        break;
      case QuickDateFilter.thisYear:
        startDate = DateTime.utc(now.year, 1, 1);
        endDate = DateTime.utc(now.year + 1, 1, 1).subtract(const Duration(microseconds: 1));
        break;
      case QuickDateFilter.lastYear:
        startDate = DateTime.utc(now.year - 1, 1, 1);
        endDate = DateTime.utc(now.year - 1, 12, 31, 23, 59, 59);
        break;
      case QuickDateFilter.custom:
        return;
    }

    setState(() {
      _currentFilter = _currentFilter.copyWith(
        quickDateFilter: filter,
        startDate: startDate,
        endDate: endDate,
      );
    });
  }

  Widget _buildQuickDateFilters() {
    final Map<QuickDateFilter, String> filterLabels = {
      QuickDateFilter.thisMonth: t.transactions.filter.ranges.thisMonth,
      QuickDateFilter.lastMonth: t.transactions.filter.ranges.lastMonth,
      QuickDateFilter.thisYear: t.transactions.filter.ranges.thisYear,
      QuickDateFilter.lastYear: t.transactions.filter.ranges.lastYear,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.transactions.filter.quickFilters,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155), // slate-700
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3.5, // Adjust aspect ratio for button height
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: filterLabels.entries.map((entry) {
            final filter = entry.key;
            final label = entry.value;
            final bool isActive = _currentFilter.quickDateFilter == filter;

            return OutlinedButton(
              onPressed: () => _onQuickFilterSelected(filter),
              style: OutlinedButton.styleFrom(
                foregroundColor: isActive
                    ? const Color(0xFF1D4ED8)
                    : const Color(0xFF475569), // blue-700 : slate-600
                backgroundColor: isActive
                    ? const Color(0xFFEFF6FF)
                    : const Color(0xFFF1F5F9), // blue-100 : slate-100
                side: BorderSide(
                  color: isActive
                      ? const Color(0xFFBFDBFE)
                      : const Color(0xFFE2E8F0), // blue-200 : slate-200
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: Text(label),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _selectCategory() async {
    final selectableCategories = _categories.map((c) {
      final isIncome = c.documentTypeId == 'I';
      return cat_dialog.SelectableCategory(
        id: c.id.toString(),
        name: c.name,
        parentId: c.parentId?.toString(),
        isIncome: isIncome,
        icon: isIncome ? Icons.arrow_upward : Icons.arrow_downward,
        iconColor: isIncome ? Colors.green.shade600 : Colors.red.shade600,
        iconBgColor: isIncome ? Colors.green.shade100 : Colors.red.shade100,
      );
    }).toList();

    final currentSelection = _currentFilter.category != null
        ? selectableCategories.firstWhereOrNull(
            (sc) => sc.id == _currentFilter.category!.id.toString())
        : null;

    final result = await cat_dialog.CategorySelectionDialog.show(context,
        categories: selectableCategories, initialSelection: currentSelection);

    if (result != null) {
      setState(() {
        _currentFilter = _currentFilter.copyWith(
            category:
                _categories.firstWhere((c) => c.id.toString() == result.id));
      });
    }
  }

  Future<void> _selectAccount() async {
    final selectableAccounts = _walletsMap.values
        .map((w) =>
            SelectableAccount.fromWallet(w, balance: 0, accountNumber: ''))
        .toList();

    final initialSelection = _currentFilter.account != null
        ? selectableAccounts
            .firstWhereOrNull((sa) => sa.id == _currentFilter.account!.id)
        : null;

    final result = await AccountSelectionDialog.show(
      context,
      accounts: selectableAccounts,
      initialSelection: initialSelection,
    );

    if (result != null) {
      final selectedWallet = _walletsMap[result.id];
      setState(() =>
          _currentFilter = _currentFilter.copyWith(account: selectedWallet));
    }
  }

  void _onTransactionTypeSelected(TransactionType type) {
    setState(() {
      final newTypes =
          Set<TransactionType>.from(_currentFilter.transactionTypes);
      if (newTypes.contains(type)) {
        newTypes.remove(type);
      } else {
        newTypes.add(type);
      }
      _currentFilter = _currentFilter.copyWith(transactionTypes: newTypes);
    });
  }

  Future<void> _selectContact() async {
    final selectableContacts = _contacts
        .map((c) =>
            contact_dialog.SelectableContact(id: c.id.toString(), name: c.name))
        .toList();
    final currentSelection = _currentFilter.contact != null
        ? selectableContacts.firstWhereOrNull(
            (sc) => sc.id == _currentFilter.contact!.id.toString())
        : null;
    final result = await contact_dialog.ContactSelectionDialog.show(context,
        contacts: selectableContacts, initialSelection: currentSelection);
    if (result != null) {
      setState(() => _currentFilter = _currentFilter.copyWith(
          contact: _contacts.firstWhere((c) => c.id.toString() == result.id)));
    }
  }

  Widget _buildTransactionTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.transactions.form.type,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155), // slate-700
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9), // slate-100
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              TransactionTypeSelectionItem(
                title: t.transactions.types.income,
                subtitle: t.transactions.filter.subtitles.income,
                icon: Icons.trending_up,
                iconColor: const Color(0xFF16A34A), // green-600
                iconBackgroundColor: const Color(0xFFDCFCE7), // green-100
                checkboxBorderColor: const Color(0xFF86EFAC), // green-300
                checkboxBackgroundColor: const Color(0xFF22C55E), // green-500
                isSelected: _currentFilter.transactionTypes
                    .contains(TransactionType.income),
                onTap: () => _onTransactionTypeSelected(TransactionType.income),
              ),
              const Divider(height: 1, color: Color(0xFFE2E8F0)), // slate-200
              TransactionTypeSelectionItem(
                title: t.transactions.types.expense,
                subtitle: t.transactions.filter.subtitles.expense,
                icon: Icons.trending_down,
                iconColor: const Color(0xFFDC2626), // red-600
                iconBackgroundColor: const Color(0xFFFEE2E2), // red-100
                checkboxBorderColor: const Color(0xFFFCA5A5), // red-300
                checkboxBackgroundColor: const Color(0xFFEF4444), // red-500
                isSelected: _currentFilter.transactionTypes
                    .contains(TransactionType.expense),
                onTap: () =>
                    _onTransactionTypeSelected(TransactionType.expense),
              ),
              const Divider(height: 1, color: Color(0xFFE2E8F0)), // slate-200
              TransactionTypeSelectionItem(
                title: t.transactions.types.transfer,
                subtitle: t.transactions.filter.subtitles.transfer,
                icon: Icons.swap_horiz,
                iconColor: const Color(0xFF2563EB), // blue-600
                iconBackgroundColor: const Color(0xFFDBEAFE), // blue-100
                checkboxBorderColor: const Color(0xFF93C5FD), // blue-300
                checkboxBackgroundColor: const Color(0xFF3B82F6), // blue-500
                isSelected: _currentFilter.transactionTypes
                    .contains(TransactionType.transfer),
                onTap: () =>
                    _onTransactionTypeSelected(TransactionType.transfer),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveFiltersSummary() {
    final activeFilters = _currentFilter.activeFilters();
    if (activeFilters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        border: Border.all(color: const Color(0xFFBFDBFE)), // blue-200
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.transactions.filter.active,
            style: const TextStyle(
              color: Color(0xFF1E40AF), // blue-800
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeFilters.map((filter) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: filter.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(filter.icon, size: 14, color: filter.color),
                    const SizedBox(width: 6),
                    Text(
                      filter.label,
                      style: TextStyle(
                        color: filter.color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppAppBar(
          title: t.transactions.filter.title,
          type: AppAppBarType.blur,
          leading: AppAppBarLeading.close,
          onLeadingPressed: () => Navigator.of(context).pop(),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildQuickDateFilters(),
                        const SizedBox(height: 24),
                        Text(
                          t.transactions.filter.customRange,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF334155), // slate-700
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AppFloatingLabelSelector(
                                label: t.transactions.filter.startDate,
                                icon: Icons.calendar_today_outlined,
                                value: _currentFilter.startDate != null
                                    ? DateFormat.yMMMMd(t.$meta.locale.languageCode)
                                        .format(_currentFilter.startDate!)
                                    : t.transactions.filter.selectDate,
                                onTap: () async {
                                  final newStartDate =
                                      await DateSelectionDialog.show(
                                    context: context,
                                    initialDate: _currentFilter.startDate ??
                                        DateTime.now(),
                                  );
                                  if (newStartDate != null) {
                                    setState(() {
                                      _currentFilter = _currentFilter.copyWith(
                                        startDate: newStartDate,
                                        endDate:
                                            (_currentFilter.endDate != null &&
                                                    _currentFilter.endDate!
                                                        .isBefore(newStartDate))
                                                ? newStartDate
                                                : _currentFilter.endDate,
                                        quickDateFilter: QuickDateFilter.custom,
                                      );
                                    });
                                  }
                                },
                                hasValue: _currentFilter.startDate != null,
                                iconColor: const Color(0xFF2563EB), // blue-600
                                iconBackgroundColor:
                                    const Color(0xFFDBEAFE), // blue-100
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AppFloatingLabelSelector(
                                label: t.transactions.filter.endDate,
                                icon: Icons.calendar_today_outlined,
                                value: _currentFilter.endDate != null
                                    ? DateFormat.yMMMMd(t.$meta.locale.languageCode)
                                        .format(_currentFilter.endDate!)
                                    : t.transactions.filter.selectDate,
                                onTap: () async {
                                  final newEndDate =
                                      await DateSelectionDialog.show(
                                    context: context,
                                    initialDate: _currentFilter.endDate ??
                                        _currentFilter.startDate ??
                                        DateTime.now(),
                                  );
                                  if (newEndDate != null) {
                                    setState(() {
                                      _currentFilter = _currentFilter.copyWith(
                                        endDate: newEndDate,
                                        startDate:
                                            (_currentFilter.startDate != null &&
                                                    _currentFilter.startDate!
                                                        .isAfter(newEndDate))
                                                ? newEndDate
                                                : _currentFilter.startDate,
                                        quickDateFilter: QuickDateFilter.custom,
                                      );
                                    });
                                  }
                                },
                                hasValue: _currentFilter.endDate != null,
                                iconColor: const Color(0xFF2563EB), // blue-600
                                iconBackgroundColor:
                                    const Color(0xFFDBEAFE), // blue-100
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Column(
                          children: [
                            AppFloatingLabelSelector(
                              label: t.transactions.filter.categories,
                              icon: Icons.category_outlined,
                              value: _currentFilter.category?.name ?? t.transactions.types.all,
                              onTap: _selectCategory,
                              hasValue: _currentFilter.category != null,
                              iconColor: const Color(0xFF64748B), // slate-500
                              iconBackgroundColor:
                                  const Color(0xFFF1F5F9), // slate-100
                            ),
                            const SizedBox(height: 16),
                            AppFloatingLabelSelector(
                              label: t.transactions.filter.accounts,
                              icon: Icons.account_balance_wallet_outlined,
                              value: _currentFilter.account?.name ?? t.transactions.types.all,
                              onTap: _selectAccount,
                              hasValue: _currentFilter.account != null,
                              iconColor: const Color(0xFF2563EB), // blue-600
                              iconBackgroundColor:
                                  const Color(0xFFDBEAFE), // blue-100
                            ),
                            const SizedBox(height: 16),
                            AppFloatingLabelSelector(
                              label: t.transactions.filter.contacts,
                              icon: Icons.person_outline,
                              value: _currentFilter.contact?.name ?? t.transactions.types.all,
                              onTap: _selectContact,
                              hasValue: _currentFilter.contact != null,
                              iconColor: const Color(0xFF64748B), // slate-500
                              iconBackgroundColor:
                                  const Color(0xFFF1F5F9), // slate-100
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          t.transactions.filter.amount,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF334155), // slate-700
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: AppFloatingLabelField(
                                controller: _minAmountController,
                                label: t.transactions.filter.minAmount,
                                placeholder: '0.00',
                                prefixIcon: Icons.attach_money,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [CurrencyInputFormatter()],
                                onChanged: (value) => _currentFilter =
                                    _currentFilter.copyWith(
                                        minAmount: double.tryParse(
                                            value.replaceAll(',', ''))),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppFloatingLabelField(
                                controller: _maxAmountController,
                                label: t.transactions.filter.maxAmount,
                                placeholder: '999.99',
                                prefixIcon: Icons.attach_money,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [CurrencyInputFormatter()],
                                onChanged: (value) => _currentFilter =
                                    _currentFilter.copyWith(
                                        maxAmount: double.tryParse(
                                            value.replaceAll(',', ''))),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildTransactionTypeSection(),
                        const SizedBox(height: 24),
                        _buildActiveFiltersSummary(),
                      ],
                    ),
                  ),
                  FormActionBar(
                    onCancel: () => setState(() =>
                        _currentFilter = TransactionFilterModel.initial()),
                    onSave: () => Navigator.of(context).pop(_currentFilter),
                    cancelText: t.transactions.filter.clear,
                    saveText: t.transactions.filter.apply,
                  ),
                ],
              ),
      ),
    );
  }
}
