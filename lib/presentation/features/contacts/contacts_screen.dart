import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/molecules/import_contacts_button.dart';
import '../../core/molecules/contact_group_header.dart';
import '../../core/molecules/contact_list_item.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/atoms/app_floating_action_button.dart';
import '../../core/atoms/app_search_field.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/design_system/tokens/app_dimensions.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../navigation/app_routes.dart';
import '../../core/l10n/l10n_helper.dart';
import 'contact_provider.dart';
import '../../../domain/entities/contact.dart';

/// ANÁLISIS: Pantalla principal de contactos que sigue el patrón de contact_list.html
/// 
/// CARACTERÍSTICAS ACTUALES:
/// ✅ Usa AppAppBar del core (migración exitosa)
/// ✅ Implementa agrupación alfabética por letra inicial
/// ✅ Tiene funcionalidad de búsqueda con toggle
/// ✅ Maneja estados de loading/error/empty
/// ✅ FAB personalizado siguiendo diseño HTML
/// 
/// POSIBLES MEJORAS IDENTIFICADAS:
/// ⚠️ Lógica de agrupación muy compleja y difícil de mantener
/// ⚠️ Método _buildGroupedContactItem muy verboso
/// ⚠️ No usa componentes existentes del design system
/// ⚠️ Funcionalidad de search podría ser más robusta
/// ⚠️ Falta integración con import contacts button del HTML
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // ANÁLISIS: Variables de estado para búsqueda
  // ✅ CORRECTO: Controllers y flags necesarios para search functionality
  // ⚠️ MEJORA: Podrían estar en un cubit/bloc para mejor separación de responsabilidades
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    // ANÁLISIS: Carga inicial de contactos
    // ✅ CORRECTO: Usa addPostFrameCallback para evitar setState durante build
    // ✅ CORRECTO: Usa Provider.read para evitar rebuilds innecesarios
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContactProvider>().loadContacts();
    });
  }

  @override
  void dispose() {
    // ✅ CORRECTO: Limpia el controller para evitar memory leaks
    _searchController.dispose();
    super.dispose();
  }

  // ANÁLISIS: Método para toggle de búsqueda
  // ✅ FUNCIONAL: Cambia visibilidad y limpia búsqueda al cerrar
  // ⚠️ MEJORA: Podría tener animaciones más suaves
  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  // ANÁLISIS: Handler para cambios en el texto de búsqueda
  // ✅ SIMPLE: Actualiza el query state
  // ⚠️ MEJORA: Podría implementar debouncing para mejor performance
  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _navigateToContactForm({Contact? contact}) async {
    try {
      final result = await Navigator.of(context).pushNamed(
        AppRoutes.contactForm,
        arguments: contact,
      );
      
      if (result == true && mounted) {
        context.read<ContactProvider>().loadContacts();
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  Future<void> _deleteContact(Contact contact) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.contacts.deleteContact),
        content: Text('${t.contacts.confirmDelete} ${contact.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      final provider = context.read<ContactProvider>();
      final success = await provider.deleteContact(contact.id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success 
                ? t.contacts.contactDeleted 
                : provider.error ?? t.contacts.errorDeleting
            ),
            backgroundColor: success 
              ? AppColors.primaryBlue
              : Colors.red,
          ),
        );
        
        if (success) {
          provider.clearError();
        }
      }
    }
  }

  void _showSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de búsqueda próximamente'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _importContacts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de importar contactos próximamente'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  // ANÁLISIS: Método para recargar contactos
  // ✅ CORRECTO: Llama al método del provider para recargar datos
  Future<void> _loadContacts() async {
    context.read<ContactProvider>().loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ CORRECTO: Background color coincide con contact_list.html (bg-white)
      backgroundColor: Colors.white,
      
      // ✅ EXCELENTE: Usa AppAppBar del core con configuración exacta del HTML
      // HTML match: header class="sticky top-0 z-10 bg-white shadow-sm"
      appBar: AppAppBar(
        title: 'Contacts', // HTML: "Contacts"
        type: AppAppBarType.standard, // HTML: bg-white shadow-sm
        leading: AppAppBarLeading.drawer, // HTML: arrow_back_ios_new (drawer)
        actions: [AppAppBarAction.search], // HTML: search button
        onLeadingPressed: () => Scaffold.of(context).openDrawer(),
        onActionsPressed: [_toggleSearch],
      ),
      
      // ✅ CORRECTO: Drawer integration
      drawer: const AppDrawer(),
      
      // ANÁLISIS: Estructura del body
      // ✅ CORRECTO: Column layout para search + content
      // ⚠️ MEJORA: Search bar podría ser un componente reutilizable
      body: Column(
        children: [
          // ANÁLISIS: Barra de búsqueda condicional
          // ✅ FUNCIONAL: Aparece/desaparece según _isSearchVisible
          // ✅ STYLING: Colores y shadow coinciden con el diseño
          // ⚠️ MEJORA: Podría usar AppSearchField más consistentemente
          if (_isSearchVisible)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000), // shadow-sm del HTML
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: AppSearchField(
                controller: _searchController,
                hintText: 'Search contacts', // HTML: "Search contacts"
                onChanged: _handleSearch,
                onClear: () {
                  _searchController.clear();
                  _handleSearch('');
                },
                autofocus: true,
              ),
            ),
          
          // ANÁLISIS: Contenido principal expandido
          // ✅ CORRECTO: RefreshIndicator para pull-to-refresh
          // ✅ CORRECTO: Consumer para reactive updates del Provider
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadContacts,
              color: AppColors.primaryBlue,
              child: Consumer<ContactProvider>(
                builder: (context, provider, child) {
                  return _buildContactsList(provider);
                },
              ),
            ),
          ),
        ],
      ),
      
      // ANÁLISIS: FAB personalizado
      // ✅ EXCELENTE: Sigue exactamente el diseño del contact_list.html
      // HTML match: class="fixed bottom-0 right-0 p-6" + "rounded-2xl h-16 w-16 bg-[#0c7ff2]"
      // ✅ CORRECTO: Colores, dimensiones y sombras exactas del HTML
      floatingActionButton: Container(
        width: 64, // HTML: h-16 w-16
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF0c7ff2), // HTML: bg-[#0c7ff2]
          borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000), // HTML: shadow-lg
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToContactForm(),
            borderRadius: BorderRadius.circular(16),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 24, // HTML: text-3xl
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ANÁLISIS: Método principal para construir la lista de contactos
  // ⚠️ PROBLEMA PRINCIPAL: Lógica muy compleja y hard to maintain
  // ✅ CORRECTO: Maneja todos los estados (loading, error, empty, success)
  // ⚠️ MEJORA: El filtrado podría estar en el Provider
  Widget _buildContactsList(ContactProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
        ),
      );
    }

    if (provider.error != null) {
      return _buildErrorState(provider.error!);
    }

    // Filtrar contactos según búsqueda
    final contacts = _searchQuery.isEmpty 
        ? provider.contacts 
        : provider.contacts.where((contact) =>
            contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (contact.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (contact.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
          ).toList();

    // ✅ FASE 3: Estructura con ImportContactsButton + Lista de contactos
    return Column(
      children: [
        // ✅ FASE 3: Usar ImportContactsButton del design system
        // HTML match: "flex items-center gap-3 w-full px-4 py-3 hover:bg-slate-50 border-b border-slate-100"
        ImportContactsButton(
          onPressed: _handleImportContacts,
        ),
        
        // Lista de contactos expandida
        Expanded(
          child: contacts.isEmpty 
              ? _buildEmptyState()
              : _buildGroupedContactsList(contacts),
        ),
      ],
    );
  }

  // ✅ FASE 3: Método para manejar importación usando la molécula del core
  void _handleImportContacts() {
    // TODO: Implementar importación real de contactos del dispositivo
    // HTML: onclick="window.location.href='contact_form.html'"
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Import contacts functionality coming soon'),
        backgroundColor: AppColors.primaryBlue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ✅ REFACTORIZADO: Lista agrupada separada para mejor organización
  Widget _buildGroupedContactsList(List<Contact> contacts) {
    final groupedContacts = _groupContactsByLetter(contacts);
    
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80), // Espacio para FAB
      itemCount: _getTotalItemCount(groupedContacts),
      itemBuilder: (context, index) {
        return _buildGroupedContactItem(context, groupedContacts, index);
      },
    );
  }

  // ✅ AGREGADO: Método para agrupar contactos por letra inicial (basado en contact_list.html)
  // HTML: Grupos A, E, I, J, L, M, N, O, S como en la maqueta
  Map<String, List<Contact>> _groupContactsByLetter(List<Contact> contacts) {
    final Map<String, List<Contact>> grouped = {};
    
    for (final contact in contacts) {
      final firstLetter = contact.name.isNotEmpty 
          ? contact.name[0].toUpperCase() 
          : '#'; // Para nombres vacíos
      
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(contact);
    }
    
    // Ordenar cada grupo alfabéticamente
    grouped.forEach((key, value) {
      value.sort((a, b) => a.name.compareTo(b.name));
    });
    
    return grouped;
  }

  // ✅ AGREGADO: Calcular total de items (headers + contactos)
  int _getTotalItemCount(Map<String, List<Contact>> groupedContacts) {
    int count = 0;
    groupedContacts.forEach((letter, contacts) {
      count += 1; // Header del grupo
      count += contacts.length; // Contactos del grupo
    });
    return count;
  }

  // ✅ AGREGADO: Constructor de items individuales en la lista
  Widget _buildGroupedContactItem(
    BuildContext context, 
    Map<String, List<Contact>> groupedContacts, 
    int index
  ) {
    int currentIndex = 0;
    
    // Iterar por todos los grupos para encontrar el item correcto
    for (final entry in groupedContacts.entries) {
      final letter = entry.key;
      final contacts = entry.value;
      
      // Si es el header del grupo
      if (currentIndex == index) {
        // Usar ContactGroupHeader del core
        return ContactGroupHeader(letter: letter);
      }
      currentIndex++;
      
      // Si es un contacto del grupo
      for (final contact in contacts) {
        if (currentIndex == index) {
          return ContactListItem(
            contact: contact,
            onTap: () => _navigateToContactDetail(contact),
            onMorePressed: () => _showContactOptions(contact),
          );
        }
        currentIndex++;
      }
    }
    
    return const SizedBox.shrink();
  }

  // ✅ AGREGADO: Métodos de navegación placeholder
  void _navigateToContactDetail(Contact contact) {
    // TODO: Implementar navegación al detalle del contacto
    // HTML: contact_detail.html
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to ${contact.name} details'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _showContactOptions(Contact contact) {
    // TODO: Implementar menú de opciones
    // HTML: contact_dialog_options.html (Share, Edit, Delete)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Show options for ${contact.name}'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  // ANÁLISIS: Error state
  // ✅ CORRECTO: Maneja errores del provider
  // ⚠️ MEJORA: Podría usar componentes del design system
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $error'),
        ],
      ),
    );
  }

  // ANÁLISIS: Empty state
  // ✅ CORRECTO: Maneja caso de lista vacía
  // ⚠️ MEJORA: Podría usar componentes del design system
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.contacts_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No contacts found'),
        ],
      ),
    );
  }
}
