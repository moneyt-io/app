// lib/presentation/screens/transaction_screen.dart
import 'package:flutter/material.dart';
import '../../core/di/injection_container.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';

class TransactionScreen extends StatelessWidget {
  // Transacciones
  final TransactionUseCases transactionUseCases;

  // Cuentas (necesarias para el drawer y filtros)
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  // Categorías (necesarias para el drawer y filtros)
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  const TransactionScreen({
    Key? key,
    required this.transactionUseCases,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transacciones'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showFilterDialog(context),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'date_asc':
                    // Implementar ordenamiento por fecha ascendente
                    break;
                  case 'date_desc':
                    // Implementar ordenamiento por fecha descendente
                    break;
                  case 'amount_asc':
                    // Implementar ordenamiento por monto ascendente
                    break;
                  case 'amount_desc':
                    // Implementar ordenamiento por monto descendente
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'date_asc',
                  child: Text('Fecha ↑'),
                ),
                const PopupMenuItem(
                  value: 'date_desc',
                  child: Text('Fecha ↓'),
                ),
                const PopupMenuItem(
                  value: 'amount_asc',
                  child: Text('Monto ↑'),
                ),
                const PopupMenuItem(
                  value: 'amount_desc',
                  child: Text('Monto ↓'),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Todas'),
              Tab(
                icon: Icon(Icons.arrow_upward),
                text: 'Ingresos',
              ),
              Tab(
                icon: Icon(Icons.arrow_downward),
                text: 'Gastos',
              ),
              Tab(
                icon: Icon(Icons.swap_horiz),
                text: 'Transferencias',
              ),
            ],
          ),
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
        body: TabBarView(
          children: [
            _TransactionList(
              stream: transactionUseCases.watchAllTransactions(),
              onEdit: (transaction) => _editTransaction(context, transaction),
              onDelete: (transaction) => _deleteTransaction(context, transaction),
            ),
            _TransactionList(
              stream: transactionUseCases.watchTransactionsByType('I'),
              onEdit: (transaction) => _editTransaction(context, transaction),
              onDelete: (transaction) => _deleteTransaction(context, transaction),
            ),
            _TransactionList(
              stream: transactionUseCases.watchTransactionsByType('E'),
              onEdit: (transaction) => _editTransaction(context, transaction),
              onDelete: (transaction) => _deleteTransaction(context, transaction),
            ),
            _TransactionList(
              stream: transactionUseCases.watchTransactionsByType('T'),
              onEdit: (transaction) => _editTransaction(context, transaction),
              onDelete: (transaction) => _deleteTransaction(context, transaction),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createTransaction(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // Implementar diálogo de filtros
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtros'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: Implementar filtros
              // - Por cuenta
              // - Por categoría
              // - Por rango de fechas
              // - Por estado
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Aplicar filtros
              Navigator.pop(context);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  void _createTransaction(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.transactionForm);
  }

  void _editTransaction(BuildContext context, TransactionEntity transaction) {
    Navigator.pushNamed(
      context,
      AppRoutes.transactionForm,
      arguments: transaction,
    );
  }

  Future<void> _deleteTransaction(
      BuildContext context, TransactionEntity transaction) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Transacción'),
        content: const Text('¿Está seguro de eliminar esta transacción?'),
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

    if (confirm == true && transaction.id != null) {
      await transactionUseCases.deleteTransaction(transaction.id!);
    }
  }
}

class _TransactionList extends StatelessWidget {
  final Stream<List<TransactionEntity>> stream;
  final Function(TransactionEntity) onEdit;
  final Function(TransactionEntity) onDelete;

  const _TransactionList({
    required this.stream,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final transactions = snapshot.data!;

        if (transactions.isEmpty) {
          return const Center(child: Text('No hay transacciones'));
        }

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _TransactionListItem(
              transaction: transaction,
              onEdit: onEdit,
              onDelete: onDelete,
            );
          },
        );
      },
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final TransactionEntity transaction;
  final Function(TransactionEntity) onEdit;
  final Function(TransactionEntity) onDelete;

  const _TransactionListItem({
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getTransactionIcon(),
      title: Text(transaction.description ?? 'Sin descripción'),
      subtitle: Text(
        '${_getTransactionType()} • ${_formatDate(transaction.transactionDate)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatAmount(),
            style: TextStyle(
              color: _getAmountColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  onEdit(transaction);
                  break;
                case 'delete':
                  onDelete(transaction);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Editar'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
      onTap: () => onEdit(transaction),
    );
  }

  Icon _getTransactionIcon() {
    switch (transaction.type) {
      case 'I':
        return const Icon(Icons.arrow_upward, color: Colors.green);
      case 'E':
        return const Icon(Icons.arrow_downward, color: Colors.red);
      case 'T':
        return const Icon(Icons.swap_horiz, color: Colors.blue);
      default:
        return const Icon(Icons.money);
    }
  }

  String _getTransactionType() {
    switch (transaction.type) {
      case 'I':
        return 'Ingreso';
      case 'E':
        return 'Gasto';
      case 'T':
        return 'Transferencia';
      default:
        return 'Desconocido';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatAmount() {
    return '\$${transaction.amount.toStringAsFixed(2)}';
  }

  Color _getAmountColor(BuildContext context) {
    if (transaction.flow == 'I') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}