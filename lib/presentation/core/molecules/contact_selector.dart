import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../theme/app_dimensions.dart';

class ContactSelector extends StatelessWidget {
  final List<Contact> contacts;
  final Contact? selectedContact;
  final Function(Contact?) onContactSelected;
  final bool isLoading;

  const ContactSelector({
    super.key,
    required this.contacts,
    required this.selectedContact,
    required this.onContactSelected,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacing16),
          child: Row(
            children: [
              SizedBox(
                width: AppDimensions.iconMedium,
                height: AppDimensions.iconMedium,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: AppDimensions.spacing12),
              Text('Cargando contactos...'),
            ],
          ),
        ),
      );
    }

    if (contacts.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            children: [
              const Icon(
                Icons.person_add,
                size: AppDimensions.iconLarge,
                color: Colors.grey,
              ),
              const SizedBox(height: AppDimensions.spacing8),
              const Text(
                'No hay contactos disponibles',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: AppDimensions.spacing8),
              TextButton.icon(
                onPressed: () {
                  // TODO: Navegar a crear contacto
                },
                icon: const Icon(Icons.add),
                label: const Text('Crear Contacto'),
              ),
            ],
          ),
        ),
      );
    }

    return DropdownButtonFormField<Contact>(
      value: selectedContact,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contacto',
        prefixIcon: Icon(Icons.person),
      ),
      items: contacts.map((contact) {
        return DropdownMenuItem<Contact>(
          value: contact,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Text(
                  contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    if (contact.email?.isNotEmpty == true)
                      Text(
                        contact.email!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onContactSelected,
      validator: (value) {
        if (value == null) {
          return 'Debe seleccionar un contacto';
        }
        return null;
      },
    );
  }
}
