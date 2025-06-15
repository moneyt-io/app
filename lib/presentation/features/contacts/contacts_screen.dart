import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/molecules/contacts_header.dart';
import '../../core/molecules/import_contacts_button.dart';
import '../../core/molecules/contact_group_header.dart';
import '../../core/molecules/contact_list_item.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/atoms/app_floating_action_button.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContactProvider>().loadContacts();
    });
  }

  Map<String, List<Contact>> _groupContactsByLetter(List<Contact> contacts) {
    final grouped = <String, List<Contact>>{};
    
    for (final contact in contacts) {
      final firstLetter = contact.name.isNotEmpty 
          ? contact.name[0].toUpperCase() 
          : '#';
      
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(contact);
    }
    
    // Sort groups by letter
    final sortedKeys = grouped.keys.toList()..sort();
    final sortedGrouped = <String, List<Contact>>{};
    
    for (final key in sortedKeys) {
      // Sort contacts within each group
      grouped[key]!.sort((a, b) => a.name.compareTo(b.name));
      sortedGrouped[key] = grouped[key]!;
    }
    
    return sortedGrouped;
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

  void _showContactOptions(Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(t.common.edit),
              onTap: () {
                Navigator.pop(context);
                _navigateToContactForm(contact: contact);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(t.common.delete),
              onTap: () {
                Navigator.pop(context);
                _deleteContact(contact);
              },
            ),
          ],
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          return CustomScrollView(
            slivers: [
              // Sticky Header
              SliverPersistentHeader(
                pinned: true,
                delegate: _ContactsHeaderDelegate(
                  onSearchPressed: _showSearch,
                ),
              ),
              
              // Content
              SliverToBoxAdapter(
                child: _buildContent(provider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToContactForm(),
        icon: Icons.add,
        tooltip: t.contacts.addContact,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildContent(ContactProvider provider) {
    if (provider.isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryBlue,
          ),
        ),
      );
    }

    if (provider.error != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: _buildErrorState(provider),
      );
    }

    if (provider.contacts.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: _buildEmptyState(),
      );
    }

    return _buildContactsList(provider.contacts);
  }

  Widget _buildErrorState(ContactProvider provider) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.iconSizeXLarge,
              color: Colors.red,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              t.contacts.errorLoading,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacing8),
            Text(
              provider.error ?? t.errors.unexpected,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () {
                provider.clearError();
                provider.loadContacts();
              },
              child: Text(t.common.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.people_outline,
      title: t.contacts.noContacts,
      message: t.contacts.noContactsMessage,
    );
  }

  Widget _buildContactsList(List<Contact> contacts) {
    final groupedContacts = _groupContactsByLetter(contacts);
    
    return Column(
      children: [
        // Import contacts button (first item)
        ImportContactsButton(
          onPressed: _importContacts,
        ),
        
        // Grouped contacts
        ...groupedContacts.entries.map((entry) {
          final letter = entry.key;
          final groupContacts = entry.value;
          
          return Column(
            children: [
              // Group header
              ContactGroupHeader(letter: letter),
              
              // Contacts in this group
              ...groupContacts.map((contact) {
                return ContactListItem(
                  contact: contact,
                  onTap: () => _navigateToContactForm(contact: contact),
                  onMorePressed: () => _showContactOptions(contact),
                );
              }).toList(),
            ],
          );
        }).toList(),
        
        // Bottom padding for FAB
        SizedBox(height: AppDimensions.spacing64 + 80),
      ],
    );
  }
}

// Header Delegate
class _ContactsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onSearchPressed;

  _ContactsHeaderDelegate({
    required this.onSearchPressed,
  });

  @override
  double get minExtent => 88; // CORREGIDO: Aumentado para SafeArea + padding

  @override
  double get maxExtent => 88; // CORREGIDO: Mismo valor

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ContactsHeader(
      onSearchPressed: onSearchPressed,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
