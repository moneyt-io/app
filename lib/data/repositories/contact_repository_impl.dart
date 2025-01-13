import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/daos/contact_dao.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import 'package:moneyt_pfm/domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDao _contactDao;

  ContactRepositoryImpl(this._contactDao);

  Contact _mapToEntity(ContactTableData data) {
    return Contact(
      id: data.id,
      name: data.name,
      email: data.email,
      phone: data.phone,
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  ContactTableData _mapToData(Contact contact) {
    if (contact.id == null) {
      throw ArgumentError('Contact id cannot be null when mapping to TableData');
    }
    return ContactTableData(
      id: contact.id!,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      notes: contact.notes,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt,
    );
  }

  ContactsCompanion _mapToCompanion(Contact contact) {
    return ContactsCompanion(
      id: contact.id == null ? const Value.absent() : Value(contact.id!),
      name: Value(contact.name),
      email: Value(contact.email),
      phone: Value(contact.phone),
      notes: Value(contact.notes),
      createdAt: Value(contact.createdAt),
      updatedAt: Value(contact.updatedAt),
    );
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    final contacts = await _contactDao.getAllContacts();
    return contacts.map(_mapToEntity).toList();
  }

  @override
  Stream<List<Contact>> watchAllContacts() {
    return _contactDao.watchAllContacts().map(
          (list) => list.map(_mapToEntity).toList(),
        );
  }

  @override
  Future<Contact> getContactById(int id) async {
    final contact = await _contactDao.getContactById(id);
    return _mapToEntity(contact);
  }

  @override
  Stream<Contact> watchContactById(int id) {
    return _contactDao.watchContactById(id).map(_mapToEntity);
  }

  @override
  Future<Contact> createContact(Contact contact) async {
    final id = await _contactDao.insertContact(_mapToCompanion(contact));
    return contact.copyWith(id: id);
  }

  @override
  Future<bool> updateContact(Contact contact) {
    return _contactDao.updateContact(_mapToCompanion(contact));
  }

  @override
  Future<bool> deleteContact(int id) async {
    return await _contactDao.deleteContact(id) > 0;
  }

  @override
  Future<Contact?> findExistingContact(String? email, String? phone) async {
    if ((email == null || email.isEmpty) && (phone == null || phone.isEmpty)) {
      return null;
    }

    final contacts = await _contactDao.getAllContacts();
    try {
      final existingContact = contacts.firstWhere(
        (contact) =>
          (email != null && email.isNotEmpty && contact.email == email) ||
          (phone != null && phone.isNotEmpty && contact.phone == phone),
      );
      return _mapToEntity(existingContact);
    } catch (e) {
      return null;
    }
  }
}
