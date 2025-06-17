import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/import_contacts_button.dart';
import '../../core/molecules/contact_group_header.dart';
import '../../core/molecules/contact_list_item.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/contact_options_dialog.dart'; // AGREGADO: Import del diálogo
import '../../core/atoms/app_floating_action_button.dart';
import '../../core/atoms/app_search_field.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/design_system/tokens/app_dimensions.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../navigation/app_routes.dart';
import '../../core/l10n/l10n_helper.dart';
import 'contact_provider.dart';
import '../../../domain/entities/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    // ANÁLISIS: Carga inicial de contactos
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
  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  // ANÁLISIS: Método para manejar importación de contactos
  void _handleImportContacts() {
    // TODO: Implementar importación real de contactos del dispositivo
    // HTML: onclick para "Import contact" button
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Import contacts functionality coming soon'),
        backgroundColor: AppColors.primaryBlue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ANÁLISIS: Handler para cambios en el texto de búsqueda
  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    // TODO: Cuando ContactProvider tenga método de búsqueda, se puede implementar aquí
    // final provider = context.read<ContactProvider>();
    // if (provider.searchContacts != null) {
    //   provider.searchContacts!(query);
    // }
  }

  /// Navegación al formulario de contactos con resultado opcional
  Future<void> _navigateToContactForm({Contact? contact}) async {
    try {
      // ✅ AGREGADO: Logging detallado para debugging
      debugPrint('🔍 Navigating to contact form with contact: ${contact?.toString()}');
      debugPrint('🔍 Contact type: ${contact.runtimeType}');
      debugPrint('🔍 Route: ${AppRoutes.contactForm}');
      
      final result = await Navigator.of(context).pushNamed(
        AppRoutes.contactForm,
        arguments: contact, // Contact? directo
      );
      
      debugPrint('🔍 Navigation result: $result');
      
      if (result == true && mounted) {
        context.read<ContactProvider>().loadContacts();
      }
    } catch (e, stackTrace) {
      // ✅ MEJORADO: Logging detallado del error
      debugPrint('❌ Navigation error: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to contact form: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5), // Más tiempo para leer el error
          ),
        );
      }
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
  Future<void> _loadContacts() async {
    context.read<ContactProvider>().loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppAppBar(
        title: 'Contacts',
        type: AppAppBarType.standard,
        leading: AppAppBarLeading.drawer,
        actions: [AppAppBarAction.search],
        onLeadingPressed: () => Scaffold.of(context).openDrawer(),
        onActionsPressed: [_toggleSearch],
      ),
      
      drawer: const AppDrawer(),
      
      body: Column(
        children: [
          // Search bar cuando está visible
          if (_isSearchVisible)
            Container(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.spacing16, 
                AppDimensions.spacing8, 
                AppDimensions.spacing16, 
                AppDimensions.spacing16
              ), // ✅ MEJORA 3: Usar AppDimensions
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: AppSearchField(
                controller: _searchController,
                hintText: 'Search contacts',
                onChanged: _handleSearch,
                onClear: () {
                  _searchController.clear();
                  _handleSearch('');
                },
                autofocus: true,
              ),
            ),
          
          // Contenido principal expandido
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
      
      // ✅ MEJORA 2: Usar AppFloatingActionButton del design system
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToContactForm(),
        icon: Icons.add,
        tooltip: 'Add new contact', // TODO: Usar t.contacts.addContact cuando esté disponible
        backgroundColor: const Color(0xFF0c7ff2), // HTML: bg-[#0c7ff2]
      ),
    );
  }

  // ANÁLISIS: Método principal para construir la lista de contactos

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

    // ✅ CORREGIDO: Usar solo filtrado local en lugar de provider.filteredContacts inexistente
    final contacts = _searchQuery.isEmpty 
        ? provider.contacts 
        : provider.contacts.where((contact) =>
            contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (contact.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (contact.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
          ).toList();

    return Column(
      children: [
        // Import Contacts Button
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

  Widget _buildGroupedContactsList(List<Contact> contacts) {
    final groupedContacts = _groupContactsByLetter(contacts);
    
    return ListView.builder(
      padding: EdgeInsets.only(bottom: AppDimensions.spacing64 + AppDimensions.spacing16), // ✅ CORREGIDO: 64 + 16 = 80px para FAB
      itemCount: _getTotalItemCount(groupedContacts),
      itemBuilder: (context, index) {
        return _buildGroupedContactItem(context, groupedContacts, index);
      },
    );
  }

  // ✅ REFACTORIZADO: Lista agrupada separada para mejor organización
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
    ContactOptionsDialog.show(
      context: context,
      contact: contact,
      onOptionSelected: (option) => _handleContactOption(contact, option),
    );
  }

  /// Maneja las opciones seleccionadas del diálogo
  void _handleContactOption(Contact contact, ContactOption option) {
    switch (option) {
      case ContactOption.call:
        _callContact(contact);
        break;
      case ContactOption.message:
        _messageContact(contact);
        break;
      case ContactOption.share:
        _shareContact(contact);
        break;
      case ContactOption.edit:
        // ✅ MEJORA 2: Habilitada navegación a edición de contacto
        _navigateToContactForm(contact: contact);
        break;
      case ContactOption.delete:
        _deleteContact(contact);
        break;
    }
  }

  /// Placeholder para llamar contacto
  void _callContact(Contact contact) {
    if (contact.phone?.isNotEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Calling ${contact.phone}'),
          backgroundColor: AppColors.primaryBlue,
        ),
      );
    }
  }

  /// Placeholder para enviar mensaje
  void _messageContact(Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Messaging ${contact.name}'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  /// Placeholder para compartir contacto
  void _shareContact(Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${contact.name}'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  // ...existing code...

  // ✅ MEJORA 1: Usar EmptyState del design system
  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.contacts_outlined,
      title: _searchQuery.isEmpty 
          ? 'No contacts found' 
          : 'No search results',
      message: _searchQuery.isEmpty 
          ? 'Add your first contact to get started managing your connections'
          : 'No contacts match "$_searchQuery". Try a different search term.',
      action: _searchQuery.isNotEmpty 
          ? AppButton(
              text: 'Clear search',
              onPressed: () {
                _searchController.clear();
                _handleSearch('');
                _toggleSearch(); // Cerrar búsqueda
              },
              type: AppButtonType.text,
            )
          : AppButton(
              text: 'Add contact',
              onPressed: () => _navigateToContactForm(),
              type: AppButtonType.filled,
            ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16), // ✅ MEJORA 3: Usar AppDimensions
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing64, // ✅ MEJORA 3: Usar AppDimensions
              color: Colors.red,
            ),
            SizedBox(height: AppDimensions.spacing16), // ✅ MEJORA 3: Usar AppDimensions
            const Text(
              'Error loading contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.spacing8), // ✅ MEJORA 3: Usar AppDimensions
            Text(error),
            SizedBox(height: AppDimensions.spacing16), // ✅ MEJORA 3: Usar AppDimensions
            AppButton(
              text: 'Retry',
              onPressed: _loadContacts,
              type: AppButtonType.filled,
            ),
          ],
        ),
      ),
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
}
