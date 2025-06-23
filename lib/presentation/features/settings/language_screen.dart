import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; // ✅ AGREGADO: Import para ImageFilter
import '../../core/atoms/app_app_bar.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/generated/strings.g.dart' show AppLocale, LocaleSettings; // ✅ CORREGIDO: Agregar LocaleSettings al import

/// Pantalla de selección de idioma basada en language.html
/// 
/// HTML Reference:
/// ```html
/// <header class="sticky top-0 z-10 bg-slate-50/80 backdrop-blur-md">
///   <h1>Language</h1>
/// </header>
/// ```
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  AppLocale? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // Obtener idioma actual
    final languageProvider = context.read<LanguageProvider>();
    _selectedLanguage = languageProvider.currentLocale;
  }

  /// Lista de idiomas disponibles en la app
  List<Map<String, dynamic>> get _availableLanguages => [
    {
      'locale': AppLocale.en,
      'name': 'English',
      'subtitle': 'English (United States)',
      'flag': '🇺🇸',
      'backgroundColor': const Color(0xFFDBEAFE), // HTML: bg-blue-100
    },
    {
      'locale': AppLocale.es,
      'name': 'Español',
      'subtitle': 'Spanish (Spain)',
      'flag': '🇪🇸',
      'backgroundColor': const Color(0xFFFECDD3), // HTML: bg-red-100
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      // ✅ AppBar con blur effect exacto del HTML
      appBar: AppAppBar(
        title: 'Language',
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.back,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      
      body: Column(
        children: [
          // Available Languages Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16), // HTML: mt-4
                  
                  _buildLanguageSection(),
                ],
              ),
            ),
          ),
          
          // Apply Button Footer
          _buildApplyButton(),
        ],
      ),
    );
  }

  /// Construye la sección de idiomas disponibles
  Widget _buildLanguageSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      decoration: BoxDecoration(
        color: Colors.white, // HTML: bg-white
        borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'AVAILABLE LANGUAGES',
                  style: const TextStyle(
                    fontSize: 12, // HTML: text-sm
                    fontWeight: FontWeight.w600, // HTML: font-semibold
                    color: Color(0xFF1E293B), // HTML: text-slate-800
                    letterSpacing: 0.5, // HTML: tracking-wide
                  ),
                ),
              ],
            ),
          ),
          
          // Language Options
          Container(
            padding: const EdgeInsets.all(4), // HTML: p-1
            child: Column(
              children: _availableLanguages.map((language) {
                final isSelected = _selectedLanguage == language['locale'];
                
                return _buildLanguageOption(
                  flag: language['flag'],
                  name: language['name'],
                  subtitle: language['subtitle'],
                  backgroundColor: language['backgroundColor'],
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language['locale'];
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Construye una opción de idioma individual
  Widget _buildLanguageOption({
    required String flag,
    required String name,
    required String subtitle,
    required Color backgroundColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16), // HTML: px-3 py-4
          child: Row(
            children: [
              // Flag Icon
              Container(
                width: 48, // HTML: h-12 w-12
                height: 48,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle, // HTML: rounded-full
                ),
                child: Center(
                  child: Text(
                    flag,
                    style: const TextStyle(
                      fontSize: 24, // HTML: text-2xl
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16), // HTML: gap-4
              
              // Language Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Color(0xFF1E293B), // HTML: text-slate-800
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection Indicator
              Container(
                width: 24, // HTML: h-6 w-6
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // HTML: rounded-full
                  border: Border.all(
                    width: 2,
                    color: isSelected 
                        ? const Color(0xFF0c7ff2) // HTML: border-[#0c7ff2]
                        : const Color(0xFFCBD5E1), // HTML: border-slate-300
                  ),
                  color: isSelected 
                      ? const Color(0xFF0c7ff2) // HTML: bg-[#0c7ff2]
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white, // HTML: text-white
                        size: 14, // HTML: text-sm
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye el botón de aplicar idioma
  Widget _buildApplyButton() {
    final languageProvider = context.watch<LanguageProvider>();
    final hasChanges = _selectedLanguage != languageProvider.currentLocale;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8), // HTML: bg-slate-50/80
        border: const Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0), // HTML: border-slate-200
          ),
        ),
      ),
      child: Container( // ✅ CORREGIDO: Eliminar BackdropFilter problemático
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
        child: SizedBox(
          width: double.infinity,
          height: 48, // HTML: h-12
          child: ElevatedButton(
            onPressed: hasChanges ? _applyLanguage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0c7ff2), // HTML: bg-[#0c7ff2]
              foregroundColor: const Color(0xFFF8FAFC), // HTML: text-slate-50
              disabledBackgroundColor: const Color(0xFFCBD5E1),
              disabledForegroundColor: const Color(0xFF64748B),
              elevation: hasChanges ? 2 : 0, // HTML: shadow-sm cuando activo
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), // HTML: rounded-full
              ),
              textStyle: const TextStyle(
                fontSize: 14, // HTML: text-sm
                fontWeight: FontWeight.w500, // HTML: font-medium
                letterSpacing: -0.1, // HTML: tracking-tight
              ),
            ),
            child: const Text('Apply Language'),
          ),
        ),
      ),
    );
  }

  /// Aplica el idioma seleccionado
  Future<void> _applyLanguage() async {
    if (_selectedLanguage == null) return;
    
    final languageProvider = context.read<LanguageProvider>();
    
    try {
      // ✅ CORREGIDO: Solo usar LanguageProvider.setLocale (maneja todo internamente)
      await languageProvider.setLocale(_selectedLanguage!);
      
      if (mounted) {
        // Mostrar confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Language updated successfully'),
            backgroundColor: Color(0xFF0c7ff2),
            duration: Duration(seconds: 2),
          ),
        );
        
        // Regresar a settings después de un breve delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating language: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}