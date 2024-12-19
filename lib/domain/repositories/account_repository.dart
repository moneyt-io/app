// lib/domain/repositories/account_repository.dart
import '../entities/account.dart';

abstract class AccountRepository {
  Stream<List<AccountEntity>> watchAccounts();
  Future<List<AccountEntity>> getAccounts();
  Future<void> createAccount(AccountEntity account);
  Future<void> updateAccount(AccountEntity account);
  Future<void> deleteAccount(int id);
}