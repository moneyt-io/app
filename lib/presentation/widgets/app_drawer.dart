// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  const AppDrawer({
    Key? key,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.account_balance_wallet, size: 40),
                ),
                SizedBox(height: 10),
                Text(
                  'Mi Aplicación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            onTap: () {
              Navigator.pushReplacementNamed(
                context, 
                AppRoutes.categories,
                arguments: {
                  'getCategories': getCategories,
                  'createCategory': createCategory,
                  'updateCategory': updateCategory,
                  'deleteCategory': deleteCategory,
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              // TODO: Implementar pantalla de configuración
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}