import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/design_system/tokens/app_dimensions.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/atoms/app_floating_label_field.dart';
import '../../core/atoms/app_app_bar.dart'; // ✅ AGREGADO: Import del AppAppBar atomizado
import '../../core/l10n/l10n_helper.dart';
import '../../../domain/entities/contact.dart';
import 'contact_provider.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;

  const ContactFormScreen({
    Key? key,
    this.contact,
  }) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _isLoading = false;
  bool _hasChanges = false;

  bool get _isEditing => widget.contact != null;

  @override
  void initState() {
    super.initState();
    _loadContactData();
  }

  void _loadContactData() {
    if (_isEditing) {
      final contact = widget.contact!;
      _nameController.text = contact.name;
      _emailController.text = contact.email ?? '';
      _phoneController.text = contact.phone ?? '';
    }
    
    // Detectar cambios
    _nameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value?.trim().isEmpty == true) {
      return t.contacts.validation.nameRequired;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value?.isNotEmpty == true) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return t.contacts.validation.invalidEmail;
      }
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value?.isNotEmpty == true) {
      final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,}$');
      if (!phoneRegex.hasMatch(value!)) {
        return t.contacts.validation.invalidPhone;
      }
    }
    return null;
  }

  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final provider = context.read<ContactProvider>();

    final contact = Contact(
      id: _isEditing ? widget.contact!.id : 0,
      name: _nameController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      active: true,
      createdAt: _isEditing ? widget.contact!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );

    final success = _isEditing
        ? await provider.updateContact(contact)
        : await provider.createContact(contact);

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (success) {
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error ?? t.contacts.errorSaving),
            backgroundColor: Colors.red,
          ),
        );
        provider.clearError();
      }
    }
  }

  void _importContact() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.contacts.importContactSoon), // ✅ CORREGIDO: Usar traducción
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      
      // ✅ REFACTORIZADO: Usar AppAppBar atomizado en lugar de header custom
      appBar: AppAppBar(
        title: _isEditing ? t.contacts.editContact : t.contacts.newContact, // ✅ CORREGIDO: Usar traducción específica
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.close, // HTML: close button
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      
      body: Column(
        children: [
          // Form content
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ✅ REFACTORIZADO: Usar traducciones
                    AppFloatingLabelField(
                      controller: _nameController,
                      label: t.contacts.fields.fullName, // ✅ CORREGIDO: Usar traducción específica
                      placeholder: t.contacts.placeholders.enterFullName, // ✅ CORREGIDO: Usar traducción
                      validator: _validateName,
                      textCapitalization: TextCapitalization.words,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // ✅ REFACTORIZADO: Usar traducciones
                    AppFloatingLabelField(
                      controller: _phoneController,
                      label: t.contacts.fields.phone,
                      placeholder: t.contacts.placeholders.enterPhone, // ✅ CORREGIDO: Usar traducción
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // ✅ REFACTORIZADO: Usar traducciones
                    AppFloatingLabelField(
                      controller: _emailController,
                      label: t.contacts.fields.email,
                      placeholder: t.contacts.placeholders.enterEmail, // ✅ CORREGIDO: Usar traducción
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // ✅ CORREGIDO: Import contact button con traducción
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: _importContact,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF8FAFC),
                          side: const BorderSide(
                            color: Color(0xFFCBD5E1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(
                          Icons.person_add,
                          size: 18,
                          color: Color(0xFF334155),
                        ),
                        label: Text(
                          t.contacts.importContact, // ✅ CORREGIDO: Usar traducción
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Footer con FormActionBar reutilizable
          FormActionBar(
            onCancel: () => Navigator.of(context).pop(),
            onSave: _saveContact,
            isLoading: _isLoading,
            enabled: !_isLoading,
          ),
        ],
      ),
    );
  }
}