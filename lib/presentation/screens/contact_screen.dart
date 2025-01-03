// lib/presentation/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../../core/l10n/language_manager.dart';

class ContactFormArgs {
  final Contact? contact;
  final bool isEditing;

  ContactFormArgs({
    this.contact,
    this.isEditing = false,
  });
}

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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedGroup = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToForm(BuildContext context, {Contact? contact}) async {
    final args = ContactFormArgs(
      contact: contact,
      isEditing: contact != null,
    );
    await Navigator.pushNamed(
      context,
      AppRoutes.contactForm,
      arguments: args,
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, Contact contact) async {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translations.deleteContactTitle),
        content: Text(translations.deleteContactMessage(contact.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            child: Text(translations.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await widget.deleteContact(contact.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translations.contactDeleted),
              backgroundColor: colorScheme.primary,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${translations.error}: $e'),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      }
    }
  }

  String _getInitialLetter(String name) {
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  List<Contact> _filterContacts(List<Contact> contacts) {
    if (_searchQuery.isEmpty && _selectedGroup == 'all') return contacts;

    return contacts.where((contact) {
      final matchesSearch = _searchQuery.isEmpty ||
          contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (contact.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (contact.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

      if (_selectedGroup == 'all') return matchesSearch;

      final initialLetter = _getInitialLetter(contact.name);
      return matchesSearch && initialLetter == _selectedGroup;
    }).toList();
  }

  List<String> _getAvailableGroups(List<Contact> contacts) {
    final groups = contacts
        .map((contact) => _getInitialLetter(contact.name))
        .toSet()
        .toList()
      ..sort();
    return ['all', ...groups];
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.contacts),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(context),
        icon: const Icon(Icons.person_add_rounded),
        label: Text(translations.newContact),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Barra de búsqueda
                SearchBar(
                  controller: _searchController,
                  hintText: 'Buscar contactos...',
                  leading: const Icon(Icons.search_rounded),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Contact>>(
              stream: widget.getContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${translations.error}: ${snapshot.error}',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  );
                }

                final allContacts = snapshot.data!;
                final groups = _getAvailableGroups(allContacts);
                final filteredContacts = _filterContacts(allContacts);

                if (allContacts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            size: 64,
                            color: colorScheme.primary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            translations.noContactsMessage,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    if (allContacts.length > 10) ...[
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            final group = groups[index];
                            final isSelected = _selectedGroup == group;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(group == 'all' ? 'Todos' : group),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedGroup = group;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 8),
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
                                    CircleAvatar(
                                      backgroundColor: colorScheme.primaryContainer,
                                      child: Text(
                                        _getInitialLetter(contact.name),
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            contact.name,
                                            style: textTheme.titleMedium?.copyWith(
                                              color: colorScheme.onSurface,
                                            ),
                                          ),
                                          if (contact.email?.isNotEmpty ?? false)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                contact.email!,
                                                style: textTheme.bodyMedium?.copyWith(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                            ),
                                          if (contact.phone?.isNotEmpty ?? false)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                contact.phone!,
                                                style: textTheme.bodyMedium?.copyWith(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: colorScheme.error,
                                      ),
                                      onPressed: () => _showDeleteDialog(context, contact),
                                      tooltip: translations.deleteContact,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
