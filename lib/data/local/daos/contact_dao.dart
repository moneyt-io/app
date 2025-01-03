import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import 'package:moneyt_pfm/data/local/tables/contact_table.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(AppDatabase db) : super(db);

  Future<List<ContactTableData>> getAllContacts() => select(contacts).get();

  Stream<List<ContactTableData>> watchAllContacts() => select(contacts).watch();

  Future<ContactTableData> getContactById(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).getSingle();

  Stream<ContactTableData> watchContactById(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).watchSingle();

  Future<int> insertContact(ContactsCompanion contact) =>
      into(contacts).insert(contact);

  Future<bool> updateContact(ContactsCompanion contact) =>
      update(contacts).replace(contact);

  Future<int> deleteContact(int id) =>
      (delete(contacts)..where((t) => t.id.equals(id))).go();
}
