import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../atoms/app_button.dart';
import '../../molecules/empty_state.dart';
import '../../molecules/search_field.dart';
import '../../organisms/app_drawer.dart';
import '../../organisms/contact_list_section.dart';
import '../../routes/navigation_service.dart';
import '../../routes/app_routes.dart';
import '../../molecules/confirm_delete_dialog.dart'; // Añadir esta importación
import '../../organisms/contact_list_view.dart';

// Eliminamos la lista de datos mock ya que usaremos datos reales

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<Contact> _contacts = [];
  bool _isLoading = true;
  String? _error;
  
  // Usar el caso de uso a través de GetIt
  late final ContactUseCases _contactUseCases;

  @override
  void initState() {
    super.initState();
    _contactUseCases = GetIt.instance<ContactUseCases>();
    _loadContacts();
  }
  
  Future<void> _loadContacts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final contacts = await _contactUseCases.getAllContacts();
      
      if (mounted) {
        setState(() {
          _contacts = contacts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _navigateToForm({Contact? contact, device_contacts.Contact? deviceContact}) async {
    final args = {
      'contact': contact,
      'deviceContact': deviceContact,
    };
    // Al regresar del formulario, actualizamos la lista
    final result = await NavigationService.navigateTo(AppRoutes.contactForm, arguments: args);
    if (result != null && result is Contact) {
      _loadContacts(); // Recargar contactos en lugar de manipular la lista local
    }
  }

  Future<void> _pickDeviceContact() async {
    try {
      final permission = await device_contacts.FlutterContacts.requestPermission(readonly: true);
      if (!permission) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Permiso denegado para acceder a los contactos'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }

      final contact = await device_contacts.FlutterContacts.openExternalPick();
      if (contact == null || !mounted) return;

      final fullContact = await device_contacts.FlutterContacts.getContact(contact.id);
      if (fullContact == null) return;

      _navigateToForm(deviceContact: fullContact);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _deleteContact(Contact contact) async {
    // Reemplazar el AlertDialog directo con ConfirmDeleteDialog
    final confirmed = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar contacto',
      message: '¿Estás seguro de que deseas eliminar',
      itemName: contact.name,
      icon: Icons.person_outline,
      isDestructive: true,
    );

    if (confirmed == true && mounted) {
      try {
        await _contactUseCases.deleteContact(contact.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contacto eliminado con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          
          _loadContacts(); // Recargar contactos después de eliminar
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar contacto: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    final filteredContacts = _contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (contact.email?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()) ||
            (contact.phone?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        centerTitle: true,
        elevation: 0,
        // Eliminamos el botón de recargar
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar contactos',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Cuerpo principal
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? _buildErrorState()
                    : RefreshIndicator(
                        onRefresh: _refreshContacts,
                        child: filteredContacts.isEmpty
                            ? _buildEmptyState()
                            : ContactListView(
                                contacts: filteredContacts,
                                onContactTap: _navigateToContactForm,
                                onContactDelete: _deleteContact,
                              ),
                      ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'importContact',
            onPressed: _pickDeviceContact,
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            child: const Icon(Icons.person_add_alt_1_rounded),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'addContact',
            onPressed: () => _navigateToForm(),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            child: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContent(List<Contact> contacts) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar los contactos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_error!),
            const SizedBox(height: 16),
            AppButton(
              text: 'Reintentar',
              onPressed: _loadContacts,
              type: AppButtonType.primary,
            ),
          ],
        ),
      );
    }
    
    if (contacts.isEmpty) {
      if (_searchQuery.isNotEmpty) {
        return const EmptyState(
          icon: Icons.search_off,
          title: 'Sin resultados',
          message: 'No se encontraron contactos que coincidan con la búsqueda',
        );
      } else {
        return const EmptyState(
          icon: Icons.people_outline,
          title: 'No hay contactos',
          message: 'Crea un nuevo contacto para comenzar',
        );
      }
    }

    // Agrupar contactos por letra inicial
    final groupedContacts = <String, List<Contact>>{};
    for (final contact in contacts) {
      final initial = contact.name.isNotEmpty 
        ? contact.name[0].toUpperCase() 
        : '#';
      groupedContacts.putIfAbsent(initial, () => []).add(contact);
    }

    final sortedKeys = groupedContacts.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final letter = sortedKeys[index];
        final contactsInGroup = groupedContacts[letter]!;

        return ContactListSection(
          title: letter,
          contacts: contactsInGroup,
          onContactTap: (contact) => _navigateToForm(contact: contact),
          onContactDelete: _deleteContact,
          onContactCall: _handleCallContact,
          onContactEmail: _handleEmailContact,
        );
      },
    );
  }

  // Agregamos métodos para manejar las acciones de contactos
  Future<void> _handleCallContact(Contact contact) async {
    if (contact.phone == null || contact.phone!.isEmpty) return;
    
    final phoneUri = Uri.parse('tel:${contact.phone}');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se puede iniciar la llamada: ${contact.phone}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
  
  Future<void> _handleEmailContact(Contact contact) async {
    if (contact.email == null || contact.email!.isEmpty) return;
    
    final emailUri = Uri.parse('mailto:${contact.email}');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se puede abrir el correo: ${contact.email}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // Añadir esta función que falta para mostrar el estado de error
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.iconSizeXLarge,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          Text(
            'Error al cargar contactos',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDimensions.spacing8),
          Text(_error ?? 'Error desconocido'),
          const SizedBox(height: AppDimensions.spacing24),
          AppButton(
            text: 'Reintentar',
            onPressed: _loadContacts,
            type: AppButtonType.primary,
          ),
        ],
      ),
    );
  }

  // Añadir este método para el refresh (es un alias de _loadContacts)
  Future<void> _refreshContacts() async {
    return _loadContacts();
  }

  // Añadir este método para navegar al formulario de contacto (alias para _navigateToForm)
  void _navigateToContactForm(Contact contact) {
    _navigateToForm(contact: contact);
  }

  // Añadir este método para mostrar el estado vacío
  Widget _buildEmptyState() {
    return ListView(
      children: [
        EmptyState(
          icon: Icons.people_outline,
          title: _searchQuery.isEmpty 
              ? 'No hay contactos' 
              : 'No hay resultados',
          message: _searchQuery.isEmpty 
              ? 'Añade tu primer contacto para comenzar' 
              : 'No se encontraron contactos que coincidan con "$_searchQuery"',
          action: _searchQuery.isNotEmpty ? AppButton(
            text: 'Limpiar búsqueda',
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
            },
            type: AppButtonType.text,
          ) : null,
        ),
      ],
    );
  }
}
