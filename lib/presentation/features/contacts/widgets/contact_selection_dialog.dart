import 'package:flutter/material.dart';

import '../../../core/l10n/generated/strings.g.dart';
import '../../../core/molecules/form_action_bar.dart';

// TODO: This should be moved to a shared theme file
const Color _primaryBlue = Color(0xFF0C7FF2);
const Color _slate50 = Color(0xFFF8FAFC);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate500 = Color(0xFF64748B);
const Color _slate600 = Color(0xFF475569);
const Color _slate800 = Color(0xFF1E293B);
const Color _blue50 = Color(0xFFEFF6FF);
const Color _blue100 = Color(0xFFDBEAFE);
const Color _blue600 = Color(0xFF2563EB);

class SelectableContact {
  final String id;
  final String name;
  final String? details; // Phone, email, etc.
  final String? avatarUrl;

  SelectableContact({
    required this.id,
    required this.name,
    this.details,
    this.avatarUrl,
  });
}

class ContactSelectionDialog extends StatefulWidget {
  final List<SelectableContact> contacts;
  final SelectableContact? initialSelection;

  const ContactSelectionDialog({
    super.key,
    required this.contacts,
    this.initialSelection,
  });

  static Future<SelectableContact?> show(
    BuildContext context, {
    required List<SelectableContact> contacts,
    SelectableContact? initialSelection,
  }) {
    // The 'no_contact' is a special case, we handle it inside the dialog
    return showModalBottomSheet<SelectableContact?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ContactSelectionDialog(
        contacts: contacts,
        initialSelection: initialSelection,
      ),
    );
  }

  @override
  State<ContactSelectionDialog> createState() => _ContactSelectionDialogState();
}

class _ContactSelectionDialogState extends State<ContactSelectionDialog> {
  final _searchController = TextEditingController();
  late SelectableContact? _selectedContact;
  List<SelectableContact> _filteredContacts = [];

  // Special ID for the 'No contact' option
  final String _noContactId = 'no_contact';

  @override
  void initState() {
    super.initState();
    _selectedContact = widget.initialSelection;
    _filteredContacts = widget.contacts;
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterContacts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = widget.contacts.where((contact) {
        return contact.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              const Divider(height: 1, color: _slate100),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: _buildContactList(),
                ),
              ),
              FormActionBar(
                onCancel: () => Navigator.of(context).pop(),
                onSave: () => Navigator.of(context).pop(_selectedContact),
                saveText: t.components.selection.select,
                enabled: _selectedContact != null,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 24,
            alignment: Alignment.center,
            child: Container(
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                color: _slate300,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.components.contactSelection.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _slate800)),
              SizedBox(height: 4),
              Text(t.components.contactSelection.subtitle,
                  style: TextStyle(fontSize: 14, color: _slate500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: t.components.contactSelection.searchPlaceholder,
          hintStyle: const TextStyle(color: _slate500),
          prefixIcon: const Icon(Icons.search, color: _slate500, size: 20),
          filled: true,
          fillColor: _slate100,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _slate200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _slate200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _primaryBlue, width: 1.5),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContactList() {
    final List<Widget> listItems = [];

    // 'No Contact' option
    listItems.add(_ContactListItem(
      contact: SelectableContact(
        id: _noContactId,
        name: t.components.contactSelection.noContact,
        details: t.components.contactSelection.noContactDetails,
      ),
      isSelected: _selectedContact?.id == _noContactId,
      onTap: () => setState(() => _selectedContact =
          SelectableContact(id: _noContactId, name: t.components.contactSelection.noContact)),
      isSpecial: true,
    ));

    // TODO: Implement logic for 'Recent' contacts
    if (_filteredContacts.isNotEmpty) {
      listItems.add(_buildSectionHeader(t.components.contactSelection.allContacts));
      for (final contact in _filteredContacts) {
        listItems.add(_ContactListItem(
          contact: contact,
          isSelected: _selectedContact?.id == contact.id,
          onTap: () => setState(() => _selectedContact = contact),
        ));
      }
    }

    // 'Create New Contact' button
    listItems.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton.icon(
          icon: const Icon(Icons.add_circle, color: _blue600),
          label: Text(t.components.contactSelection.create,
              style: const TextStyle(color: _blue600, fontWeight: FontWeight.w600)),
          onPressed: () {
            // TODO: Navigate to contact creation screen
          },
          style: TextButton.styleFrom(
            backgroundColor: _blue50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: _blue100),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );

    return listItems;
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _slate50,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _slate600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ContactListItem extends StatelessWidget {
  final SelectableContact contact;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isSpecial;

  const _ContactListItem({
    required this.contact,
    this.isSelected = false,
    this.onTap,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _slate100)),
        ),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _slate800)),
                  if (contact.details != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(contact.details!,
                          style:
                              const TextStyle(fontSize: 14, color: _slate600)),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _buildSelectionIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (isSpecial) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _slate100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.person_off, color: _slate500, size: 20),
      );
    }

    if (contact.avatarUrl != null && contact.avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(contact.avatarUrl!),
      );
    }

    // Fallback to initials
    final initials = contact.name.isNotEmpty
        ? contact.name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    return CircleAvatar(
      radius: 20,
      backgroundColor: _slate100,
      child: Text(initials,
          style:
              const TextStyle(color: _slate600, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildSelectionIndicator() {
    if (isSelected) {
      return Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: _primaryBlue,
          shape: BoxShape.circle,
          border: Border.all(color: _primaryBlue, width: 2),
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 12),
      );
    }
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _slate300, width: 2),
      ),
    );
  }
}
