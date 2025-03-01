import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/contacts_table.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [Contact])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(AppDatabase db) : super(db);

  Future<List<Contacts>> getAllContacts() => select(contact).get();
  
  Future<Contacts?> getContactById(int id) =>
      (select(contact)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<Contacts>> watchAllContacts() => select(contact).watch();
  
  Stream<Contacts> watchContactById(int id) =>
      (select(contact)..where((t) => t.id.equals(id))).watchSingle();

  Future<int> insertContact(ContactsCompanion contact) =>
      into(this.contact).insert(contact);

  Future<bool> updateContact(ContactsCompanion contact) =>
      update(this.contact).replace(contact);

  Future<int> deleteContact(int id) =>
      (delete(contact)..where((t) => t.id.equals(id))).go();
}
