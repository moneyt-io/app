import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneyt_pfm/data/datasources/local/database.dart';
import 'package:moneyt_pfm/data/datasources/local/daos/recurring_transaction_dao.dart';
import 'package:moneyt_pfm/data/datasources/local/daos/transaction_dao.dart';
import 'package:moneyt_pfm/core/utils/recurring_date_helper.dart';
import 'package:moneyt_pfm/domain/enums/recurrence_frequency.dart';

void main() {
  late AppDatabase db;
  late RecurringTransactionDao recurringDao;
  late TransactionDao transactionDao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    recurringDao = RecurringTransactionDao(db);
    transactionDao = TransactionDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Recurring Transactions Database & Idempotency Tests', () {
    test('Can create a RecurringTransaction rule and query it', () async {
      final startDate = DateTime(2026, 7, 1);
      final nextDue = RecurringDateHelper.calculateNextDueDate(
        startDate,
        RecurrenceFrequency.monthly,
      );

      final ruleId = await recurringDao.insertRecurringTransaction(
        RecurringTransactionDataCompanion.insert(
          documentTypeId: 'E',
          currencyId: 'USD',
          paymentId: 1,
          categoryId: 10,
          amount: 150.0,
          frequency: 'monthly',
          startDate: startDate,
          lastExecutedAt: drift.Value(startDate),
          nextExecutionDate: nextDue,
          description: const drift.Value('Alquiler de departamento'),
        ),
      );

      expect(ruleId, isPositive);

      final rule = await recurringDao.getRecurringTransactionById(ruleId);
      expect(rule, isNotNull);
      expect(rule!.amount, equals(150.0));
      expect(rule.description, equals('Alquiler de departamento'));
      expect(rule.frequency, equals('monthly'));
      expect(rule.active, isTrue);
      expect(rule.nextExecutionDate, equals(DateTime(2026, 8, 1)));
    });

    test('Historical transaction is decoupled from recurring rule', () async {
      // 1. Create rule
      final ruleId = await recurringDao.insertRecurringTransaction(
        RecurringTransactionDataCompanion.insert(
          documentTypeId: 'E',
          currencyId: 'USD',
          paymentId: 1,
          categoryId: 10,
          amount: 100.0,
          frequency: 'monthly',
          startDate: DateTime(2026, 7, 1),
          nextExecutionDate: DateTime(2026, 8, 1),
        ),
      );

      // 2. Insert historical transaction for July 1st
      final txId = await transactionDao.insertTransaction(
        TransactionEntriesCompanion.insert(
          documentTypeId: 'E',
          currencyId: 'USD',
          journalId: 1,
          secuencial: 1,
          date: DateTime(2026, 7, 1),
          amount: 100.0,
          recurringTransactionId: drift.Value(ruleId),
        ),
      );

      // 3. User updates recurring rule amount in August to $120.0
      await recurringDao.updateRecurringTransaction(
        RecurringTransactionDataCompanion(
          id: drift.Value(ruleId),
          documentTypeId: const drift.Value('E'),
          currencyId: const drift.Value('USD'),
          paymentId: const drift.Value(1),
          categoryId: const drift.Value(10),
          frequency: const drift.Value('monthly'),
          startDate: drift.Value(DateTime(2026, 7, 1)),
          nextExecutionDate: drift.Value(DateTime(2026, 8, 1)),
          amount: const drift.Value(120.0),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );

      // 4. Verify historical July 1st transaction amount remains strictly $100.0!
      final historicalTx = await transactionDao.getTransactionById(txId);
      expect(historicalTx, isNotNull);
      expect(historicalTx!.amount, equals(100.0)); // Immutable!
      expect(historicalTx.recurringTransactionId, equals(ruleId));

      // And the rule is updated to 120.0
      final updatedRule = await recurringDao.getRecurringTransactionById(ruleId);
      expect(updatedRule!.amount, equals(120.0));
    });

    test('Idempotency check prevents duplicate recurring transaction generation', () async {
      final ruleId = await recurringDao.insertRecurringTransaction(
        RecurringTransactionDataCompanion.insert(
          documentTypeId: 'E',
          currencyId: 'USD',
          paymentId: 1,
          categoryId: 10,
          amount: 50.0,
          frequency: 'monthly',
          startDate: DateTime(2026, 7, 1),
          nextExecutionDate: DateTime(2026, 8, 1),
        ),
      );

      final aug1 = DateTime(2026, 8, 1);

      // First run: Check if transaction exists for August 1st
      bool exists = await transactionDao.hasTransactionForRecurringAndDate(ruleId, aug1);
      expect(exists, isFalse);

      // Create August 1st transaction
      await transactionDao.insertTransaction(
        TransactionEntriesCompanion.insert(
          documentTypeId: 'E',
          currencyId: 'USD',
          journalId: 2,
          secuencial: 2,
          date: aug1,
          amount: 50.0,
          recurringTransactionId: drift.Value(ruleId),
        ),
      );

      // Second run (hours later or next app opening on August 1st):
      exists = await transactionDao.hasTransactionForRecurringAndDate(ruleId, aug1);
      expect(exists, isTrue); // Guard prevents duplicate insertion!
    });
  });
}
