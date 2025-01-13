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
    _filteredContacts = List.from(widget.contacts)..sort((a, b) => 
      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
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
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom + mediaQuery.padding.bottom;
    final screenHeight = mediaQuery.size.height;
    
    // Calcula el alto dinámicamente
    final bool isKeyboardOpen = mediaQuery.viewInsets.bottom > 0;
    final double modalHeight = isKeyboardOpen ? screenHeight * 0.85 : screenHeight * 0.5;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: modalHeight,
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: bottomPadding + 16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de arrastre
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    translations.selectContact,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _pickDeviceContact,
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
            const SizedBox(height: 16),

            // Barra de búsqueda
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: translations.searchOrCreateContact,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.outline,
                  ),
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
            const SizedBox(height: 16),

            // Lista de contactos
            Flexible(
              child: ListView.builder(
                itemCount: _filteredContacts.isEmpty && _searchQuery.isNotEmpty
                    ? 1
                    : _filteredContacts.length,
                itemBuilder: (context, index) {
                  if (_filteredContacts.isEmpty && _searchQuery.isNotEmpty) {
                    return _buildCreateContactCard(_searchQuery);
                  }
                  return _buildContactCard(_filteredContacts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            contact.name[0].toUpperCase(),
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: contact.email != null || contact.phone != null
            ? Text(
                [
                  if (contact.email != null) contact.email,
                  if (contact.phone != null) contact.phone,
                ].where((e) => e != null).join(' • '),
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          widget.onContactSelected(contact);
        },
      ),
    );
  }

  Widget _buildCreateContactCard(String name) {
    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.read<LanguageManager>().translations;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            Icons.add,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          '${translations.createContact}: $name',
          style: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => _createAndSelectContact(name),
      ),
    );
  }

  Future<void> _pickDeviceContact() async {
    try {
      final permission = await device_contacts.FlutterContacts.requestPermission(readonly: true);
      if (!permission) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.read<LanguageManager>().translations.contactsPermissionDenied),
            backgroundColor: Theme.of(context).colorScheme.error,
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
          content: Text(context.read<LanguageManager>().translations.contactsError),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}