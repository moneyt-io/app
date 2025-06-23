import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/dark_mode_switch.dart';
import '../../core/atoms/app_version_footer.dart';
import '../../core/molecules/settings_card.dart';
import '../../core/molecules/settings_item.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/l10n_helper.dart';
import '../../core/l10n/generated/strings.g.dart' show AppLocale;
import '../../navigation/app_routes.dart';
import 'social_screen.dart'; // ✅ AGREGADO: Import de SocialScreen
import 'language_screen.dart'; // ✅ AGREGADO: Import de LanguageScreen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _navigateToProfile() async {
    // TODO: Implementar navegación al perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile screen coming soon'),
        backgroundColor: Color(0xFF0c7ff2),
      ),
    );
  }

  Future<void> _navigateToLanguage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LanguageScreen(), // ✅ AGREGADO: Navegar a LanguageScreen
      ),
    );
  }

  Future<void> _navigateToBackups() async {
    Navigator.pushNamed(context, AppRoutes.backups);
  }

  Future<void> _navigateToSocial() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SocialScreen(), // ✅ AGREGADO: Importar SocialScreen
      ),
    );
  }

  Future<void> _openPrivacyPolicy() async {
    const url = 'https://moneyt.io/privacy';
    
    // ✅ SIMPLIFICADO: Usar launchUrl directamente sin canLaunchUrl
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open privacy policy'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showSignOutDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
            ),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // TODO: Implementar lógica de sign out
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign out functionality coming soon'),
            backgroundColor: Color(0xFFDC2626),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      // ✅ CORREGIDO: Usar AppAppBar con blur effect exacto del HTML
      appBar: AppAppBar(
        title: 'Settings',
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.drawer, // HTML: arrow_back_ios_new para drawer
        onLeadingPressed: _openDrawer,
      ),
      
      drawer: const AppDrawer(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Account Section
            SettingsCard(
              title: 'Account',
              children: [
                SettingsItem(
                  icon: Icons.person,
                  title: 'Profile',
                  subtitle: 'Manage your account information',
                  backgroundColor: const Color(0xFFDBEAFE), // HTML: bg-blue-100
                  iconColor: const Color(0xFF2563EB), // HTML: text-blue-600
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF9CA3AF), // HTML: text-slate-400
                  ),
                  onTap: _navigateToProfile,
                ),
              ],
            ),

            // Appearance Section
            SettingsCard(
              title: 'Appearance',
              children: [
                // Dark Mode Toggle
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Row(
                        children: [
                          // Icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3E8FF), // HTML: bg-purple-100
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.dark_mode,
                              color: Color(0xFF7C3AED), // HTML: text-purple-600
                              size: 24,
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Content
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dark mode',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                Text(
                                  'Switch to dark theme',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Switch
                          DarkModeSwitch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) => themeProvider.toggleTheme(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                // Language
                Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    return SettingsItem(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: languageProvider.getCurrentLanguageName(), // ✅ CORREGIDO: Dinámico
                      backgroundColor: const Color(0xFFFED7AA),
                      iconColor: const Color(0xFFEA580C),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9CA3AF),
                      ),
                      onTap: _navigateToLanguage,
                    );
                  },
                ),
              ],
            ),

            // Data & Storage Section
            SettingsCard(
              title: 'Data & Storage',
              children: [
                SettingsItem(
                  icon: Icons.backup,
                  title: 'Database backup',
                  subtitle: 'Manage your data backups',
                  backgroundColor: const Color(0xFFA7F3D0), // HTML: bg-cyan-100
                  iconColor: const Color(0xFF059669), // HTML: text-cyan-600
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: _navigateToBackups,
                ),
              ],
            ),

            // Information Section
            SettingsCard(
              title: 'Information',
              children: [
                SettingsItem(
                  icon: Icons.share,
                  title: 'Contact & Social',
                  subtitle: 'Get support and follow us online',
                  backgroundColor: const Color(0xFFFCE7F3), // HTML: bg-pink-100
                  iconColor: const Color(0xFFDB2777), // HTML: text-pink-600
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: _navigateToSocial,
                ),
                
                SettingsItem(
                  icon: Icons.policy,
                  title: 'Privacy policy',
                  subtitle: 'Read our privacy policy',
                  backgroundColor: const Color(0xFFF1F5F9), // HTML: bg-slate-100
                  iconColor: const Color(0xFF475569), // HTML: text-slate-600
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: _openPrivacyPolicy,
                ),
              ],
            ),

            // Logout Section (sin header)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: SettingsItem(
                  icon: Icons.logout,
                  title: 'Sign out',
                  subtitle: 'Log out of your account',
                  isDestructive: true,
                  onTap: _showSignOutDialog,
                ),
              ),
            ),

            // ✅ CORREGIDO: Usar AppVersionFooter sin build number para consistencia
            const AppVersionFooter(
              showBuildNumber: false, // Consistente con app_drawer.html
            ),
          ],
        ),
      ),
    );
  }
}
