import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/daos/contact_dao.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import 'package:moneyt_pfm/domain/entities/contact.dart';
import 'package:moneyt_pfm/domain/repositories/contact_repository.dart';

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
  Future<int> createContact(Contact contact) {
    return _contactDao.insertContact(_mapToCompanion(contact));
  }

  @override
  Future<bool> updateContact(Contact contact) {
    return _contactDao.updateContact(_mapToCompanion(contact));
  }

  @override
  Future<bool> deleteContact(int id) async {
    return await _contactDao.deleteContact(id) > 0;
  }
}
