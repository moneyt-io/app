import 'package:moneyt_pfm/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAllContacts();
  Stream<List<Contact>> watchAllContacts();
  Future<Contact> getContactById(int id);
  Stream<Contact> watchContactById(int id);
  Future<int> createContact(Contact contact);
  Future<bool> updateContact(Contact contact);
  Future<bool> deleteContact(int id);
}
