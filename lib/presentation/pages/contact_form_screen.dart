import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;
import '../../domain/entities/contact.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;
  final device_contacts.Contact? deviceContact;

  const ContactFormScreen({
    Key? key,
    this.contact,
    this.deviceContact,
  }) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();

  bool get isEditing => widget.contact != null;

  // Expresión regular para validar emails
  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  @override
  void initState() {
    super.initState();
    
    if (isEditing) {
      // Modo de edición: prellenar con datos del contacto existente
      _nameController.text = widget.contact!.name;
      _emailController.text = widget.contact!.email ?? '';
      _phoneController.text = widget.contact!.phone ?? '';
      _noteController.text = widget.contact!.note ?? '';
    } else if (widget.deviceContact != null) {
      // Prellenar con datos del contacto del dispositivo
      final deviceContact = widget.deviceContact!;
      _nameController.text = deviceContact.displayName;
      
      if (deviceContact.emails.isNotEmpty) {
        _emailController.text = deviceContact.emails.first.address;
      }
      
      if (deviceContact.phones.isNotEmpty) {
        _phoneController.text = deviceContact.phones.first.normalizedNumber.isNotEmpty 
            ? deviceContact.phones.first.normalizedNumber 
            : deviceContact.phones.first.number;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Crear o actualizar el contacto (simulado)
      final contact = Contact(
        id: isEditing ? widget.contact!.id : DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        active: true,
        createdAt: isEditing ? widget.contact!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
        deletedAt: null,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'Contacto actualizado con éxito' : 'Contacto creado con éxito'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      
      // Devolver el contacto creado/actualizado a la pantalla anterior
      //NavigationService.goBack(result: contact);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar contacto' : 'Nuevo contacto'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tarjeta de información del contacto
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información del contacto',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nombre (requerido)
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'El nombre es requerido';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Email (opcional)
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            if (!_emailRegex.hasMatch(value.trim())) {
                              return 'Ingrese un email válido';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Teléfono (opcional)
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Notas (opcional)
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: 'Notas',
                          alignLabelWithHint: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 64),
                            child: Icon(
                              Icons.note_outlined,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 4,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16, 
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _saveContact,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }
}
