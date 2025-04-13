import '../entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAllContacts();
  Future<Contact?> getContactById(int id);
  Future<Contact> createContact(Contact contact);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int id);
  Stream<List<Contact>> watchAllContacts();
  Stream<Contact> watchContactById(int id);
  Future<Contact?> findExistingContact(String? email, String? phone);
  
  // Nuevo método para buscar contactos por nombre
  Future<Contact?> findContactByName(String name);
}
