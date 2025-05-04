import 'package:drift/drift.dart';
import '../database.dart';

class ReferenceSeeds {
  static Future<void> seedAll(AppDatabase db) async {
    // Ejecutar seeds en orden para respetar dependencias (FK)
    await _seedAccountingTypes(db);
    await _seedRootChartAccounts(db); // <-- Llamar después de AccountingTypes
    await _seedDocumentTypes(db);
    await _seedFlowTypes(db);
    await _seedPaymentTypes(db);
    await _seedDefaultCurrencies(db);
    // Considerar si otros seeds dependen de estos y ajustar el orden si es necesario
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

  // --- Nuevo método para Cuentas Contables Raíz ---
  static Future<void> _seedRootChartAccounts(AppDatabase db) async {
    await db.batch((batch) {
      batch.insertAll(
        db.chartAccount,
        [
          // Nivel 0 - Raíces principales
          ChartAccountsCompanion.insert(
            accountingTypeId: 'As', // <-- Usar ID correcto
            code: '1',
            level: 0,
            name: 'Activos',
          ),
          ChartAccountsCompanion.insert(
            accountingTypeId: 'Li', // <-- Usar ID correcto
            code: '2',
            level: 0,
            name: 'Pasivos',
          ),
          ChartAccountsCompanion.insert(
            accountingTypeId: 'Eq', // <-- Usar ID correcto
            code: '3',
            level: 0,
            name: 'Patrimonio',
          ),
          ChartAccountsCompanion.insert(
            accountingTypeId: 'In', // <-- Usar ID correcto
            code: '4',
            level: 0,
            name: 'Ingresos',
          ),
          ChartAccountsCompanion.insert(
            accountingTypeId: 'Ex', // <-- Usar ID correcto
            code: '5',
            level: 0,
            name: 'Gastos',
          ),
        ],
        mode: InsertMode.insertOrIgnore, // Usar ignore para evitar errores si ya existen
      );
    });
  }
  // --- Fin nuevo método ---

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
          // Añadir COP si se eliminó de database.dart
           CurrenciesCompanion.insert(
             id: 'COP',
             name: 'Peso colombiano',
             symbol: '\$',
             rateExchange: 1.0 // Ajustar tasa si es necesario
           ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}
