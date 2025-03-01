import 'package:drift/drift.dart';
import '../database.dart';

class ReferenceSeeds {
  static Future<void> seedAll(AppDatabase db) async {
    await Future.wait([
      _seedAccountingTypes(db),
      _seedDocumentTypes(db),
      _seedFlowTypes(db),
      _seedPaymentTypes(db),
      _seedDefaultCurrencies(db),
    ]);
  }

  static Future<void> _seedAccountingTypes(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.accountingType,
        [
          AccountingTypesCompanion.insert(id: 'As', name: 'Assets'),
          AccountingTypesCompanion.insert(id: 'Li', name: 'Liabilities'),
          AccountingTypesCompanion.insert(id: 'Eq', name: 'Equity'),
          AccountingTypesCompanion.insert(id: 'In', name: 'Income'),
          AccountingTypesCompanion.insert(id: 'Ex', name: 'Expenses'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static Future<void> _seedDocumentTypes(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.documentType,
        [
          DocumentTypesCompanion.insert(id: 'I', name: 'Income'),
          DocumentTypesCompanion.insert(id: 'E', name: 'Expense'),
          DocumentTypesCompanion.insert(id: 'T', name: 'Transfer'),
          DocumentTypesCompanion.insert(id: 'L', name: 'Lend'),
          DocumentTypesCompanion.insert(id: 'B', name: 'Borrow'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static Future<void> _seedFlowTypes(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.flowType,
        [
          FlowTypesCompanion.insert(id: 'F', name: 'From'),
          FlowTypesCompanion.insert(id: 'T', name: 'To'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static Future<void> _seedPaymentTypes(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.paymentType,
        [
          PaymentTypesCompanion.insert(id: 'W', name: 'Wallet'),
          PaymentTypesCompanion.insert(id: 'C', name: 'Credit Card'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static Future<void> _seedDefaultCurrencies(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.currency,
        [
          CurrenciesCompanion.insert(
            id: 'USD',
            name: 'Dolar Americano',
            symbol: '\$',
            rateExchange: 1.0,
          ),
          CurrenciesCompanion.insert(
            id: 'EUR',
            name: 'Euro',
            symbol: '€',
            rateExchange: 1.2,
          ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}
