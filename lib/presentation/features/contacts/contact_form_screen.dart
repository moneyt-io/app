import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/design_system/tokens/app_dimensions.dart';
import '../../core/design_system/tokens/app_colors.dart';
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
      return 'El nombre es requerido';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value?.isNotEmpty == true) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return 'Email no válido';
      }
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value?.isNotEmpty == true) {
      final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,}$');
      if (!phoneRegex.hasMatch(value!)) {
        return 'Teléfono no válido';
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
            content: Text(provider.error ?? 'Error al guardar contacto'),
            backgroundColor: AppColors.error,
          ),
        );
        provider.clearError();
      }
    }
  }

  void _importContact() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de importar contacto próximamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Column(
        children: [
          // Header con backdrop blur effect
          Container(
            decoration: BoxDecoration(
              color: AppColors.slate50.withOpacity(0.8),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.slate200,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  children: [
                    // Close button
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: AppColors.slate700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Title
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32), // Compensar el botón close
                        child: Text(
                          _isEditing ? 'Edit contact' : 'New contact',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Form content
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: AppDimensions.spacing8),
                    
                    // Full name field
                    _buildFormField(
                      controller: _nameController,
                      label: 'Full name',
                      placeholder: 'Enter full name',
                      validator: _validateName,
                      textCapitalization: TextCapitalization.words,
                    ),
                    
                    SizedBox(height: AppDimensions.spacing24),
                    
                    // Phone field
                    _buildFormField(
                      controller: _phoneController,
                      label: 'Phone',
                      placeholder: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    
                    SizedBox(height: AppDimensions.spacing24),
                    
                    // Email field
                    _buildFormField(
                      controller: _emailController,
                      label: 'Email',
                      placeholder: 'Enter email address',
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    
                    SizedBox(height: AppDimensions.spacing24),
                    
                    // Import contact button
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: _importContact,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.slate50,
                          side: BorderSide(color: AppColors.slate300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(
                          Icons.person_add,
                          size: 18,
                          color: AppColors.slate700,
                        ),
                        label: Text(
                          'Import contact',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Footer buttons - PADDING ULTRA CORREGIDO
          Container(
            decoration: BoxDecoration(
              color: AppColors.slate50.withOpacity(0.8),
              border: Border(
                top: BorderSide(
                  color: AppColors.slate200,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CORREGIDO: Padding mínimo sin SafeArea adicional arriba
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0), // Solo 8px arriba
                  child: Row(
                    children: [
                      // Cancel button
                      Expanded(
                        child: Container(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.slate200,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.slate700,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: AppDimensions.spacing12),
                      
                      // Save button
                      Expanded(
                        child: Container(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _saveContact,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: AppColors.slate50,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.slate50,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // SafeArea solo para el bottom
                SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      height: 68, // CORREGIDO: Aumentado de 56 a 68 para acomodar floating label
      child: Stack(
        children: [
          // Text field - posicionado más abajo para espacio del label
          Positioned(
            top: 12, // CORREGIDO: Mover el TextFormField hacia abajo
            left: 0,
            right: 0,
            bottom: 0,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              validator: validator,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.slate900,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: AppColors.slate400,
                ),
                filled: true,
                fillColor: AppColors.slate50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.slate300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.slate300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.error),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
          
          // Floating label - ahora con espacio suficiente
          Positioned(
            left: 12,
            top: 4, // CORREGIDO: Ajustado para estar dentro del container
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: AppColors.slate50,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.slate500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
