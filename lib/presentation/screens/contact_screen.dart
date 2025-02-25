// lib/presentation/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../domain/entities/contact.dart' as domain;
import '../../domain/usecases/contact_usecases.dart';
import '../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import './contact_form.dart';

class ContactScreen extends StatefulWidget {
  final GetContacts getContacts;
  final CreateContact createContact;
  final UpdateContact updateContact;
  final DeleteContact deleteContact;

  const ContactScreen({
    Key? key,
    required this.getContacts,
    required this.createContact,
    required this.updateContact,
    required this.deleteContact,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  Future<void> _navigateToForm(BuildContext context, {domain.Contact? contact, Contact? deviceContact}) async {
    final args = ContactFormArgs(
      contact: contact,
      deviceContact: deviceContact,
    );
    await Navigator.pushNamed(
      context,
      AppRoutes.contactForm,
      arguments: args,
    );
  }

  Future<void> _pickContact(BuildContext context) async {
    try {
      final permission = await FlutterContacts.requestPermission(readonly: true);
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

      final contact = await FlutterContacts.openExternalPick();
      if (contact == null || !context.mounted) return;

      final fullContact = await FlutterContacts.getContact(contact.id);
      if (fullContact == null) return;

      final args = ContactFormArgs(
        deviceContact: fullContact,
      );
      
      await Navigator.pushNamed(
        context,
        AppRoutes.contactForm,
        arguments: args,
      );
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

  Future<void> _deleteContact(domain.Contact contact) async {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(translations.deleteContactTitle),
          content: Text(translations.deleteContactMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(translations.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
              child: Text(translations.delete),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      try {
        await widget.deleteContact(contact.id!);
        setState(() {});
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translations.deleteContactSuccess),
              backgroundColor: colorScheme.primary,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: colorScheme.error,
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
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translations.contacts,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: SearchBar(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                hintText: translations.searchContacts,
                leading: Icon(
                  Icons.search_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                trailing: [
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      icon: Icon(
                        Icons.clear_rounded,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16),
                ),
                backgroundColor: MaterialStateProperty.all(
                  colorScheme.surfaceVariant.withOpacity(0.3),
                ),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outline.withOpacity(0.5),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<domain.Contact>>(
                stream: widget.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(color: colorScheme.error),
                      ),
                    );
                  }

                  final contacts = snapshot.data ?? [];
                  if (contacts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_rounded,
                            size: 64,
                            color: colorScheme.primary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? translations.noContactsMessage
                                : translations.noContactsFound,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final filteredContacts = contacts
                      .where((contact) =>
                          contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          (contact.email?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()) ||
                          (contact.phone?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase()))
                      .toList()
                    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

                  if (filteredContacts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_rounded,
                            size: 64,
                            color: colorScheme.primary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? translations.noContactsMessage
                                : translations.noContactsFound,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Agrupar contactos por letra inicial
                  final groupedContacts = <String, List<domain.Contact>>{};
                  for (final contact in filteredContacts) {
                    final initial = contact.name[0].toUpperCase();
                    groupedContacts.putIfAbsent(initial, () => []).add(contact);
                  }

                  final sortedKeys = groupedContacts.keys.toList()..sort();

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    itemCount: sortedKeys.length * 2, // multiplicamos por 2 para incluir los headers
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        // Construir la lista de contactos para esta letra
                        final letterIndex = index ~/ 2;
                        final letter = sortedKeys[letterIndex];
                        final contactsInGroup = groupedContacts[letter]!;

                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: contactsInGroup.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final contact = contactsInGroup[index];
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: colorScheme.outlineVariant,
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () => _navigateToForm(context, contact: contact),
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: colorScheme.primary.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            contact.name[0].toUpperCase(),
                                            style: textTheme.titleLarge?.copyWith(
                                              color: colorScheme.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact.name,
                                              style: textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (contact.email != null || contact.phone != null) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                contact.email ?? contact.phone ?? '',
                                                style: textTheme.bodyMedium?.copyWith(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteContact(contact),
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: colorScheme.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        // Construir el header de la letra
                        final letterIndex = index ~/ 2;
                        final letter = sortedKeys[letterIndex];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            letter,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'pickContact',
            onPressed: () => _pickContact(context),
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            elevation: 4,
            child: const Icon(Icons.person_add_alt_1_rounded),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'addContact',
            onPressed: () => _navigateToForm(context),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 4,
            child: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class ContactPickerDialog extends StatefulWidget {
  final List<Contact> contacts;
  final TextEditingController searchController;

  const ContactPickerDialog({
    Key? key,
    required this.contacts,
    required this.searchController,
  }) : super(key: key);

  @override
  State<ContactPickerDialog> createState() => _ContactPickerDialogState();
}

class _ContactPickerDialogState extends State<ContactPickerDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              translations.pickContact,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.searchController,
              decoration: InputDecoration(
                hintText: translations.search,
                prefixIcon: const Icon(Icons.search_rounded),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (context, index) {
                  final contact = widget.contacts[index];
                  if (_searchQuery.isNotEmpty &&
                      !contact.displayName
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contact.displayName[0].toUpperCase(),
                        style: TextStyle(color: colorScheme.onPrimary),
                      ),
                      backgroundColor: colorScheme.primary,
                    ),
                    title: Text(contact.displayName),
                    subtitle: contact.phones.isNotEmpty
                        ? Text(contact.phones.first.number)
                        : null,
                    onTap: () => Navigator.pop(context, contact),
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
