// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../../domain/repositories/category_repository.dart';
import '../../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  final CategoryRepository categoryRepository;

  const AppDrawer({
    Key? key,
    required this.categoryRepository,
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
              Navigator.pushReplacementNamed(context, AppRoutes.categories);
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