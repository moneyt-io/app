// lib/presentation/screens/account_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';

class AccountFormArgs {
  final AccountEntity? account;
  final bool isEditing;

  AccountFormArgs({
    this.account,
    this.isEditing = false,
  });
}

class AccountScreen extends StatelessWidget {
  // Cuentas
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  // Categorías (necesarias para el drawer)
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  final TransactionUseCases transactionUseCases;

  const AccountScreen({
    Key? key,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.transactionUseCases,
  }) : super(key: key);

  void _navigateToForm(BuildContext context, {AccountEntity? account}) {
    Navigator.pushNamed(
      context,
      AppRoutes.accountForm,
      arguments: AccountFormArgs(
        account: account,
        isEditing: account != null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas'),
      ),
      drawer: AppDrawer(
        getCategories: getCategories,
        createCategory: createCategory,
        updateCategory: updateCategory,
        deleteCategory: deleteCategory,
        getAccounts: getAccounts,
        createAccount: createAccount,
        updateAccount: updateAccount,
        deleteAccount: deleteAccount,
        transactionUseCases: transactionUseCases,
      ),
      body: StreamBuilder<List<AccountEntity>>(
        stream: getAccounts(), // Cambiado de watchAll() a call()
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final accounts = snapshot.data!;
          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(account.name),
                  subtitle: Text(account.description ?? ''),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      switch (value) {
                        case 'edit':
                          _navigateToForm(context, account: account);
                          break;
                        case 'delete':
                          // Mostrar diálogo de confirmación
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar cuenta'),
                              content: const Text('¿Estás seguro de que deseas eliminar esta cuenta?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                          
                          if (confirm == true) {
                            await deleteAccount(account.id!); // Cambiado de execute() a call()
                          }
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Eliminar'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () => _navigateToForm(context, account: account),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}