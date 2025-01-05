import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/account_table.dart';

part 'account_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountDao extends DatabaseAccessor<AppDatabase> with _$AccountDaoMixin {
  AccountDao(AppDatabase db) : super(db);

  Future<List<Account>> getAllAccounts() => select(accounts).get();

  Stream<List<Account>> watchAllAccounts() => select(accounts).watch();

  Future<Account> getAccountById(int id) =>
      (select(accounts)..where((a) => a.id.equals(id))).getSingle();

  Future<int> insertAccount(AccountsCompanion account) =>
      into(accounts).insert(account);

  Future<bool> updateAccount(AccountsCompanion account) =>
      update(accounts).replace(account);

  Future<int> deleteAccount(int id) =>
      (delete(accounts)..where((a) => a.id.equals(id))).go();

  Future<void> upsertAccount(AccountsCompanion account) =>
      into(accounts).insertOnConflictUpdate(account);

  Future<Account?> getAccountByName(String name) =>
      (select(accounts)..where((a) => a.name.equals(name))).getSingleOrNull();
}
