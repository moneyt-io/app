import 'package:injectable/injectable.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../local/daos/contact_dao.dart';
import '../models/contact_model.dart';

@Injectable(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final ContactDao _dao;

  ContactRepositoryImpl(this._dao);

  @override
  Future<List<Contact>> getAllContacts() async {
    final contacts = await _dao.getAllContacts();
    return contacts.map((contact) => ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      note: contact.note,
      active: contact.active,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt,
      deletedAt: contact.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Stream<List<Contact>> watchAllContacts() {
    return _dao.watchAllContacts().map(
      (contacts) => contacts.map((contact) => ContactModel(
        id: contact.id,
        name: contact.name,
        email: contact.email,
        phone: contact.phone,
        note: contact.note,
        active: contact.active,
        createdAt: contact.createdAt,
        updatedAt: contact.updatedAt,
        deletedAt: contact.deletedAt,
      ).toEntity()).toList()
    );
  }

  @override
  Future<Contact> getContactById(int id) async {
    final contact = await _dao.getContactById(id);
    if (contact == null) {
      throw Exception('Contact not found');  // Lanzar excepción si no se encuentra
    }
    
    return ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      note: contact.note,
      active: contact.active,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt,
      deletedAt: contact.deletedAt,
    ).toEntity();
  }

  @override
  Future<Contact> createContact(Contact contact) async {
    final model = ContactModel.fromEntity(contact);
    final id = await _dao.insertContact(model.toCompanion());
    final createdContact = await _dao.getContactById(id);
    if (createdContact == null) {
      throw Exception('Failed to create contact');
    }
    return ContactModel(
      id: createdContact.id,
      name: createdContact.name,
      email: createdContact.email,
      phone: createdContact.phone,
      note: createdContact.note,
      active: createdContact.active,
      createdAt: createdContact.createdAt,
      updatedAt: createdContact.updatedAt,
      deletedAt: createdContact.deletedAt,
    ).toEntity();
  }

  @override
  Future<void> updateContact(Contact contact) async {
    final model = ContactModel.fromEntity(contact);
    await _dao.updateContact(model.toCompanion());
  }

  @override
  Future<void> deleteContact(int id) => _dao.deleteContact(id);

  @override
  Stream<Contact> watchContactById(int id) {
    return _dao.watchContactById(id).map((contact) => ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      note: contact.note,
      active: contact.active,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt,
      deletedAt: contact.deletedAt,
    ).toEntity());
  }

  @override
  Future<Contact?> findExistingContact(String? email, String? phone) async {
    if ((email == null || email.isEmpty) && (phone == null || phone.isEmpty)) {
      return null;
    }

    final contacts = await _dao.getAllContacts();
    try {
      final existingContact = contacts.firstWhere(
        (contact) =>
          (email != null && email.isNotEmpty && contact.email == email) ||
          (phone != null && phone.isNotEmpty && contact.phone == phone),
      );
      
      return ContactModel(
        id: existingContact.id,
        name: existingContact.name,
        email: existingContact.email,
        phone: existingContact.phone,
        note: existingContact.note,
        active: existingContact.active,
        createdAt: existingContact.createdAt,
        updatedAt: existingContact.updatedAt,
        deletedAt: existingContact.deletedAt,
      ).toEntity();
    } catch (e) {
      return null;
    }
  }
}
