// lib/presentation/screens/account_screen.dart
import 'package:flutter/material.dart';
import 'package:moenyt_drift/domain/usecases/transaction_usecases.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';  // Añadir esta importación
import '../../routes/app_routes.dart';
import '../widgets/list_item.dart';
import '../widgets/app_drawer.dart';
import '../../core/di/injection_container.dart';  // Para usar getIt

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
    // Cuentas
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    // Categorías
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,

    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'filter':
                  // TODO: Implementar filtrado
                  break;
                case 'sort':
                  // TODO: Implementar ordenamiento
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'filter',
                child: Row(
                  children: [
                    Icon(Icons.filter_list),
                    SizedBox(width: 8),
                    Text('Filtrar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'sort',
                child: Row(
                  children: [
                    Icon(Icons.sort),
                    SizedBox(width: 8),
                    Text('Ordenar'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(
        // Cuentas
        getAccounts: getAccounts,
        createAccount: createAccount,
        updateAccount: updateAccount,
        deleteAccount: deleteAccount,
        // Categorías
        getCategories: getCategories,
        createCategory: createCategory,
        updateCategory: updateCategory,
        deleteCategory: deleteCategory,

        transactionUseCases: transactionUseCases,
      ),
      body: StreamBuilder<List<AccountEntity>>(
        stream: getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final accounts = snapshot.data!;

          if (accounts.isEmpty) {
            return const Center(
              child: Text('No hay cuentas registradas'),
            );
          }

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return ListItem<AccountEntity>(
                item: account,
                leading: const Icon(Icons.account_balance),
                onDelete: (account) => deleteAccount(account.id),
                onUpdate: (account) => Navigator.pushNamed(
                  context,
                  AppRoutes.accountForm,
                  arguments: AccountFormArgs(
                    account: account,
                    createAccount: createAccount,
                    updateAccount: updateAccount,
                  ),
                ),
                extraActions: (account) => [
                  const PopupMenuItem(
                    value: 'details',
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 8),
                        Text('Detalles'),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AppRoutes.accountForm,
          arguments: AccountFormArgs(
            createAccount: createAccount,
            updateAccount: updateAccount,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}