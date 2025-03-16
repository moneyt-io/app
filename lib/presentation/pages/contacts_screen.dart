import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;
import '../../domain/entities/contact.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/contact_list_item.dart';
import '../molecules/search_field.dart';
import '../organisms/app_drawer.dart';
import '../organisms/contact_list_section.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

// Datos de ejemplo para simular contactos
final List<Contact> mockContacts = [
  Contact(
    id: 1,
    name: 'Ana García',
    email: 'ana.garcia@example.com',
    phone: '+1 234 567 890',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 2,
    name: 'Juan Pérez',
    email: 'juan.perez@example.com',
    phone: '+1 987 654 321',
    note: 'Contacto de trabajo',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 3,
    name: 'María Rodríguez',
    email: 'maria@example.com',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 4,
    name: 'Carlos López',
    phone: '+1 555 123 456',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 5,
    name: 'Sofía Martínez',
    email: 'sofia@example.com',
    phone: '+1 777 888 999',
    note: 'Amigo',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 6,
    name: 'Luis Torres',
    email: 'luis@example.com',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 7,
    name: 'Elena Ramírez',
    phone: '+1 444 333 222',
    active: true,
    createdAt: DateTime.now(),
  ),
  Contact(
    id: 8,
    name: 'Daniel Sánchez',
    email: 'daniel@example.com',
    phone: '+1 222 111 000',
    active: true,
    createdAt: DateTime.now(),
  ),
];

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<Contact> _contacts = [...mockContacts]; // Hacer una copia para poder modificarla

  Future<void> _navigateToForm({Contact? contact, device_contacts.Contact? deviceContact}) async {
    final args = {
      'contact': contact,
      'deviceContact': deviceContact,
    };
    // Al regresar del formulario, actualizamos la lista
    final result = await NavigationService.navigateTo(AppRoutes.contactForm, arguments: args);
    if (result != null && result is Contact) {
      setState(() {
        if (contact != null) {
          // Actualizar contacto existente
          final index = _contacts.indexWhere((c) => c.id == contact.id);
          if (index >= 0) {
            _contacts[index] = result;
          }
        } else {
          // Añadir nuevo contacto
          _contacts.add(result);
        }
      });
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar contacto'),
          content: const Text('¿Estás seguro de que deseas eliminar este contacto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      setState(() {
        _contacts.removeWhere((c) => c.id == contact.id);
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Contacto eliminado con éxito'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
          const SizedBox(height: 16),
          Expanded(
            child: Builder(
              builder: (context) {
                if (_contacts.isEmpty) {
                  return const EmptyState(
                    icon: Icons.people_outline,
                    title: 'No hay contactos',
                    message: 'Crea un nuevo contacto para comenzar',
                  );
                }

                final filteredContacts = _contacts
                    .where((contact) =>
                        contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        (contact.email?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()) ||
                        (contact.phone?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()))
                    .toList()
                  ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

                if (filteredContacts.isEmpty) {
                  return const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sin resultados',
                    message: 'No se encontraron contactos que coincidan con la búsqueda',
                  );
                }

                // Agrupar contactos por letra inicial
                final groupedContacts = <String, List<Contact>>{};
                for (final contact in filteredContacts) {
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
                    );
                  },
                );
              },
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
}
