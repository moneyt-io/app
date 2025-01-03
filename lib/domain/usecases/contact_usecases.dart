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

  Future<Contact> call(Contact contact) => repository.createContact(contact);
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
