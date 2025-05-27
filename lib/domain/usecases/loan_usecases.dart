import 'package:injectable/injectable.dart';
import '../entities/loan_entry.dart';
import '../entities/loan_detail.dart';
import '../entities/contact.dart';
import '../repositories/loan_repository.dart';
import '../repositories/contact_repository.dart';
import '../repositories/journal_repository.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/wallet_repository.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/category_repository.dart';

@injectable
class LoanUseCases {
  final LoanRepository _loanRepository;
  final ContactRepository _contactRepository;
  final JournalRepository _journalRepository;
  final TransactionRepository _transactionRepository;
  final WalletRepository _walletRepository;
  final CreditCardRepository _creditCardRepository;
  final CategoryRepository _categoryRepository;

  LoanUseCases(
    this._loanRepository,
    this._contactRepository,
    this._journalRepository,
    this._transactionRepository,
    this._walletRepository,
    this._creditCardRepository,
    this._categoryRepository,
  );

  // ===== OPERACIONES BÁSICAS =====
  
  /// Obtiene todos los préstamos
  Future<List<LoanEntry>> getAllLoans() {
    return _loanRepository.getAllLoans();
  }

  /// Obtiene un préstamo por ID
  Future<LoanEntry?> getLoanById(int id) {
    return _loanRepository.getLoanById(id);
  }

  /// Stream de todos los préstamos
  Stream<List<LoanEntry>> watchAllLoans() {
    return _loanRepository.watchAllLoans();
  }

  // ===== CONSULTAS ESPECIALIZADAS =====
  
  /// Obtiene préstamos por contacto
  Future<List<LoanEntry>> getLoansByContact(int contactId) {
    return _loanRepository.getLoansByContact(contactId);
  }

  /// Obtiene préstamos otorgados (Lend)
  Future<List<LoanEntry>> getActiveLends() {
    return _loanRepository.getLoansByType('L').then((loans) =>
        loans.where((loan) => loan.status == LoanStatus.active).toList());
  }

  /// Obtiene préstamos recibidos (Borrow)
  Future<List<LoanEntry>> getActiveBorrows() {
    return _loanRepository.getLoansByType('B').then((loans) =>
        loans.where((loan) => loan.status == LoanStatus.active).toList());
  }

  /// Obtiene préstamos pendientes (con saldo)
  Future<List<LoanEntry>> getOutstandingLoans() async {
    final allLoans = await _loanRepository.getAllLoans();
    return allLoans.where((loan) => 
        loan.status == LoanStatus.active && loan.outstandingBalance > 0).toList();
  }

  // ===== CREACIÓN SIMPLE (SIN CONTABILIDAD) =====
  
  /// Crea un préstamo simple (solo registro básico)
  Future<LoanEntry> createSimpleLoan({
    required String documentTypeId, // 'L' o 'B'
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    String? description,
    double rateExchange = 1.0,
  }) async {
    // Validaciones básicas
    await _validateLoanCreation(
      contactId: contactId,
      amount: amount,
      currencyId: currencyId,
    );

    // Obtener siguiente secuencial
    final secuencial = await _loanRepository.getNextSecuencial(documentTypeId);

    // Crear loan entry
    final loanEntry = LoanEntry(
      id: 0, // Será asignado por la BD
      documentTypeId: documentTypeId,
      currencyId: currencyId,
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      status: LoanStatus.active,
      totalPaid: 0.0, // Inicialmente sin pagos
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Por ahora, crear un detail vacío (sin journal/transaction)
    final loanDetail = LoanDetail(
      id: 0,
      loanId: 0, // Será actualizado después de crear el loan
      currencyId: currencyId,
      paymentTypeId: 'W', // Temporal - Wallet por defecto
      paymentId: 1, // Temporal - ID dummy
      journalId: 0, // Sin journal por ahora
      transactionId: 0, // Sin transaction por ahora
      amount: amount,
      rateExchange: rateExchange,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return _loanRepository.createLoan(loanEntry, [loanDetail]);
  }

  // ===== GESTIÓN DE PRÉSTAMOS =====
  
  /// Actualiza el estado de un préstamo
  Future<void> updateLoanStatus({
    required int loanId,
    required LoanStatus newStatus,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) {
      throw Exception('Préstamo no encontrado');
    }

    final updatedLoan = loan.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  /// Marca un préstamo como pagado completamente
  Future<void> markLoanAsPaid(int loanId) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) {
      throw Exception('Préstamo no encontrado');
    }

    final updatedLoan = loan.copyWith(
      status: LoanStatus.paid,
      totalPaid: loan.amount, // Marcar como completamente pagado
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  // ===== ESTADÍSTICAS =====
  
  /// Total prestado (documentTypeId = 'L')
  Future<double> getTotalLentAmount() {
    return _loanRepository.getTotalLentAmount();
  }

  /// Total recibido (documentTypeId = 'B')
  Future<double> getTotalBorrowedAmount() {
    return _loanRepository.getTotalBorrowedAmount();
  }

  /// Saldo pendiente de préstamos otorgados
  Future<double> getOutstandingLentAmount() {
    return _loanRepository.getOutstandingLentAmount();
  }

  /// Saldo pendiente de préstamos recibidos
  Future<double> getOutstandingBorrowedAmount() {
    return _loanRepository.getOutstandingBorrowedAmount();
  }

  /// Balance neto (prestado - recibido)
  Future<double> getNetLoanBalance() async {
    final lent = await getOutstandingLentAmount();
    final borrowed = await getOutstandingBorrowedAmount();
    return lent - borrowed;
  }

  // ===== HELPERS Y VALIDACIONES =====
  
  /// Calcula el saldo pendiente de un préstamo
  double getOutstandingBalance(LoanEntry loan) {
    return loan.outstandingBalance;
  }

  /// Verifica si un préstamo puede ser cancelado (write-off)
  bool canWriteOffLoan(LoanEntry loan) {
    return loan.canWriteOff;
  }

  /// Verifica si un préstamo está completamente pagado
  bool isLoanFullyPaid(LoanEntry loan) {
    return loan.isPaid; // CORREGIDO: usar isPaid en lugar de isFullyPaid
  }

  /// Obtiene el contacto asociado a un préstamo
  Future<Contact?> getLoanContact(int contactId) {
    return _contactRepository.getContactById(contactId);
  }

  // ===== VALIDACIONES PRIVADAS =====
  
  Future<void> _validateLoanCreation({
    required int contactId,
    required double amount,
    required String currencyId,
  }) async {
    // Validar monto positivo
    if (amount <= 0) {
      throw Exception('El monto debe ser mayor a cero');
    }

    // Validar que el contacto existe
    final contact = await _contactRepository.getContactById(contactId);
    if (contact == null) {
      throw Exception('El contacto seleccionado no existe');
    }

    // Validar que el contacto está activo
    if (!contact.active) {
      throw Exception('El contacto seleccionado no está activo');
    }

    // Validaciones adicionales pueden ir aquí (divisa válida, etc.)
  }

  /// Valida si se puede registrar un pago
  Future<bool> validateLoanPayment(int loanId, double paymentAmount) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) return false;
    if (loan.status != LoanStatus.active) return false;
    if (paymentAmount <= 0) return false;
    // No validar que el pago sea menor al saldo (permitir sobrepagos)
    return true;
  }

  // ===== OPERACIONES DE ELIMINACIÓN =====
  
  /// Elimina un préstamo (soft delete)
  Future<void> deleteLoan(int id) async {
    final loan = await _loanRepository.getLoanById(id);
    if (loan == null) {
      throw Exception('Préstamo no encontrado');
    }

    // Solo permitir eliminar préstamos sin pagos
    if (loan.totalPaid > 0) {
      throw Exception('No se puede eliminar un préstamo con pagos registrados');
    }

    await _loanRepository.deleteLoan(id);
  }

  // ===== MÉTODOS AVANZADOS (COMENTADOS HASTA COMPLETAR IMPLEMENTACIÓN) =====
  
  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear préstamo otorgado desde wallet con generación completa de journal y transacción
  /*
  Future<LoanEntry> createLendLoanFromWallet({
    required int contactId,
    required double amount,
    required String currencyId,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    // Implementación completa requiere métodos completos en JournalRepository
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear préstamo otorgado desde tarjeta de crédito
  /*
  Future<LoanEntry> createLendLoanFromCreditCard({
    required int contactId,
    required double amount,
    required String currencyId,
    required int creditCardId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear préstamo recibido hacia wallet
  /*
  Future<LoanEntry> createBorrowLoanToWallet({
    required int contactId,
    required double amount,
    required String currencyId,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear préstamo otorgado sin transferencia (por servicios)
  /*
  Future<LoanEntry> createLendLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int incomeCategoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear préstamo recibido sin transferencia (por servicios)
  /*
  Future<LoanEntry> createBorrowLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int expenseCategoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Crear pago simple de préstamo
  /*
  Future<void> createLoanPayment({
    required int loanId,
    required double paymentAmount,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Asumir saldo pendiente como gasto/ingreso
  /*
  Future<void> writeOffOutstandingBalance({
    required int loanId,
    required int categoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  // ===== MÉTODOS DE PAGO SIMPLIFICADOS (USANDO FUNCIONALIDAD EXISTENTE) =====
  
  /// Crear pago simple de préstamo (sin integración contable completa)
  Future<void> createSimpleLoanPayment({
    required int loanId,
    required double paymentAmount,
    required DateTime date,
    String? description,
  }) async {
    // 1. Obtener el préstamo
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) {
      throw Exception('Préstamo no encontrado con ID $loanId');
    }

    // 2. Validar que el préstamo esté activo
    if (loan.status != LoanStatus.active) {
      throw Exception('El préstamo no está activo');
    }

    // 3. Validar que el pago sea positivo
    if (paymentAmount <= 0) {
      throw Exception('El monto del pago debe ser mayor a cero');
    }

    // 4. Actualizar el préstamo
    final newTotalPaid = loan.totalPaid + paymentAmount;
    final newStatus = newTotalPaid >= loan.amount ? LoanStatus.paid : LoanStatus.active;

    final updatedLoan = loan.copyWith(
      totalPaid: newTotalPaid,
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  /// Cancelar saldo pendiente (marcar como write-off)
  Future<void> writeOffLoanBalance({
    required int loanId,
    String? description,
  }) async {
    // 1. Obtener el préstamo
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) {
      throw Exception('Préstamo no encontrado con ID $loanId');
    }

    // 2. Verificar que tenga saldo pendiente
    final outstandingBalance = getOutstandingBalance(loan);
    if (outstandingBalance <= 0) {
      throw Exception('No hay saldo pendiente para cancelar');
    }

    // 3. Marcar como cancelado/asumido
    final updatedLoan = loan.copyWith(
      totalPaid: loan.amount, // Marcar como completamente "pagado"
      status: LoanStatus.writtenOff,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  // ==================== FUNCIONALIDAD CRÍTICA: PRÉSTAMOS SIN TRANSFERENCIA ====================
  
  /// TODO: Implementar cuando JournalRepository y entidades estén completas
  /// Crear préstamo otorgado por servicios (SIN transferencia de dinero)
  /*
  Future<LoanEntry> createLendLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int incomeCategoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de JournalRepository');
  }
  */

  /// TODO: Implementar cuando JournalRepository y entidades estén completas
  /// Crear préstamo recibido por servicios (SIN transferencia de dinero)
  /*
  Future<LoanEntry> createBorrowLoanFromService({
    required int contactId,
    required double amount,
    required String currencyId,
    required int expenseCategoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de JournalRepository');
  }
  */

  // ==================== FUNCIONALIDAD CRÍTICA: PAGOS AVANZADOS ====================

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /// Registrar pago con ajustes automáticos
  /*
  Future<void> createLoanPaymentWithAdjustment({
    required int loanId,
    required double paymentAmount,
    required int walletId,
    required DateTime date,
    // Ajustes opcionales
    double? writeOffAmount,
    int? writeOffCategoryId,
    double? extraAmount,
    int? extraCategoryId,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo - requiere implementación completa de repositorios');
  }
  */

  /// Cancelar saldo pendiente completo (write-off)
  Future<void> writeOffOutstandingBalance({
    required int loanId,
    required int categoryId,
    required DateTime date,
    String? description,
  }) async {
    final loan = await _loanRepository.getLoanById(loanId);
    if (loan == null) throw Exception('Préstamo no encontrado');

    final outstandingBalance = loan.outstandingBalance;
    if (outstandingBalance <= 0) throw Exception('No hay saldo pendiente');

    // Por ahora, solo marcar como write-off sin integración contable completa
    final updatedLoan = loan.copyWith(
      totalPaid: loan.amount, // Marcar como completamente "pagado"
      status: LoanStatus.writtenOff,
      updatedAt: DateTime.now(),
    );

    await _loanRepository.updateLoan(updatedLoan);
  }

  // ==================== MÉTODOS HELPER COMENTADOS ====================

  /// TODO: Implementar cuando todos los repositorios tengan los métodos necesarios
  /*
  Future<void> _createBasicPayment({
    required LoanEntry loan,
    required double paymentAmount,
    required int walletId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo');
  }

  Future<void> _createWriteOffTransaction({
    required LoanEntry loan,
    required double writeOffAmount,
    required int categoryId,
    required DateTime date,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo');
  }

  Future<void> _createExcessTransaction({
    required double amount,
    required int categoryId,
    required int walletId,
    required DateTime date,
    required bool isIncome,
    String? description,
  }) async {
    throw UnimplementedError('Funcionalidad en desarrollo');
  }
  */

  // Métodos helper para obtener IDs de cuentas contables (placeholders)
  Future<int> _getAccountsReceivableAccountId(int contactId) async {
    // TODO: Implementar lógica para obtener/crear cuenta CxC del contacto
    return 1; // Placeholder
  }

  Future<int> _getAccountsPayableAccountId(int contactId) async {
    // TODO: Implementar lógica para obtener/crear cuenta CxP del contacto
    return 2; // Placeholder
  }

  Future<int> _getWalletAccountId(int walletId) async {
    final wallet = await _walletRepository.getWalletById(walletId);
    return wallet?.chartAccountId ?? 0;
  }

  Future<int> _getIncomeAccountIdForCategory(int categoryId) async {
    final category = await _categoryRepository.getCategoryById(categoryId);
    return category?.chartAccountId ?? 0;
  }

  Future<int> _getExpenseAccountIdForCategory(int categoryId) async {
    final category = await _categoryRepository.getCategoryById(categoryId);
    return category?.chartAccountId ?? 0;
  }
}
