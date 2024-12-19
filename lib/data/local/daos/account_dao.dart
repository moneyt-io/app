// lib/data/local/daos/account_dao.dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/account_table.dart';

part 'account_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountDao extends DatabaseAccessor<AppDatabase> with _$AccountDaoMixin {
  AccountDao(AppDatabase db) : super(db);

  Stream<List<Account>> watchAllAccounts() {
    return (select(accounts)..orderBy([(a) => OrderingTerm(expression: a.name)]))
        .watch();
  }

  Future<List<Account>> getAllAccounts() {
    return (select(accounts)..orderBy([(a) => OrderingTerm(expression: a.name)]))
        .get();
  }

  Future<void> insertAccount(AccountsCompanion account) {
    return into(accounts).insert(account);
  }

  Future<void> updateAccount(AccountsCompanion account) {
    return (update(accounts)..where((t) => t.id.equals(account.id.value)))
        .write(account);
  }

  Future<void> deleteAccount(int id) {
    return (delete(accounts)..where((t) => t.id.equals(id))).go();
  }
}