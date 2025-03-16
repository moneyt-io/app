========================================================================
                        MoneyT - Contexto Unificado V.0.3.0
========================================================================

1. DESCRIPCIÓN GENERAL
----------------------
MoneyT es una aplicación de gestión financiera personal desarrollada en Flutter. La app tiene dos grandes enfoques:

a) Funcionalidades tradicionales de finanzas personales:
   - Registro y seguimiento de ingresos, gastos, transferencias, prestamos y contactos.
   - Manejo de multi divisa
   - Interfaz sencilla y fácil de usar, pensada para el usuario cotidiano.

b) Integración de principios contables avanzados:
   - Implementación de conceptos como el plan de cuentas y la partida doble.
   - Automatización de la generación de cuentas contables al crear categorías, wallets o tarjetas de crédito.
   - Generación automática de diarios contables en cada transacción (ingresos, egresos, transferencias, préstamos y gastos compartidos).

------------------------------------------------------------------------
2. ESTRUCTURA DEL PROYECTO
---------------------------
La aplicación sigue una arquitectura organizada en capas:

• lib/
  ├── core/
  │     ├── l10n/          -> Gestión de localización e idiomas.
  │     └── events/        -> Eventos de sincronización y otros eventos centrales.
  │
  ├── data/
  │     ├── datasources/   -> Fuentes de datos (local y remoto)
  │     │   ├── local/     -> Acceso a la base de datos local (usando Drift para SQLite)
  │     │   └── remote/    -> Servicios remotos (APIs, Firebase, etc.)
  │     ├── models/        -> Modelos de datos y mappers
  │     └── repositories/  -> Implementaciones de repositorios
  │
  ├── domain/
  │     ├── entities/      -> Definición de entidades (transacciones, cuentas, etc.).
  │     ├── repositories/  -> Interfaces para la gestión de datos.
  │     └── usecases/      -> Lógica de negocio y casos de uso.
  │
  ├── presentation/
  │     ├── atoms/         -> Componentes básicos (botones, inputs)
  │     ├── molecules/     -> Componentes compuestos (cards, listas simples)
  │     ├── organisms/     -> Componentes complejos (formularios, modales)
  │     ├── templates/     -> Layouts de pantallas
  │     └── screens/       -> Pantallas completas
  │
  ├── routes/             -> Definición de rutas de navegación.
  └── main.dart           -> Punto de entrada; inicializa Firebase, dependencias y verifica el estado del onboarding.


Estrucutra que quiero Implementar

lib/
│── core/
│   ├── config/                 # Configuración general (temas, estilos, constantes)
│   ├── localization/           # Configuración de idiomas
│   ├── navigation/             # Configuración de Navigator 2.0
│   ├── utils/                  # Funciones y clases de utilidad
│   ├── di/                     # Inyección de dependencias
│── data/                       # Capa de datos
│   ├── datasources/            # Fuentes de datos (API, BD local)
│   │   ├── local/              # Implementaciones locales (Drift)
│   │   │   ├── tables/         # Definición de tablas
│   │   │   ├── daos/           # Objetos de acceso a datos
│   │   │   └── database.dart   # Configuración de la BD
│   │   └── remote/             # Implementaciones remotas (HTTP, GraphQL)
│   ├── models/                 # Modelos de datos (DTOs, entidades de Drift)
│   ├── repositories/           # Implementaciones de repositorios
│── domain/                     # Capa de dominio
│   ├── entities/               # Entidades de dominio
│   ├── repositories/           # Definición de repositorios
│   ├── usecases/               # Casos de uso
│── presentation/               # Capa de presentación (Atomic Design)
│   ├── atoms/                  # Componentes más pequeños (botones, inputs)
│   ├── molecules/              # Combinación de átomos (cards, listas)
│   ├── organisms/              # Componentes grandes (formularios, modales)
│   ├── templates/              # Layouts de pantallas
│   ├── pages/                # Pantallas completas
│── main.dart                   # Punto de entrada de la aplicación
│── app.dart                    # Inicialización de dependencias y configuración

------------------------------------------------------------------------
3. FUNCIONALIDADES PRINCIPALES
-------------------------------
1. Gestión de Transacciones:
   - Registro de ingresos, egresos y transferencias.
   - Cada transacción genera automáticamente su diario contable para mantener la partida doble.

2. Gestión de Contactos:
   - Creación, edición y eliminación de contactos, asociados a transacciones, préstamos y gastos compartidos.

3. Sincronización de Datos:
   - Uso de Firebase Firestore para mantener los datos actualizados en tiempo real.

4. Autenticación:
   - Soporte para autenticación mediante correo electrónico y Google Sign-In.

5. Localización y Temas:
   - Soporte multilingüe (ej. español e inglés) y modos claro/oscuro.

6. Principios Contables y Plan de Cuentas:
   - Generación automática de cuentas contables al crear categorías, wallets y tarjetas de crédito.
   - Registro de diarios contables (journal y journal_details) para cada transacción, asegurando la partida doble.

7. Módulos Avanzados:
   a) Préstamos:
      - Permite prestar dinero (dar o recibir) con su respectiva generación de transacciones y diarios contables.
      - Soporta escenarios mixtos (por ejemplo, registrar un ingreso o gasto vinculado a un préstamo).
   
   b) Gastos Compartidos:
      - Al registrar un gasto compartido, se genera la transacción del gasto personal y se crean automáticamente préstamos a contactos involucrados, con sus respectivos diarios contables.

------------------------------------------------------------------------
4. CONFIGURACIÓN DE FIREBASE Y DEPENDENCIAS CLAVE
----------------------------------------------------
- La aplicación se conecta a Firebase para la autenticación y sincronización de datos.
- Dependencias importantes:
    • flutter_svg         -> Manejo de imágenes SVG.
    • drift               -> Gestión de la base de datos SQLite.
    • provider            -> Gestión del estado.
    • google_sign_in      -> Autenticación con Google.
    • shared_preferences  -> Almacenamiento local (por ejemplo, para verificar el onboarding).

Ejemplo de inicialización en main.dart:
--------------------------------------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar dependencias (por ejemplo, con GetIt)
  await initializeDependencies();

  // Verificar si es la primera vez que se abre la app
  final prefs = await SharedPreferences.getInstance();
  final bool hasCompletedOnboarding = prefs.getBool('has_completed_onboarding') ?? false;

  runApp(MyApp(skipWelcome: hasCompletedOnboarding));
}
--------------------------------------------------

------------------------------------------------------------------------
5. ESTRUCTURA DE LA BASE DE DATOS
----------------------------------
La base de datos se ha diseñado para soportar tanto la gestión financiera básica como la contabilidad avanzada. A continuación se muestran las principales tablas y ejemplos de consultas:

a) Plan de Cuentas:
   - Tabla chart_accounts:
     SELECT id, parent_id, accounting_type_id, code, level, name, active, created_at, updated_at, deleted_at
     FROM chart_accounts;

b) Categorías:
   - Tabla categories (crea cuentas contables en la sección correspondiente de ingreso o egreso):
     SELECT id, parent_id, document_type_id, chart_account_id, name, icon, active, created_at, updated_at, deleted_at
     FROM categories;

c) Cuentas Bancarias y Efectvo:
   - Tabla wallets:
     SELECT id, currency_id, chart_account_id, name, description, active, created_at, updated_at, deleted_at
     FROM wallets;

d) Tarjetas de Crédito:
   - Tabla credit_cards:
     SELECT id, currency_id, chart_account_id, name, description, quota, closing_date, active, created_at, updated_at, deleted_at
     FROM credit_cards;

e) Contactos:
   - Tabla contacts:
     SELECT id, name, email, phone, note, active, created_at, updated_at, deleted_at
     FROM contacts;

f) Diarios Contables:
   - Tabla journal_entries:
     SELECT id, document_type_id, secuencial, date, description, active, created_at, updated_at, deleted_at
     FROM journal_entries;
   - Tabla journal_details:
     SELECT id, journal_id, currency_id, chart_account_id, credit, debit, rate_exchange
     FROM journal_details;

g) Transacciones y Detalles:
   - Tabla transaction_entries:
     SELECT id, document_type_id, currency_id, journal_id, contact_id, secuencial, date, amount, rate_exchange, description, active, created_at, updated_at, deleted_at
     FROM transaction_entries;
   - Tabla transaction_details:
     SELECT id, transaction_id, currency_id, flow_id, payment_type_id, payment_id, category_id, amount, rate_exchange
     FROM transaction_details;

h) Préstamos:
   - Tabla loan_entries:
     SELECT id, document_type_id, currency_id, contact_id, secuencial, date, amount, rate_exchange, description, status, active, created_at, updated_at, deleted_at
     FROM loan_entries;
   - Tabla loan_details:
     SELECT id, loan_id, currency_id, payment_type_id, payment_id, journal_id, transaction_id, amount, rate_exchange, active, created_at, updated_at, deleted_at
     FROM loan_details;

i) Gastos Compartidos:
   - Tabla shared_expense_entries:
     SELECT id, document_type_id, currency_id, secuencial, date, amount, rate_exchange, active, created_at, updated_at, deleted_at
     FROM shared_expense_entries;
   - Tabla shared_expense_details:
     SELECT id, shared_expense_id, currency_id, loan_id, transaction_id, percentage, amount, rate_exchange, status
     FROM shared_expense_details;

j) Tablas de Referencia:
   - Tipos de Cuentas (accounting_types):
      SELECT id, name FROM accounting_types;
      Data default: (As, Assets), (Li,Liabilities), (Eq,Equity), (In,Income), (Ex,Expenses)
   - Tipos de Documentos (document_types):
      SELECT id, name FROM document_types;
      Data default: (I,Income), (E,Expense), (T,Transfer), (L,Lend), (B,Borrow)
   - Tipos de Flujo (flow_types):
      SELECT id, name FROM flow_types;
      Data default: (F,From), (T,To)
   - Tipos de Metodos de Pago (payment_types)
      SELECT id, name FROM payment_types;
      Data default: (W,Wallet), (C,Credit Card)
   - Tabla de Divisas (currencies):
      SELECT id, name, symbol, rate_exchange
      FROM currencies;
      Data default: (USD, Dolar Americano, $, 1), (EUR, Euro, €, 1.2)

------------------------------------------------------------------------
6. CASOS DE USO DESTACADOS
---------------------------
• Ingresos y Egresos:
   - Al registrar un ingreso o gasto se inserta un registro en la tabla transactions y se crea el detalle en transactions_details.
   - Se genera automáticamente un diario contable (journal y journal_details).

• Transferencias:
   - Registro como transacción del tipo TRANSFERENCIA, generando dos entradas en los detalles (origen y destino) y su diario contable.
   - Las transferencias entre distintas divisas generan 3 movimientos, Salida del Origen, Entrada al Destino y Ajuste en el Destino (Puede ser Ingreso o Egreso para justar la cantidad de unidades)

• Plan de Cuentas y Categorías:
   - La creación de una categoría, Wallet o tarjeta de crédito desencadena la generación automática de la cuenta contable correspondiente.

• Préstamos:
   - Manejo de préstamos (dar o recibir) con generación de transacciones, diarios contables y operaciones mixtas (cuando se vincula con un ingreso o gasto).

• Gastos Compartidos:
   - Registro de un gasto que se divide entre varios contactos, generando tanto la transacción del gasto personal como los préstamos a cada uno, con su correspondiente diario contable.

------------------------------------------------------------------------
7. NOTAS ADICIONALES
---------------------
- La aplicación busca combinar la sencillez de uso con una robusta gestión contable interna.
- La interfaz es intuitiva, mientras que la lógica de negocio y la estructura de datos están diseñadas para soportar operaciones financieras y contables complejas.
- El uso de Firebase, SQLite y otras dependencias garantiza una alta escalabilidad y sincronización en tiempo real.

------------------------------------------------------------------------
8. ESTRUCTURA DE LA CAPA DE DATOS (DATA LAYER)
----------------------------------
La capa de datos sigue una estructura consistente para cada entidad:

a) Estructura de Archivos:
   lib/data/
   ├── datasources/            # Capa de fuentes de datos
   │   ├── local/             # Implementación local con Drift
   │   │   ├── tables/        # Definiciones de tablas
   │   │   ├── daos/         # Data Access Objects
   │   │   └── database.dart # Configuración de Drift
   │   └── remote/           # Implementaciones remotas (futuro)
   ├── models/               # Modelos de datos y mappers
   └── repositories/         # Implementaciones de repositorios

b) Convenciones de Nombrado (ACTUALIZADO):
   - Tablas: Singular para la clase, Plural para el DataClassName 
     Ejemplo: 
     ```dart
     @DataClassName('Categories')
     class Category extends Table { }
     ```
   - DAOs: Singular (ej: CategoryDao, WalletDao)
   - Modelos: Singular (ej: CategoryModel, WalletModel)
   - Repositorios: Singular (ej: CategoryRepository, WalletRepository)

c) Estructura por Componente:

1. Entidad del Dominio (xxx.dart):
```dart
class XXX extends Equatable {
  final int id;
  // ... campos ...
  
  @override
  List<Object?> get props => [id, ...];
}
```

2. Tabla (xxx_table.dart):
```dart
@DataClassName('XXXs')
class XXX extends Table {
  IntColumn get id => integer().autoIncrement()();
  // ... campos ...
}
```

3. Modelo (xxx_model.dart):
```dart
class XXXModel {
  final int id;
  // ... campos ...

  XXXModel({required this.id, ...});
  XXXModel.create({...});  // Para nuevas instancias
  
  XXXsCompanion toCompanion() => ...
  XXX toEntity() => ...
  factory XXXModel.fromEntity(XXX entity) => ...
}
```

4. Repositorio del Dominio (xxx_repository.dart):
```dart
abstract class XXXRepository {
  Future<List<XXX>> getAll();
  Future<XXX?> getById(int id);
  Stream<List<XXX>> watchAll();
  Future<XXX> create(XXX xxx);
  Future<void> update(XXX xxx);
  Future<void> delete(int id);
}
```

d) Patrones y Prácticas:
   - Uso de Drift para el manejo de SQLite
   - Inyección de dependencias con Injectable
   - Mapeo entre modelos y entidades
   - Manejo de errores consistente
   - Uso de Companions para operaciones CRUD
   - Stream para observación de cambios

e) Flujo de Datos:
   1. La UI solicita datos a través del repositorio del dominio
   2. La implementación del repositorio usa el DAO
   3. El DAO accede a la base de datos mediante Drift
   4. Los resultados se mapean a modelos
   5. Los modelos se convierten a entidades
   6. Las entidades se devuelven a la UI

f) Convenciones de Código:
   - Nombres de archivos en snake_case
   - Clases en PascalCase
   - Métodos en camelCase
   - IDs son tipo int para tablas principales
   - IDs son String(1) para tablas referenciales

------------------------------------------------------------------------
9. ESTRUCTURA DE LA CAPA DE PRESENTACIÓN (ATOMIC DESIGN)
--------------------------------------
La capa de presentación sigue la metodología Atomic Design para organizar los componentes de UI:

a) Atoms/
   - Componentes más básicos y reutilizables
   - No dependen de otros componentes de la aplicación
   - Ejemplos: botones, inputs, iconos, etiquetas, loaders

b) Molecules/
   - Combinaciones de átomos formando componentes simples pero funcionales
   - Ejemplos: campos de formulario, cards simples, elementos de lista, barras de navegación

c) Organisms/
   - Componentes complejos formados por moléculas y/o átomos
   - Representan secciones completas de una interfaz
   - Ejemplos: formularios completos, modales, cabeceras, paneles

d) Templates/
   - Layouts y estructuras de página sin contenido específico
   - Define la organización de los organismos en la pantalla
   - Se enfoca en la estructura, no en el contenido

e) Screens/
   - Implementaciones concretas de templates con datos reales
   - Coordinan los estados y la lógica con los componentes
   - Son las páginas finales que ve el usuario

f) Ventajas de Atomic Design:
   - Alta cohesión y bajo acoplamiento
   - Componentes reutilizables en toda la aplicación
   - Sistema de diseño consistente
   - Facilita las pruebas unitarias y de interfaz

========================================================================
Fin del Contexto
========================================================================
