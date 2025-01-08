// lib/presentation/screens/contact_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;
import '../../domain/entities/contact.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../core/l10n/language_manager.dart';

class ContactFormArgs {
  final Contact? contact;
  final bool isEditing;
  final device_contacts.Contact? deviceContact;

  ContactFormArgs({
    this.contact,
    this.isEditing = false,
    this.deviceContact,
  });
}

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final CreateContact createContact;
  final UpdateContact updateContact;
  final device_contacts.Contact? deviceContact;

  const ContactForm({
    Key? key,
    this.contact,
    required this.createContact,
    required this.updateContact,
    this.deviceContact,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final notesController = TextEditingController();

  // Expresión regular para validar email
  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  bool get isEditing => widget.contact != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      nameController.text = widget.contact!.name;
      emailController.text = widget.contact!.email ?? '';
      phoneController.text = widget.contact!.phone ?? '';
      notesController.text = widget.contact!.notes ?? '';
    } else if (widget.deviceContact != null) {
      // Prellenar con datos del contacto del dispositivo
      final deviceContact = widget.deviceContact!;
      nameController.text = deviceContact.displayName;
      if (deviceContact.emails.isNotEmpty) {
        emailController.text = deviceContact.emails.first.address;
      }
      if (deviceContact.phones.isNotEmpty) {
        phoneController.text = deviceContact.phones.first.normalizedNumber.isNotEmpty 
            ? deviceContact.phones.first.normalizedNumber 
            : deviceContact.phones.first.number;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    final contact = Contact(
      id: isEditing ? widget.contact!.id : null,
      name: nameController.text.trim(),
      email: emailController.text.trim().isEmpty ? null : emailController.text.trim(),
      phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
      notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
      createdAt: isEditing ? widget.contact!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      if (isEditing) {
        await widget.updateContact(contact);
      } else {
        await widget.createContact(contact);
      }

      if (mounted) {
        final translations = context.read<LanguageManager>().translations;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? translations.contactUpdated
                  : translations.contactCreated,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: colorScheme.surfaceVariant.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.outline.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 0.5,
        ),
      ),
      contentPadding: const EdgeInsets.all(16),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? translations.editContact : translations.addContact,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translations.contactInformation,
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: nameController,
                        decoration: inputDecoration.copyWith(
                          labelText: translations.contactName,
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return translations.requiredField;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: inputDecoration.copyWith(
                          labelText: translations.contactEmail,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return null; // Email es opcional
                          }
                          if (!_emailRegex.hasMatch(value.trim())) {
                            return translations.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        decoration: inputDecoration.copyWith(
                          labelText: translations.contactPhone,
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: notesController,
                        decoration: inputDecoration.copyWith(
                          labelText: translations.contactNotes,
                          alignLabelWithHint: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 64),
                            child: Icon(
                              Icons.note_outlined,
                              color: colorScheme.onSurfaceVariant,
                              size: 24,
                            ),
                          ),
                        ),
                        style: textTheme.bodyLarge,
                        maxLines: 4,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, MediaQuery.of(context).padding.bottom + 16),
        child: FilledButton(
          onPressed: _saveContact,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: Text(
            translations.save,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
