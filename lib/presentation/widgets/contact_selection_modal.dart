// lib/presentation/widgets/contact_selection_modal.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/contact_usecases.dart';

class ContactSelectionModal extends StatefulWidget {
  final List<Contact> contacts;
  final Function(Contact) onContactSelected;
  final CreateContact createContact;

  const ContactSelectionModal({
    Key? key,
    required this.contacts,
    required this.onContactSelected,
    required this.createContact,
  }) : super(key: key);

  @override
  State<ContactSelectionModal> createState() => _ContactSelectionModalState();
}

class _ContactSelectionModalState extends State<ContactSelectionModal> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _filteredContacts = widget.contacts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredContacts = widget.contacts
          .where((contact) => contact.name.toLowerCase().contains(_searchQuery))
          .toList();
    });
  }

  Future<void> _createAndSelectContact(String name) async {
    try {
      final newContact = Contact(
        id: null,
        name: name.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdContact = await widget.createContact(newContact);
      if (mounted) {
        Navigator.pop(context);
        widget.onContactSelected(createdContact);
      }
    } catch (e) {
      if (mounted) {
        final translations = context.read<LanguageManager>().translations;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${translations.error}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    translations.selectContact,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      final permission = await device_contacts.FlutterContacts.requestPermission(readonly: true);
                      if (!permission) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(translations.contactsPermissionDenied),
                            backgroundColor: colorScheme.error,
                          ),
                        );
                        return;
                      }

                      final contact = await device_contacts.FlutterContacts.openExternalPick();
                      if (contact == null || !context.mounted) return;

                      final fullContact = await device_contacts.FlutterContacts.getContact(contact.id);
                      if (fullContact == null) return;

                      // Crear un nuevo contacto con los datos importados
                      final newContact = Contact(
                        id: null,
                        name: fullContact.displayName,
                        email: fullContact.emails.isNotEmpty ? fullContact.emails.first.address : null,
                        phone: fullContact.phones.isNotEmpty 
                            ? (fullContact.phones.first.normalizedNumber.isNotEmpty 
                                ? fullContact.phones.first.normalizedNumber 
                                : fullContact.phones.first.number)
                            : null,
                        notes: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      final createdContact = await widget.createContact(newContact);
                      if (!context.mounted) return;
                      
                      widget.onContactSelected(createdContact);
                      Navigator.pop(context);
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(translations.contactsError),
                          backgroundColor: colorScheme.error,
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: colorScheme.primary,
                  ),
                  tooltip: translations.importContacts,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: translations.searchOrCreateContact,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: _filterContacts,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty && _filteredContacts.isEmpty) {
                  _createAndSelectContact(value);
                }
              },
            ),
          ),

          // Lista de contactos
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _filteredContacts.isEmpty && _searchQuery.isNotEmpty
                  ? 1 // Mostrar opción de crear contacto
                  : _filteredContacts.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (_filteredContacts.isEmpty && _searchQuery.isNotEmpty) {
                  // Mostrar opción para crear nuevo contacto
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.add,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      '${translations.createContact}: $_searchQuery',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    onTap: () => _createAndSelectContact(_searchQuery),
                  );
                }

                final contact = _filteredContacts[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(contact.name),
                  subtitle: contact.email != null || contact.phone != null
                      ? Text([
                          if (contact.email != null) contact.email,
                          if (contact.phone != null) contact.phone,
                        ].where((e) => e != null).join(' • '))
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onContactSelected(contact);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
