// lib/presentation/widgets/contact_selection_modal.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      translations.selectContact,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
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
                controller: scrollController,
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
      ),
    );
  }
}
