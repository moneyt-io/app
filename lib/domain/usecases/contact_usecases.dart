import 'package:injectable/injectable.dart';
import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

@injectable
class ContactUseCases {
  final ContactRepository _repository;

  ContactUseCases(this._repository);

  // Consultas
  Future<List<Contact>> getAllContacts() => 
      _repository.getAllContacts();

  Future<Contact?> getContactById(int id) => 
      _repository.getContactById(id);
      
  // Observación en tiempo real
  Stream<List<Contact>> watchAllContacts() => 
      _repository.watchAllContacts();
      
  Stream<Contact> watchContactById(int id) =>
      _repository.watchContactById(id);

  // Operaciones CRUD
  Future<Contact> createContact(Contact contact) => 
      _repository.createContact(contact);
      
  Future<void> updateContact(Contact contact) => 
      _repository.updateContact(contact);
      
  Future<void> deleteContact(int id) => 
      _repository.deleteContact(id);
      
  // Búsqueda
  Future<Contact?> findExistingContact(String? email, String? phone) =>
      _repository.findExistingContact(email, phone);
}
