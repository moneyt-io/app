import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../molecules/contact_list_item.dart';

class ContactListSection extends StatelessWidget {
  final String title;
  final List<Contact> contacts;
  final Function(Contact) onContactTap;
  final Function(Contact) onContactDelete;
  final Function(Contact)? onContactCall;
  final Function(Contact)? onContactEmail;

  const ContactListSection({
    Key? key,
    required this.title,
    required this.contacts,
    required this.onContactTap,
    required this.onContactDelete,
    this.onContactCall,
    this.onContactEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ContactListItem(
              contact: contact,
              onTap: () => onContactTap(contact),
              onDelete: () => onContactDelete(contact),
            );
          },
        ),
      ],
    );
  }
}
