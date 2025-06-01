# MoneyT - Capa de Presentación: Atomic Design & Clean Architecture

## 1. Estructura de Directorios Refactorizada

### 1.1. Nueva Organización Propuesta

```bash
lib/presentation/
├── core/                           # Sistema base de UI y funcionalidades globales
│   ├── atoms/                      # Widgets atómicos básicos
│   │   ├── app_button.dart         # Botones estandarizados
│   │   ├── app_text_field.dart     # Campos de texto
│   │   ├── app_icon.dart           # Iconos consistentes
│   │   ├── app_image.dart          # Imágenes y avatares
│   │   ├── app_loading.dart        # Indicadores de carga
│   │   └── app_divider.dart        # Separadores visuales
│   ├── molecules/                  # Componentes compuestos
│   │   ├── form_field_container.dart    # Contenedor de campos
│   │   ├── search_field.dart           # Campo de búsqueda
│   │   ├── empty_state.dart            # Estados vacíos
│   │   ├── error_message_card.dart     # Mensajes de error
│   │   ├── confirm_delete_dialog.dart  # Diálogos de confirmación
│   │   └── icon_selector.dart          # Selector de iconos
│   ├── organisms/                  # Secciones complejas reutilizables
│   │   ├── app_drawer.dart             # Drawer principal
│   │   ├── contact_list_view.dart      # Lista de contactos
│   │   ├── transaction_list_view.dart  # Lista de transacciones
│   │   └── chart_account_tree_view.dart # Vista árbol de cuentas
│   ├── templates/                  # Layouts de página reutilizables
│   │   ├── screen_template.dart        # Template base de pantalla
│   │   ├── form_template.dart          # Template para formularios
│   │   ├── list_template.dart          # Template para listas
│   │   └── detail_template.dart        # Template para detalles
│   ├── theme/                      # Sistema de temas y design tokens
│   │   ├── app_colors.dart             # Paleta de colores
│   │   ├── app_text_styles.dart        # Estilos de tipografía
│   │   ├── app_dimensions.dart         # Espaciados y tamaños
│   │   ├── app_theme.dart              # Configuración tema principal
│   │   ├── light_theme.dart            # Tema claro
│   │   ├── dark_theme.dart             # Tema oscuro
│   │   └── theme_extensions.dart       # Extensiones personalizadas
│   ├── providers/                  # Providers globales del sistema
│   │   ├── theme_provider.dart         # Manejo de temas
│   │   ├── auth_provider.dart          # Estado de autenticación
│   │   └── app_state_provider.dart     # Estado global de la app
│   └── utils/                      # Utilidades de presentación
│       ├── responsive_utils.dart       # Helpers responsivos
│       ├── form_validators.dart        # Validadores de formularios
│       └── date_formatters.dart        # Formateadores de fecha
├── features/                       # Módulos funcionales auto-contenidos
│   ├── auth/                       # Autenticación y onboarding
│   │   ├── welcome_screen.dart         # Pantalla de bienvenida
│   │   ├── login_screen.dart           # Pantalla de login
│   │   ├── register_screen.dart        # Pantalla de registro
│   │   ├── login_form.dart             # Formulario de login
│   │   ├── social_login_buttons.dart   # Botones de login social
│   │   └── auth_provider.dart          # Provider de autenticación
│   ├── dashboard/                  # Panel principal
│   │   ├── home_screen.dart            # Pantalla principal
│   │   ├── balance_summary.dart        # Resumen de balances
│   │   ├── recent_transactions.dart    # Transacciones recientes
│   │   ├── quick_actions.dart          # Acciones rápidas
│   │   └── dashboard_provider.dart     # Provider del dashboard
│   ├── transactions/               # Gestión de transacciones
│   │   ├── transactions_screen.dart    # Lista de transacciones
│   │   ├── transaction_form_screen.dart # Formulario de transacción
│   │   ├── transaction_detail_screen.dart # Detalle de transacción
│   │   ├── transaction_card.dart       # Tarjeta de transacción
│   │   ├── transaction_filters.dart    # Filtros de transacciones
│   │   ├── amount_input.dart           # Input de monto
│   │   └── transaction_provider.dart   # Provider de transacciones
│   ├── contacts/                   # Gestión de contactos
│   │   ├── contacts_screen.dart        # Lista de contactos
│   │   ├── contact_form_screen.dart    # Formulario de contacto
│   │   ├── contact_avatar.dart         # Avatar de contacto
│   │   ├── contact_list_item.dart      # Item de lista de contacto
│   │   └── contact_provider.dart       # Provider de contactos
│   ├── categories/                 # Gestión de categorías
│   │   ├── categories_screen.dart      # Lista de categorías
│   │   ├── category_form_screen.dart   # Formulario de categoría
│   │   ├── category_icon_picker.dart   # Selector de icono de categoría
│   │   └── category_provider.dart      # Provider de categorías
│   ├── wallets/                    # Gestión de billeteras
│   │   ├── wallets_screen.dart         # Lista de billeteras
│   │   ├── wallet_form_screen.dart     # Formulario de billetera
│   │   ├── wallet_balance_card.dart    # Tarjeta de balance
│   │   └── wallet_provider.dart        # Provider de billeteras
│   ├── credit_cards/               # Gestión de tarjetas de crédito
│   │   ├── credit_cards_screen.dart    # Lista de tarjetas
│   │   ├── credit_card_form_screen.dart # Formulario de tarjeta
│   │   ├── credit_card_visual.dart     # Visualización de tarjeta
│   │   └── credit_card_provider.dart   # Provider de tarjetas
│   ├── loans/                      # Gestión de préstamos
│   │   ├── loans_screen.dart           # Lista de préstamos
│   │   ├── loan_form_screen.dart       # Formulario de préstamo
│   │   ├── loan_detail_screen.dart     # Detalle de préstamo
│   │   ├── loan_status_chip.dart       # Chip de estado
│   │   ├── loan_payment_modal.dart     # Modal de pago
│   │   └── loan_provider.dart          # Provider de préstamos
│   ├── journals/                   # Diarios contables
│   │   ├── journals_screen.dart        # Lista de diarios
│   │   ├── journal_detail_screen.dart  # Detalle de diario
│   │   ├── journal_entry_card.dart     # Tarjeta de entrada
│   │   └── journal_provider.dart       # Provider de diarios
│   ├── chart_accounts/             # Plan de cuentas
│   │   ├── chart_accounts_screen.dart  # Lista de cuentas
│   │   ├── chart_account_form_screen.dart # Formulario de cuenta
│   │   ├── account_hierarchy_view.dart # Vista de jerarquía
│   │   └── chart_account_provider.dart # Provider de cuentas
│   ├── backup/                     # Sistema de respaldos
│   │   ├── backup_screen.dart          # Pantalla de respaldos
│   │   ├── backup_list_item.dart       # Item de lista de respaldo
│   │   ├── backup_settings_panel.dart  # Panel de configuración
│   │   └── backup_provider.dart        # Provider de respaldos
│   └── settings/                   # Configuraciones
│       ├── settings_screen.dart        # Pantalla de configuración
│       ├── theme_switcher.dart         # Selector de tema
│       ├── language_selector.dart      # Selector de idioma
│       └── settings_provider.dart      # Provider de configuración
├── shared/                         # Componentes compartidos entre features
│   ├── widgets/                    # Widgets de dominio específico
│   │   ├── currency_display.dart       # Mostrar monedas
│   │   ├── date_picker_field.dart      # Selector de fechas
│   │   ├── amount_input_formatter.dart # Formateador de montos
│   │   └── account_selector_modal.dart # Modal selector de cuentas
│   ├── providers/                  # Estado compartido entre módulos
│   │   ├── loading_provider.dart       # Estados de carga globales
│   │   └── notification_provider.dart  # Sistema de notificaciones
│   └── utils/                      # Utilidades compartidas
│       ├── currency_utils.dart         # Utilidades de moneda
│       └── validation_utils.dart       # Validaciones específicas
└── navigation/                     # Sistema de navegación centralizado
    ├── app_router.dart                 # Router principal con go_router
    ├── route_names.dart                # Constantes de nombres de rutas
    ├── route_generator.dart            # Generador de rutas (legacy)
    ├── navigation_service.dart         # Servicio de navegación
    └── route_guards.dart               # Guards de autenticación
```

### 1.2. Principios de Organización Simplificada

#### **Core (Sistema Base)**
- Componentes que se usan en **toda la aplicación**
- **No depende** de features específicos
- Provee la **base del design system**
- Incluye **providers globales** (tema, auth)

#### **Features (Módulos Funcionales)**
- **Estructura plana**: Todos los archivos relacionados en una sola carpeta
- **Auto-contenidos**: Cada feature incluye todo lo necesario
- **Sin subdivisiones**: Evita complejidad innecesaria
- **Fácil navegación**: Todo el código relacionado está junto

#### **Shared (Compartido)**
- Componentes usados por **múltiples features**
- **Específicos del dominio** MoneyT (no genéricos como core)
- **Reutilizables** pero no fundamentales

#### **Navigation (Navegación)**
- **Sistema centralizado** de rutas
- **Guards de autenticación**
- **Deep linking** y state restoration

## 2. Providers: Lógica de Frontend

### 2.1. ¿Qué Manejan los Providers?

Los **Providers** en MoneyT manejan específicamente la **lógica del frontend**:

#### **Estado de UI**
```dart
class TransactionProvider extends ChangeNotifier {
  // Estados de interfaz
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedFilter = 'all';
  
  // Estados de formularios
  bool _isFormDirty = false;
  Map<String, String> _formErrors = {};
  
  // Estados de navegación
  int _selectedTab = 0;
  bool _isDrawerOpen = false;
}
```

#### **Coordinación entre UI y Use Cases**
```dart
class TransactionProvider extends ChangeNotifier {
  final TransactionUseCases _useCases;
  
  // Coordina acciones de UI con lógica de negocio
  Future<void> loadTransactions() async {
    _setLoading(true);                    // UI: Mostrar loading
    
    try {
      final transactions = await _useCases.getAllTransactions(); // Lógica de negocio
      _transactions = transactions;       // UI: Actualizar lista
      _errorMessage = null;              // UI: Limpiar errores
    } catch (e) {
      _errorMessage = e.toString();      // UI: Mostrar error
    } finally {
      _setLoading(false);               // UI: Ocultar loading
      notifyListeners();                // UI: Reconstruir widgets
    }
  }
}
```

#### **Cache Temporal de Datos**
```dart
class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];
  DateTime? _lastUpdate;
  
  // Cache para evitar llamadas innecesarias
  Future<void> getContacts({bool forceRefresh = false}) async {
    if (!forceRefresh && _isDataFresh()) {
      return; // Usar datos en cache
    }
    
    // Obtener datos frescos
    _contacts = await _useCases.getAllContacts();
    _lastUpdate = DateTime.now();
    notifyListeners();
  }
}
```

### 2.2. Separación de Responsabilidades

#### **Use Cases (Lógica de Negocio)**
- Reglas de negocio
- Validaciones complejas
- Coordinación entre repositorios
- Transacciones de datos

#### **Providers (Lógica de Frontend)**
- Estado de UI (loading, errores, filtros)
- Coordinación UI ↔ Use Cases
- Cache temporal de datos
- Gestión de formularios
- Estado de navegación

#### **Widgets (Presentación)**
- Renderizado visual
- Eventos de usuario
- Animaciones
- Layout responsivo

### 2.3. Flujo de Datos Completo

```
┌─────────────┐    ┌─────────────────┐    ┌──────────────┐    ┌──────────────┐
│   Widget    │───▶│    Provider     │───▶│  Use Cases   │───▶│ Repository   │
│             │    │ (Frontend Logic)│    │(Business Logic)│   │ (Data Layer) │
│ - UI Events │    │ - UI State      │    │ - Validation │    │ - Data Source│
│ - Display   │    │ - Coordination  │    │ - Rules      │    │ - Persistence│
│             │◀───│ - Cache         │◀───│ - Workflow   │◀───│              │
└─────────────┘    └─────────────────┘    └──────────────┘    └──────────────┘
```

## 3. Design Tokens y Sistema de Temas

### 3.1. Jerarquía de Design Tokens

```dart
// core/theme/app_dimensions.dart
class AppDimensions {
  // Espaciado base
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  
  // Radios de bordes
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // Tamaños de iconos
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
}
```

### 3.2. Sistema de Colores Financiero

```dart
// core/theme/app_colors.dart
class AppColors {
  // Colores base
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryVariant = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF4CAF50);
  
  // Colores financieros
  static const Color income = Color(0xFF4CAF50);    // Verde para ingresos
  static const Color expense = Color(0xFFF44336);   // Rojo para gastos
  static const Color transfer = Color(0xFF2196F3);  // Azul para transferencias
  static const Color loan = Color(0xFFFF9800);      // Naranja para préstamos
  
  // Estados
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
}
```

## 4. Patrones de Componentes

### 4.1. Atomic Design en Flutter

#### **Atoms (Átomos)**
```dart
// core/atoms/app_button.dart
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  
  // Implementación consistente con design tokens
}
```

#### **Molecules (Moléculas)**
```dart
// core/molecules/form_field_container.dart
class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? errorText;
  
  // Combina atoms para crear componentes compuestos
}
```

#### **Organisms (Organismos)**
```dart
// core/organisms/app_drawer.dart
class AppDrawer extends StatelessWidget {
  // Sección compleja que combina múltiples molecules
  // y atoms para crear navegación lateral
}
```

#### **Templates (Plantillas)**
```dart
// core/templates/screen_template.dart
class ScreenTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? floatingActionButton;
  
  // Layout base reutilizable para todas las pantallas
}
```

### 4.2. Nomenclatura y Convenciones

#### **Archivos y Clases**
- **snake_case** para nombres de archivos: `transaction_form_screen.dart`
- **PascalCase** para nombres de clases: `TransactionFormScreen`
- **camelCase** para variables y métodos: `isLoading`, `loadTransactions()`

#### **Widgets Específicos**
- **Screen**: Pantallas completas (`TransactionsScreen`)
- **Form**: Formularios (`TransactionFormScreen`)
- **Modal**: Modales y diálogos (`ConfirmDeleteModal`)
- **Card**: Tarjetas de información (`TransactionCard`)
- **List**: Listas y elementos (`TransactionListItem`)
- **Provider**: Gestión de estado (`TransactionProvider`)

## 5. Estado y Providers

### 5.1. Jerarquía de Providers

```dart
// Providers por scope
MultiProvider(
  providers: [
    // Core providers (globales)
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    
    // Feature providers (específicos por módulo)
    ChangeNotifierProvider(create: (_) => TransactionProvider()),
    ChangeNotifierProvider(create: (_) => ContactProvider()),
    ChangeNotifierProvider(create: (_) => BackupProvider()),
    
    // Shared providers (compartidos)
    ChangeNotifierProvider(create: (_) => LoadingProvider()),
  ],
  child: MoneyTApp(),
)
```

### 5.2. Patrón de Provider por Feature

```dart
// features/transactions/transaction_provider.dart
class TransactionProvider extends ChangeNotifier {
  final TransactionUseCases _useCases;
  
  // Estado específico de transacciones
  List<TransactionEntry> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  TransactionType? _selectedType;
  
  // Getters y métodos específicos del dominio
  List<TransactionEntry> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Métodos de UI
  Future<void> loadTransactions() async { /* ... */ }
  void setSearchQuery(String query) { /* ... */ }
  void setTypeFilter(TransactionType? type) { /* ... */ }
}
```

## 6. Plan de Migración Simplificado

### 6.1. Fases de Refactoring

1. **Fase 1**: Crear estructura de carpetas simplificada
2. **Fase 2**: Migrar core (atoms, molecules, organisms, templates)
3. **Fase 3**: Migrar features sin subdivisiones
4. **Fase 4**: Reorganizar providers por scope
5. **Fase 5**: Centralizar navegación
6. **Fase 6**: Testing y documentación

### 6.2. Criterios de Éxito

- ✅ **Compilación exitosa** sin errores
- ✅ **Navegación funcional** en todas las pantallas
- ✅ **Providers funcionando** correctamente
- ✅ **Performance mantenida** o mejorada
- ✅ **Estructura más simple** y mantenible

---

Esta estructura simplificada proporciona una base sólida y **fácil de navegar** para MoneyT, manteniendo la separación de responsabilidades sin la complejidad de múltiples subdirectorios.

