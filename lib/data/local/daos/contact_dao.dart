import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/contact_table.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(AppDatabase db) : super(db);

  // Consultas básicas
  Future<List<Contact>> getAllContacts() => 
      (select(contacts)..where((c) => c.active.equals(true))).get();

  Stream<List<Contact>> watchAllContacts() => 
      (select(contacts)..where((c) => c.active.equals(true))).watch();

  Future<Contact?> getContactById(int id) =>
      (select(contacts)..where((c) => c.id.equals(id))).getSingleOrNull();

  // Operaciones CRUD
  Future<int> insertContact(Contact contact) =>
      into(contacts).insert(contact);

  Future<bool> updateContact(Contact contact) =>
      update(contacts).replace(contact);

  // Soft delete usando customUpdate
  Future<int> softDeleteContact(int id) =>
      customUpdate(
        'UPDATE contacts SET active = FALSE, deleted_at = ? WHERE id = ?',
        variables: [Variable.withDateTime(DateTime.now()), Variable.withInt(id)],
        updates: {contacts},
      );

  // Búsqueda de contactos existentes
  Future<Contact?> findExistingContact(String? email, String? phone) {
    if (email == null && phone == null) return Future.value(null);
    
    return (select(contacts)
      ..where((c) => 
          c.active.equals(true) &
          (c.email.equals(email ?? '') | c.phone.equals(phone ?? '')))
    ).getSingleOrNull();
  }

  // Búsqueda por texto
  Future<List<Contact>> searchContacts(String query) => 
      (select(contacts)
        ..where((c) => 
            c.active.equals(true) &
            (c.name.like('%$query%') |
             c.email.like('%$query%') |
             c.phone.like('%$query%')))
        ..orderBy([(t) => OrderingTerm(expression: t.name)]))
      .get();
}
