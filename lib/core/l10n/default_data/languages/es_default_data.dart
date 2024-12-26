import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import '../base_default_data.dart';

class SpanishDefaultData extends BaseDefaultData {
  @override
  String get languageCode => 'es';

  @override
  List<CategoriesCompanion> getDefaultCategories() {
    return [
      // Categorías de Gastos
      CategoriesCompanion.insert(
        name: 'Alimentación',
        type: 'E',
        description: const Value('Gastos en comida, bebidas y restaurantes'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Transporte',
        type: 'E',
        description: const Value('Gastos en transporte público, gasolina y mantenimiento de vehículos'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Servicios',
        type: 'E',
        description: const Value('Pagos de servicios básicos como luz, agua, gas e internet'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Vivienda',
        type: 'E',
        description: const Value('Gastos relacionados con el alquiler o hipoteca'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Salud',
        type: 'E',
        description: const Value('Gastos médicos, medicamentos y seguros de salud'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Educación',
        type: 'E',
        description: const Value('Gastos en estudios, libros y material educativo'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Entretenimiento',
        type: 'E',
        description: const Value('Gastos en ocio, deportes y actividades recreativas'),
        status: const Value(true),
      ),

      // Categorías de Ingresos
      CategoriesCompanion.insert(
        name: 'Salario',
        type: 'I',
        description: const Value('Ingresos por trabajo en relación de dependencia'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Trabajo Independiente',
        type: 'I',
        description: const Value('Ingresos por trabajo freelance o servicios profesionales'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Inversiones',
        type: 'I',
        description: const Value('Ingresos por rendimientos de inversiones'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Otros Ingresos',
        type: 'I',
        description: const Value('Otros tipos de ingresos no categorizados'),
        status: const Value(true),
      ),
    ];
  }

  @override
  List<AccountsCompanion> getDefaultAccounts() {
    return [
      AccountsCompanion.insert(
        name: 'Efectivo',
        description: const Value('Dinero en efectivo'),
      ),
      AccountsCompanion.insert(
        name: 'Cuenta Bancaria',
        description: const Value('Cuenta bancaria principal'),
      ),
      AccountsCompanion.insert(
        name: 'Ahorros',
        description: const Value('Cuenta de ahorros'),
      ),
    ];
  }
}
