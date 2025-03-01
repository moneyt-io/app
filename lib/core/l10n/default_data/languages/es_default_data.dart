import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/datasources/local/database.dart';
import '../base_default_data.dart';

class SpanishDefaultData extends BaseDefaultData {
  @override
  String get languageCode => 'es';

  @override
  List<CategoriesCompanion> getDefaultCategories() {
    final List<CategoriesCompanion> categories = [];
    int id = 1;

    // Función auxiliar para agregar categorías
    void addCategory(String name, String type, {int? parentId, String? icon}) {
      categories.add(
        CategoriesCompanion.insert(
          id: Value(id++),
          name: name,
          type: type,
          parentId: Value(parentId),
        ),
      );
    }

    // GANANCIAS
    // 1. Ingresos Activos
    addCategory('Ingresos Activos', 'I', icon: 'work');
    addCategory('Salario', 'I', parentId: 1, icon: 'payments');
    addCategory('Trabajo extras', 'I', parentId: 1, icon: 'work_history');

    // 2. Ingresos Pasivos
    addCategory('Ingresos Pasivos', 'I', icon: 'account_balance');
    addCategory('Intereses bancarios', 'I', parentId: 4, icon: 'savings');
    addCategory('Alquileres', 'I', parentId: 4, icon: 'house');
    addCategory('Dividendos', 'I', parentId: 4, icon: 'trending_up');

    // 3. Otros Ingresos
    addCategory('Otros Ingresos', 'I', icon: 'more_horiz');
    addCategory('Juegos de Azar', 'I', parentId: 8, icon: 'casino');
    addCategory('Herencias', 'I', parentId: 8, icon: 'real_estate_agent');

    // GASTOS
    // 1. Gastos Fijos
    addCategory('Gastos Fijos', 'E', icon: 'calendar_today');
    addCategory('Alquiler', 'E', parentId: 11, icon: 'house');
    addCategory('Hipoteca', 'E', parentId: 11, icon: 'account_balance');
    addCategory('Agua', 'E', parentId: 11, icon: 'water_drop');
    addCategory('Luz', 'E', parentId: 11, icon: 'bolt');
    addCategory('Internet', 'E', parentId: 11, icon: 'wifi');
    addCategory('Telefonía', 'E', parentId: 11, icon: 'phone');
    addCategory('Seguros', 'E', parentId: 11, icon: 'security');

    // 2. Gastos Variables
    addCategory('Gastos Variables', 'E', icon: 'moving');
    addCategory('Restaurantes', 'E', parentId: 19, icon: 'restaurant');
    addCategory('Transporte', 'E', parentId: 19, icon: 'directions_car');
    addCategory('Ropa y calzado', 'E', parentId: 19, icon: 'checkroom');
    addCategory('Entretenimiento', 'E', parentId: 19, icon: 'sports_esports');

    // 3. Gastos de Salud
    addCategory('Gastos de Salud', 'E', icon: 'medical_services');
    addCategory('Medicamentos', 'E', parentId: 24, icon: 'medication');
    addCategory('Consultas médicas', 'E', parentId: 24, icon: 'healing');

    // 4. Educación
    addCategory('Educación', 'E', icon: 'school');
    addCategory('Cursos', 'E', parentId: 27, icon: 'menu_book');
    addCategory('Universidad', 'E', parentId: 27, icon: 'account_balance');

    // 5. Hogar
    addCategory('Hogar', 'E', icon: 'home');
    addCategory('Muebles y decoración', 'E', parentId: 30, icon: 'chair');
    addCategory('Mantenimiento', 'E', parentId: 30, icon: 'build');

    // 6. Otros Gastos
    addCategory('Otros Gastos', 'E', icon: 'more_horiz');
    addCategory('Donaciones', 'E', parentId: 33, icon: 'volunteer_activism');
    addCategory('Regalos', 'E', parentId: 33, icon: 'card_giftcard');
    addCategory('Imprevistos', 'E', parentId: 33, icon: 'warning');
    addCategory('Viajes', 'E', parentId: 33, icon: 'flight');

    return categories;
  }

  @override
  List<AccountsCompanion> getDefaultAccounts() {
    return [
      AccountsCompanion.insert(
        id: const Value(1),
        name: 'Efectivo',
        description: const Value('Dinero en efectivo'),
      ),
      AccountsCompanion.insert(
        id: const Value(2),
        name: 'Cuenta Bancaria',
        description: const Value('Cuenta bancaria principal'),
      ),
    ];
  }
}
