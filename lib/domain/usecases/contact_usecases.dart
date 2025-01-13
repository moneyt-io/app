// lib/domain/usecases/contact_usecases.dart
import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class GetContacts {
  final ContactRepository repository;

  GetContacts(this.repository);

  Stream<List<Contact>> call() => repository.watchAllContacts();
}

class GetContactById {
  final ContactRepository repository;

  GetContactById(this.repository);

  Future<Contact> call(int id) => repository.getContactById(id);
}

class CreateContact {
  final ContactRepository repository;

  CreateContact(this.repository);

  Future<Contact> call(Contact contact) async {
    // Buscar si existe un contacto con el mismo email o teléfono
    final existingContact = await repository.findExistingContact(
      contact.email,
      contact.phone,
    );

    if (existingContact != null) {
      // Crear una nueva versión del contacto existente con los datos actualizados
      final updatedContact = Contact(
        id: existingContact.id,
        name: contact.name,
        email: contact.email,
        phone: contact.phone,
        notes: contact.notes,
        createdAt: existingContact.createdAt,
        updatedAt: DateTime.now(),
      );
      
      // Actualizar y devolver el contacto actualizado
      final success = await repository.updateContact(updatedContact);
      if (!success) {
        throw Exception('Failed to update existing contact');
      }
      return updatedContact;
    }

    // Si no existe, crear nuevo contacto
    return repository.createContact(contact);
  }
}

class UpdateContact {
  final ContactRepository repository;

  UpdateContact(this.repository);

  Future<bool> call(Contact contact) => repository.updateContact(contact);
}

class DeleteContact {
  final ContactRepository repository;

  DeleteContact(this.repository);

  Future<bool> call(int id) => repository.deleteContact(id);
}
