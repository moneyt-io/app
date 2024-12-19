// lib/presentation/screens/account_form.dart
import 'package:flutter/material.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../data/models/account_model.dart';

class AccountForm extends StatelessWidget {
  final AccountEntity? account;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;

  const AccountForm({
    Key? key,
    this.account,
    required this.createAccount,
    required this.updateAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: account?.name ?? '');
    final descriptionController = TextEditingController(text: account?.description ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(account == null ? 'Nueva Cuenta' : 'Editar Cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre de la cuenta',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingrese una descripción (opcional)',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('El nombre es obligatorio')),
                    );
                    return;
                  }

                  final newAccount = AccountModel(
                    id: account?.id ?? -1,
                    name: name,
                    description: descriptionController.text.trim(),
                    createdAt: account?.createdAt ?? DateTime.now(),
                  );

                  try {
                    if (account == null) {
                      await createAccount(newAccount);
                    } else {
                      await updateAccount(newAccount);
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: Text(account == null ? 'Crear' : 'Actualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}