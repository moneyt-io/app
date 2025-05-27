import 'package:injectable/injectable.dart';
import '../entities/loan_entry.dart';
import '../entities/loan_detail.dart';
import '../entities/journal_entry.dart';
import '../entities/journal_detail.dart';
import '../entities/transaction_entry.dart';
import '../entities/transaction_detail.dart';
import '../entities/category.dart';
import '../entities/wallet.dart';
import '../entities/credit_card.dart';
import '../entities/contact.dart';
import '../repositories/loan_repository.dart';
import '../repositories/contact_repository.dart';
import '../repositories/journal_repository.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/wallet_repository.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/category_repository.dart';
import '../constants/loan_constants.dart';
import '../validators/loan_validators.dart';
import '../exceptions/loan_exceptions.dart';
import '../helpers/accounting_helpers.dart';
import '../services/balance_calculation_service.dart'; // AGREGADO

@injectable
class LoanUseCases {
  final LoanRepository _loanRepository;
  final ContactRepository _contactRepository;
  final JournalRepository _journalRepository;
  final TransactionRepository _transactionRepository;
  final WalletRepository _walletRepository;
  final CreditCardRepository _creditCardRepository;
  final CategoryRepository _categoryRepository;
  final BalanceCalculationService _balanceService; // AGREGADO

  LoanUseCases(
    this._loanRepository,
    this._contactRepository,
    this._journalRepository,
    this._transactionRepository,
    this._walletRepository,
    this._creditCardRepository,
    this._categoryRepository,
    this._balanceService, // AGREGADO
  );

  // ========== OPERACIONES BÁSICAS ==========
  Future<List<LoanEntry>> getAllLoans() => _loanRepository.getAllLoans();
  
  Future<LoanEntry?> getLoanById(int id) => _loanRepository.getLoanById(id);
  
  Stream<List<LoanEntry>> watchAllLoans() => _loanRepository.watchAllLoans();

  // ========== CREAR PRÉSTAMOS OTORGADOS (LEND) ==========
  
  /// Crear préstamo otorgado desde wallet (dinero sale del wallet)
  Future<LoanEntry> createLendLoanFromWallet({
    required int contactId,
    required double amount,
    required String currencyId,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    // Validaciones
    final wallet = await _walletRepository.getWalletById(walletId);
    if (wallet == null) {
      throw const PaymentMethodNotFoundException('Wallet no encontrado');
    }

    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw const ContactNotFoundException();
    }

    // VALIDACIÓN MEJORADA con cálculo real de balance
    final validationErrors = await LoanValidators.validateCompleteNewLoanWithBalances(
      contactId: contactId,
      amount: amount,
      currencyId: currencyId,
      date: date,
      paymentType: LoanConstants.walletPaymentType,
      paymentId: walletId,
      description: description,
      wallet: wallet,
      balanceService: _balanceService, // USAR el servicio inyectado
    );

    if (validationErrors.isNotEmpty) {
      throw LoanValidationException(validationErrors);
    }

    // 1. Crear journal contable
    final journal = await _journalRepository.createJournal(
      documentTypeId: LoanConstants.lendDocumentType,
      date: date,
      description: AccountingHelpers.generateJournalDescription(
        operationType: 'LEND_WALLET',
        contactName: contact.name,
        amount: amount,
        customDescription: description,
      ),
    );

    // 2. Crear detalles del journal (partida doble)
    await _journalRepository.createJournalDetails([
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: await _getReceivableAccountId(contactId),
        debit: amount,
        credit: 0,
        rateExchange: 1.0,
      ),
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: wallet.chartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: 1.0,
      ),
    ]);

    // 3. Crear transacción
    final transaction = await _transactionRepository.createExpenseTransaction(
      date: date,
      description: description ?? LoanConstants.defaultLendFromWalletDescription,
      amount: amount,
      currencyId: currencyId,
      categoryId: 0, // No aplica categoría para préstamos
      journalId: journal.id,
      paymentTypeId: LoanConstants.walletPaymentType,
      paymentId: walletId,
      contactId: contactId,
    );

    // 4. Crear préstamo
    final loan = LoanEntry(
      id: 0,
      documentTypeId: LoanConstants.lendDocumentType,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: await _loanRepository.getNextSecuencial(LoanConstants.lendDocumentType),
      date: date,
      amount: amount,
      rateExchange: 1.0,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0,
      currencyId: currencyId,
      paymentTypeId: LoanConstants.walletPaymentType,
      paymentId: walletId,
      journalId: journal.id,
      transactionId: transaction.id,
      amount: amount,
      rateExchange: 1.0,
      active: true, // AGREGADO: parámetro faltante
      createdAt: DateTime.now(), // AGREGADO: parámetro faltante
      updatedAt: DateTime.now(), // AGREGADO: parámetro faltante
    );

    return await _loanRepository.createLoan(loan, [loanDetail]);
  }

  /// Crear préstamo otorgado desde tarjeta de crédito
  Future<LoanEntry> createLendLoanFromCreditCard({
    required int contactId,
    required double amount,
    required String currencyId,
    required int creditCardId,
    required DateTime date,
    String? description,
  }) async {
    // Validaciones similares...
    final creditCard = await _creditCardRepository.getCreditCardById(creditCardId);
    if (creditCard == null) {
      throw const PaymentMethodNotFoundException('Tarjeta de crédito no encontrada');
    }

    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw const ContactNotFoundException();
    }

    // SOLUCIÓN ROBUSTA: Usar validaciones básicas directas
    if (contactId <= 0) {
      throw const ContactNotFoundException();
    }

    if (!LoanValidators.isValidAmount(amount)) {
      throw LoanValidationException(['Monto inválido']);
    }

    if (currencyId.isEmpty) {
      throw LoanValidationException(['Moneda requerida']);
    }

    if (!LoanValidators.isValidLoanDate(date)) {
      throw LoanValidationException(['Fecha inválida']);
    }

    if (LoanValidators.exceedsCreditLimit(creditCard, amount)) {
      throw LoanValidationException(['Excede límite de crédito']);
    }

    // 1. Crear journal específico para préstamo desde tarjeta
    final journal = await _journalRepository.createLendFromCreditCardJournal(
      date: date,
      description: AccountingHelpers.generateJournalDescription(
        operationType: 'LEND_CREDIT',
        contactName: contact.name,
        amount: amount,
        customDescription: description,
      ),
      amount: amount,
      currencyId: currencyId,
      receivableAccountId: await _getReceivableAccountId(contactId),
      creditCardAccountId: creditCard.chartAccountId,
    );

    // 2. Crear transacción
    final transaction = await _transactionRepository.createCreditCardExpenseTransaction(
      date: date,
      description: description ?? LoanConstants.defaultLendFromCreditCardDescription,
      amount: amount,
      currencyId: currencyId,
      creditCardId: creditCardId,
      categoryId: 0,
      contactId: contactId,
    );

    // 3. Crear préstamo
    final loan = LoanEntry(
      id: 0,
      documentTypeId: LoanConstants.lendDocumentType,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: await _loanRepository.getNextSecuencial(LoanConstants.lendDocumentType),
      date: date,
      amount: amount,
      rateExchange: 1.0,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0,
      currencyId: currencyId,
      paymentTypeId: LoanConstants.creditCardPaymentType,
      paymentId: creditCardId,
      journalId: journal.id,
      transactionId: transaction.id,
      amount: amount,
      rateExchange: 1.0,
      active: true, // AGREGADO: parámetro faltante
      createdAt: DateTime.now(), // AGREGADO: parámetro faltante
      updatedAt: DateTime.now(), // AGREGADO: parámetro faltante
    );

    return await _loanRepository.createLoan(loan, [loanDetail]);
  }

  /// Crear préstamo otorgado sin transferencia (por servicios)
  Future<LoanEntry> createLendLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int incomeCategoryId,
    required DateTime date,
    String? description,
  }) async {
    // Validaciones
    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw const ContactNotFoundException();
    }

    final category = await _categoryRepository.getCategoryById(incomeCategoryId);
    if (category == null || category.documentTypeId != 'I') {
      throw const InvalidCategoryTypeException('Debe ser una categoría de ingreso');
    }

    // 1. Crear journal específico para préstamo por servicios
    final journal = await _journalRepository.createLendFromServiceJournal(
      date: date,
      description: AccountingHelpers.generateJournalDescription(
        operationType: 'LEND_SERVICE',
        contactName: contact.name,
        amount: amount,
        customDescription: description,
      ),
      amount: amount,
      currencyId: currencyId,
      receivableAccountId: await _getReceivableAccountId(contactId),
      incomeAccountId: category.chartAccountId,
    );

    // 2. Crear transacción de ingreso
    final transaction = await _transactionRepository.createLendFromServiceTransaction(
      date: date,
      description: description ?? LoanConstants.defaultLendFromServiceDescription,
      amount: amount,
      currencyId: currencyId,
      categoryId: incomeCategoryId,
      journalId: journal.id,
      contactId: contactId,
    );

    // 3. Crear préstamo
    final loan = LoanEntry(
      id: 0,
      documentTypeId: LoanConstants.lendDocumentType,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: await _loanRepository.getNextSecuencial(LoanConstants.lendDocumentType),
      date: date,
      amount: amount,
      rateExchange: 1.0,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0,
      currencyId: currencyId,
      paymentTypeId: LoanConstants.transactionPaymentType,
      paymentId: incomeCategoryId,
      journalId: journal.id,
      transactionId: transaction.id,
      amount: amount,
      rateExchange: 1.0,
      active: true, // AGREGADO: parámetro faltante
      createdAt: DateTime.now(), // AGREGADO: parámetro faltante
      updatedAt: DateTime.now(), // AGREGADO: parámetro faltante
    );

    return await _loanRepository.createLoan(loan, [loanDetail]);
  }

  // ========== CREAR PRÉSTAMOS RECIBIDOS (BORROW) ==========

  /// Crear préstamo recibido hacia wallet
  Future<LoanEntry> createBorrowLoanToWallet({
    required int contactId,
    required double amount,
    required String currencyId,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    // Validaciones similares a lend...
    final wallet = await _walletRepository.getWalletById(walletId);
    if (wallet == null) {
      throw const PaymentMethodNotFoundException('Wallet no encontrado');
    }

    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw const ContactNotFoundException();
    }

    // 1. Crear journal contable
    final journal = await _journalRepository.createJournal(
      documentTypeId: LoanConstants.borrowDocumentType,
      date: date,
      description: AccountingHelpers.generateJournalDescription(
        operationType: 'BORROW_WALLET',
        contactName: contact.name,
        amount: amount,
        customDescription: description,
      ),
    );

    // 2. Crear detalles del journal (partida doble)
    await _journalRepository.createJournalDetails([
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: wallet.chartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: 1.0,
      ),
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: await _getPayableAccountId(contactId),
        debit: 0,
        credit: amount,
        rateExchange: 1.0,
      ),
    ]);

    // 3. Crear transacción
    final transaction = await _transactionRepository.createIncomeTransaction(
      date: date,
      description: description ?? LoanConstants.defaultBorrowToWalletDescription,
      amount: amount,
      currencyId: currencyId,
      walletId: walletId,
      categoryId: 0,
      journalId: journal.id,
      contactId: contactId,
    );

    // 4. Crear préstamo
    final loan = LoanEntry(
      id: 0,
      documentTypeId: LoanConstants.borrowDocumentType,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: await _loanRepository.getNextSecuencial(LoanConstants.borrowDocumentType),
      date: date,
      amount: amount,
      rateExchange: 1.0,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0,
      currencyId: currencyId,
      paymentTypeId: LoanConstants.walletPaymentType,
      paymentId: walletId,
      journalId: journal.id,
      transactionId: transaction.id,
      amount: amount,
      rateExchange: 1.0,
      active: true, // AGREGADO: parámetro faltante
      createdAt: DateTime.now(), // AGREGADO: parámetro faltante
      updatedAt: DateTime.now(), // AGREGADO: parámetro faltante
    );

    return await _loanRepository.createLoan(loan, [loanDetail]);
  }

  /// Crear préstamo recibido sin transferencia (por servicios)
  Future<LoanEntry> createBorrowLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int expenseCategoryId,
    required DateTime date,
    String? description,
  }) async {
    // Validaciones
    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw const ContactNotFoundException();
    }

    final category = await _categoryRepository.getCategoryById(expenseCategoryId);
    if (category == null || category.documentTypeId != 'E') {
      throw const InvalidCategoryTypeException('Debe ser una categoría de gasto');
    }

    // 1. Crear journal específico para préstamo por servicios
    final journal = await _journalRepository.createBorrowFromServiceJournal(
      date: date,
      description: AccountingHelpers.generateJournalDescription(
        operationType: 'BORROW_SERVICE',
        contactName: contact.name,
        amount: amount,
        customDescription: description,
      ),
      amount: amount,
      currencyId: currencyId,
      expenseAccountId: category.chartAccountId,
      payableAccountId: await _getPayableAccountId(contactId),
    );

    // 2. Crear transacción de gasto
    final transaction = await _transactionRepository.createBorrowFromServiceTransaction(
      date: date,
      description: description ?? LoanConstants.defaultBorrowFromServiceDescription,
      amount: amount,
      currencyId: currencyId,
      categoryId: expenseCategoryId,
      journalId: journal.id,
      contactId: contactId,
    );

    // 3. Crear préstamo
    final loan = LoanEntry(
      id: 0,
      documentTypeId: LoanConstants.borrowDocumentType,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: await _loanRepository.getNextSecuencial(LoanConstants.borrowDocumentType),
      date: date,
      amount: amount,
      rateExchange: 1.0,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0,
      currencyId: currencyId,
      paymentTypeId: LoanConstants.transactionPaymentType,
      paymentId: expenseCategoryId,
      journalId: journal.id,
      transactionId: transaction.id,
      amount: amount,
      rateExchange: 1.0,
      active: true, // AGREGADO: parámetro faltante
      createdAt: DateTime.now(), // AGREGADO: parámetro faltante
      updatedAt: DateTime.now(), // AGREGADO: parámetro faltante
    );

    return await _loanRepository.createLoan(loan, [loanDetail]);
  }

  // ========== GESTIÓN DE PAGOS CON AJUSTES ==========

  /// Crear pago de préstamo con ajustes (funcionalidad principal)
  Future<void> createLoanPaymentWithAdjustment({
    required int loanId,
    required double paymentAmount,
    required int walletId,
    required DateTime date,
    double? writeOffAmount,
    int? writeOffCategoryId,
    double? extraAmount,
    int? extraCategoryId,
    String? description,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw const LoanNotFoundException();
    if (!loan.canMakePayment) throw const InvalidLoanStatusException();

    final validationErrors = LoanValidators.validatePaymentData(
      loan: loan,
      paymentAmount: paymentAmount,
      writeOffAmount: writeOffAmount,
      extraAmount: extraAmount,
    );

    if (validationErrors.isNotEmpty) {
      throw LoanValidationException(validationErrors);
    }

    final outstandingBalance = loan.outstandingBalance;
    
    // Calcular totales
    final totalPaidBefore = loan.totalPaid;
    final regularPayment = paymentAmount - (writeOffAmount ?? 0) - (extraAmount ?? 0);
    final newTotalPaid = totalPaidBefore + regularPayment + (writeOffAmount ?? 0);
    
    // Determinar nuevo estado
    final newStatus = AccountingHelpers.areAmountsEqual(newTotalPaid, loan.amount) 
        ? LoanStatus.paid 
        : LoanStatus.active;

    // 1. Registrar pago regular si hay monto
    if (regularPayment > 0) {
      await _loanRepository.createLoanPayment(
        loanId,
        regularPayment,
        LoanConstants.walletPaymentType,
        walletId,
        date,
        description: description ?? 'Pago de préstamo',
      );
    }

    // 2. Manejar write-off si existe
    if (writeOffAmount != null && writeOffAmount > 0 && writeOffCategoryId != null) {
      await _processWriteOff(loan, writeOffAmount, writeOffCategoryId, date);
    }

    // 3. Manejar monto extra si existe
    if (extraAmount != null && extraAmount > 0 && extraCategoryId != null) {
      await _processExtraAmount(loan, extraAmount, extraCategoryId, date, walletId);
    }

    // 4. Actualizar estado del préstamo
    final updatedLoan = loan.copyWith(
      status: newStatus,
      totalPaid: newTotalPaid,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  /// Cancelar saldo pendiente como gasto/ingreso
  Future<void> writeOffOutstandingBalance({
    required int loanId,
    required int categoryId,
    required DateTime date,
    String? description,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw const LoanNotFoundException();
    if (!loan.canWriteOff) throw const CannotWriteOffException();

    final category = await _categoryRepository.getCategoryById(categoryId);
    if (category == null) {
      throw const InvalidCategoryTypeException('Categoría no encontrada');
    }

    final outstandingBalance = loan.outstandingBalance;
    await _processWriteOff(loan, outstandingBalance, categoryId, date);

    // Actualizar préstamo como completamente pagado
    final updatedLoan = loan.copyWith(
      status: LoanStatus.writtenOff,
      totalPaid: loan.amount,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  // ========== MÉTODOS HELPER PRIVADOS ==========

  Future<void> _processWriteOff(LoanEntry loan, double amount, int categoryId, DateTime date) async {
    final isLendLoan = loan.isLendLoan;
    
    if (isLendLoan) {
      // Préstamo otorgado: cancelar como gasto
      await _transactionRepository.createAdjustmentTransaction(
        date: date,
        description: 'Cancelación de saldo pendiente - ${loan.description ?? 'Préstamo'}',
        amount: amount,
        currencyId: loan.currencyId,
        categoryId: categoryId,
        adjustmentType: 'WRITE_OFF',
        contactId: loan.contactId,
      );
    } else {
      // Préstamo recibido: cancelar como ingreso
      await _transactionRepository.createAdjustmentTransaction(
        date: date,
        description: 'Cancelación de deuda pendiente - ${loan.description ?? 'Préstamo'}',
        amount: amount,
        currencyId: loan.currencyId,
        categoryId: categoryId,
        adjustmentType: 'WRITE_OFF',
        contactId: loan.contactId,
      );
    }
  }

  Future<void> _processExtraAmount(LoanEntry loan, double amount, int categoryId, DateTime date, int walletId) async {
    final isLendLoan = loan.isLendLoan;
    
    if (isLendLoan) {
      // Préstamo otorgado: extra como ingreso (ej: intereses recibidos)
      await _transactionRepository.createIncomeTransaction(
        date: date,
        description: 'Monto extra en pago - ${loan.description ?? 'Préstamo'}',
        amount: amount,
        currencyId: loan.currencyId,
        walletId: walletId,
        categoryId: categoryId,
        journalId: 0,
        contactId: loan.contactId,
      );
    } else {
      // Préstamo recibido: extra como gasto (ej: intereses pagados)
      await _transactionRepository.createExpenseTransaction(
        date: date,
        description: 'Monto extra en pago - ${loan.description ?? 'Préstamo'}',
        amount: amount,
        currencyId: loan.currencyId,
        categoryId: categoryId,
        journalId: 0,
        paymentTypeId: LoanConstants.walletPaymentType,
        paymentId: walletId,
        contactId: loan.contactId,
      );
    }
  }

  // ========== CONSULTAS ESPECIALIZADAS ==========

  Future<List<LoanEntry>> getLoansByContact(int contactId) =>
      _loanRepository.getLoansByContact(contactId);

  Future<List<LoanEntry>> getActiveLends() =>
      _loanRepository.getLoansByType(LoanConstants.lendDocumentType)
          .then((loans) => loans.where((loan) => loan.status == LoanStatus.active).toList());

  Future<List<LoanEntry>> getActiveBorrows() =>
      _loanRepository.getLoansByType(LoanConstants.borrowDocumentType)
          .then((loans) => loans.where((loan) => loan.status == LoanStatus.active).toList());

  Future<double> getTotalLentAmount() => _loanRepository.getTotalLentAmount();
  
  Future<double> getTotalBorrowedAmount() => _loanRepository.getTotalBorrowedAmount();
  
  Future<double> getOutstandingLentAmount() => _loanRepository.getOutstandingLentAmount();
  
  Future<double> getOutstandingBorrowedAmount() => _loanRepository.getOutstandingBorrowedAmount();

  // ========== VALIDACIONES ==========

  Future<bool> validateLoanPayment(int loanId, double paymentAmount) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) return false;
    return LoanValidators.canReceivePayment(loan) && 
           LoanValidators.isValidPaymentAmount(loan, paymentAmount);
  }

  Future<List<Category>> getAvailableIncomeCategories() =>
      _categoryRepository.getCategoriesByType('I');

  Future<List<Category>> getAvailableExpenseCategories() =>
      _categoryRepository.getCategoriesByType('E');

  // ========== MÉTODOS HELPER PARA CUENTAS CONTABLES ==========

  Future<int> _getReceivableAccountId(int contactId) async {
    // TODO: Implementar lógica para obtener cuenta por cobrar del contacto
    // Por ahora retorna un ID fijo, pero debería crear/obtener cuenta específica
    return 1200; // Cuentas por Cobrar - Préstamos
  }

  Future<int> _getPayableAccountId(int contactId) async {
    // TODO: Implementar lógica para obtener cuenta por pagar del contacto
    return 2200; // Cuentas por Pagar - Préstamos
  }

  // ========== MÉTODOS HELPER PARA UI ==========
  
  double getOutstandingBalance(LoanEntry loan) => loan.outstandingBalance;
  
  bool canWriteOffLoan(LoanEntry loan) => loan.canWriteOff;

  /// Obtener estadísticas de préstamos
  Future<Map<String, double>> getLoanStatistics() async {
    final [totalLent, totalBorrowed, outstandingLent, outstandingBorrowed] = await Future.wait([
      _loanRepository.getTotalLentAmount(),
      _loanRepository.getTotalBorrowedAmount(),
      _loanRepository.getOutstandingLentAmount(),
      _loanRepository.getOutstandingBorrowedAmount(),
    ]);

    return {
      'totalLent': totalLent,
      'totalBorrowed': totalBorrowed,
      'outstandingLent': outstandingLent,
      'outstandingBorrowed': outstandingBorrowed,
      'netBalance': totalLent - totalBorrowed,
      'outstandingNetBalance': outstandingLent - outstandingBorrowed,
    };
  }

  /// Obtener préstamos por rango de fechas
  Future<List<LoanEntry>> getLoansByDateRange(DateTime startDate, DateTime endDate) async {
    final allLoans = await _loanRepository.getAllLoans();
    return allLoans.where((loan) {
      return loan.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
             loan.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  /// Buscar préstamos por descripción o contacto
  Future<List<LoanEntry>> searchLoans(String query) async {
    final allLoans = await _loanRepository.getAllLoans();
    final queryLower = query.toLowerCase();
    
    return allLoans.where((loan) {
      final descriptionMatch = loan.description?.toLowerCase().contains(queryLower) ?? false;
      final contactMatch = loan.contact?.name.toLowerCase().contains(queryLower) ?? false;
      return descriptionMatch || contactMatch;
    }).toList();
  }

  // ========== MÉTODOS SIMPLIFICADOS PARA PROVIDER ==========

  /// Crear préstamo simple (para compatibilidad con provider)
  Future<LoanEntry> createSimpleLoan({
    required String documentTypeId,
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    String? description,
    double rateExchange = 1.0,
  }) async {
    // Validar tipo de documento
    if (documentTypeId == 'L') {
      // Préstamo otorgado - usar método estándar sin transferencia (por servicios)
      // Necesitamos una categoría de ingreso por defecto
      final incomeCategories = await getAvailableIncomeCategories();
      if (incomeCategories.isEmpty) {
        throw const InvalidCategoryTypeException('No hay categorías de ingreso disponibles');
      }
      
      return await createLendLoanFromService(
        contactId: contactId,
        amount: amount,
        currencyId: currencyId,
        incomeCategoryId: incomeCategories.first.id,
        date: date,
        description: description,
      );
    } else if (documentTypeId == 'B') {
      // Préstamo recibido - usar método estándar sin transferencia (por servicios)
      // Necesitamos una categoría de gasto por defecto
      final expenseCategories = await getAvailableExpenseCategories();
      if (expenseCategories.isEmpty) {
        throw const InvalidCategoryTypeException('No hay categorías de gasto disponibles');
      }
      
      return await createBorrowLoanFromService(
        contactId: contactId,
        amount: amount,
        currencyId: currencyId,
        expenseCategoryId: expenseCategories.first.id,
        date: date,
        description: description,
      );
    } else {
      throw Exception('Tipo de documento inválido: $documentTypeId');
    }
  }

  /// Actualizar estado de préstamo
  Future<void> updateLoanStatus({
    required int loanId,
    required LoanStatus newStatus,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw const LoanNotFoundException();

    final updatedLoan = loan.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  /// Marcar préstamo como pagado
  Future<void> markLoanAsPaid(int loanId) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw const LoanNotFoundException();

    final updatedLoan = loan.copyWith(
      status: LoanStatus.paid,
      totalPaid: loan.amount,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  /// Crear pago simple de préstamo
  Future<void> createSimpleLoanPayment({
    required int loanId,
    required double paymentAmount,
    required DateTime date,
    String? description,
  }) async {
    // Usar método existente con wallet por defecto (ID 1)
    // En un escenario real, se debería seleccionar el wallet
    await createLoanPaymentWithAdjustment(
      loanId: loanId,
      paymentAmount: paymentAmount,
      walletId: 1, // TODO: Obtener wallet por defecto
      date: date,
      description: description,
    );
  }

  /// Cancelar saldo de préstamo
  Future<void> writeOffLoanBalance({
    required int loanId,
    String? description,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw const LoanNotFoundException();

    // Obtener categoría apropiada
    List<Category> categories;
    if (loan.isLendLoan) {
      categories = await getAvailableExpenseCategories();
    } else {
      categories = await getAvailableIncomeCategories();
    }

    if (categories.isEmpty) {
      throw const InvalidCategoryTypeException('No hay categorías disponibles para cancelación');
    }

    await writeOffOutstandingBalance(
      loanId: loanId,
      categoryId: categories.first.id,
      date: DateTime.now(),
      description: description,
    );
  }

  /// Eliminar préstamo
  Future<void> deleteLoan(int id) async {
    await _loanRepository.deleteLoan(id);
  }

  /// Obtener balance neto de préstamos
  Future<double> getNetLoanBalance() async {
    final totalLent = await getTotalLentAmount();
    final totalBorrowed = await getTotalBorrowedAmount();
    return totalLent - totalBorrowed;
  }

  /// Verificar si préstamo está completamente pagado
  bool isLoanFullyPaid(LoanEntry loan) {
    return loan.status == LoanStatus.paid || 
           AccountingHelpers.areAmountsEqual(loan.totalPaid, loan.amount);
  }
}
