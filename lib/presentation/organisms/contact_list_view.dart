import 'package:flutter/material.dart';
import '../../domain/entities/contact.dart';
import '../../core/presentation/app_dimensions.dart';
import '../molecules/confirm_delete_dialog.dart';
import '../molecules/contact_list_item.dart'; // Asumiendo que este componente existe

class ContactListView extends StatefulWidget {
  final List<Contact> contacts;
  final Function(Contact) onContactTap;
  final Function(Contact) onContactDelete;

  const ContactListView({
    Key? key,
    required this.contacts,
    required this.onContactTap,
    required this.onContactDelete,
  }) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  Future<void> _confirmDeleteContact(BuildContext context, Contact contact) async {
    final result = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar contacto',
      message: '¿Estás seguro de que deseas eliminar',
      itemName: contact.name,
      icon: Icons.person_outline,
      isDestructive: true,
    );
    
    // Si el usuario confirmó, eliminar el contacto
    if (result == true) {
      widget.onContactDelete(contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        final contact = widget.contacts[index];
        
        return ContactListItem(
          contact: contact,
          onTap: () => widget.onContactTap(contact),
          onDelete: () => _confirmDeleteContact(context, contact),
          onEdit: () => widget.onContactTap(contact),
        );
      },
    );
  }
}
