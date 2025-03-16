import 'package:flutter/material.dart';
import '../molecules/section_title.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Simulamos un usuario autenticado
    final isAuthenticated = false;
    final userEmail = 'usuario@example.com';
    final userName = 'Usuario';
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Cuenta', icon: Icons.person_outline),
            const SizedBox(height: 16),
            
            if (isAuthenticated) ...[
              // Usuario autenticado
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    userInitial,
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                ),
                title: Text(userName),
                subtitle: Text(userEmail),
              ),
            ] else ...[
              // Usuario no autenticado
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: colorScheme.surfaceVariant,
                  child: Icon(
                    Icons.person_outline,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                title: const Text('No has iniciado sesión'),
                subtitle: const Text('Inicia sesión para sincronizar tus datos'),
                trailing: TextButton(
                  onPressed: () {
                    // Aquí va la lógica para iniciar sesión
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
