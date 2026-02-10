import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_version_footer.dart';
import '../../core/molecules/settings_card.dart';
import '../../core/molecules/settings_item.dart';

import 'package:moneyt_pfm/presentation/core/l10n/generated/strings.g.dart';

/// Pantalla de redes sociales y contacto basada en social.html
/// 
/// HTML Reference:
/// ```html
/// <header class="sticky top-0 z-10 bg-slate-50/80 backdrop-blur-md">
///   <h1>Contact & Social</h1>
/// </header>
/// ```
class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      appBar: AppAppBar(
        title: t.settings.social.title,
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.back,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32), // HTML: px-4 mt-6 mb-8
              child: Column(
                children: [
                  // Icon gradient
                  Container(
                    width: 80, // HTML: h-20 w-20
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF3B82F6), // HTML: from-blue-500
                          Color(0xFF9333EA), // HTML: to-purple-600
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 36, // HTML: text-4xl
                    ),
                  ),
                  
                  const SizedBox(height: 16), // HTML: mb-4
                  
                  Text(
                    t.settings.social.follow,
                    style: const TextStyle(
                      fontSize: 20, // HTML: text-xl
                      fontWeight: FontWeight.bold, // HTML: font-bold
                      color: Color(0xFF1E293B), // HTML: text-slate-800
                    ),
                  ),
                  
                  const SizedBox(height: 8), // HTML: mb-2
                  
                  Text(
                    t.settings.social.description,
                    style: const TextStyle(
                      fontSize: 14, // HTML: text-sm
                      color: Color(0xFF64748B), // HTML: text-slate-500
                      height: 1.5, // HTML: leading-relaxed
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Social Networks Section
            SettingsCard(
              title: t.settings.social.networks,
              children: [
                // GitHub
                SettingsItem(
                  icon: Icons.code, // ✅ CORREGIDO: Ícono más representativo para GitHub
                  title: t.settings.social.github,
                  subtitle: t.settings.social.githubSubtitle,
                  backgroundColor: const Color(0xFF1F2937), // HTML: bg-gray-900
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://github.com/moneyt-io'),
                ),
                
                // LinkedIn
                SettingsItem(
                  icon: Icons.business_center, // ✅ CORREGIDO: Ícono más representativo para LinkedIn
                  title: t.settings.social.linkedin,
                  subtitle: t.settings.social.linkedinSubtitle,
                  backgroundColor: const Color(0xFF1D4ED8), // HTML: bg-blue-700
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://www.linkedin.com/company/moneyt-io'),
                ),
                
                // X (Twitter)
                SettingsItem(
                  icon: Icons.message, // ✅ CORREGIDO: Ícono más representativo para X/Twitter
                  title: t.settings.social.twitter,
                  subtitle: t.settings.social.twitterSubtitle,
                  backgroundColor: Colors.black, // HTML: bg-black
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://twitter.com/moneyt_app'),
                ),
                
                // Reddit
                SettingsItem(
                  icon: Icons.reddit, // ✅ CORREGIDO: Ícono específico de Reddit
                  title: t.settings.social.reddit,
                  subtitle: t.settings.social.redditSubtitle,
                  backgroundColor: const Color(0xFFEA580C), // HTML: bg-orange-600
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://www.reddit.com/r/moneyt_io'),
                ),
                
                // Discord
                SettingsItem(
                  icon: Icons.chat_bubble, // ✅ CORREGIDO: Ícono más representativo para Discord
                  title: t.settings.social.discord,
                  subtitle: t.settings.social.discordSubtitle,
                  backgroundColor: const Color(0xFF4F46E5), // HTML: bg-indigo-600
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://discord.gg/moneyt'),
                ),
              ],
            ),
            
            // Contact Section
            SettingsCard(
              title: t.settings.social.contact,
              children: [
                // Email Support
                SettingsItem(
                  icon: Icons.mail,
                  title: t.settings.social.email,
                  subtitle: 'support@moneyt.io',
                  backgroundColor: const Color(0xFF3B82F6), // HTML: bg-blue-500
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openEmail('support@moneyt.io'),
                ),
                
                // Official Website
                SettingsItem(
                  icon: Icons.language,
                  title: t.settings.social.website,
                  subtitle: 'moneyt.io',
                  backgroundColor: const Color(0xFF10B981), // HTML: bg-green-500
                  iconColor: Colors.white,
                  trailing: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF9CA3AF),
                  ),
                  onTap: () => _openUrl('https://moneyt.io'),
                ),
              ],
            ),
            
            // Share App Button
            Container(
              margin: const EdgeInsets.fromLTRB(16, 24, 16, 0), // HTML: mt-6 px-4
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _shareApp,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16), // HTML: px-4 py-4
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF3B82F6), // HTML: from-blue-500
                          Color(0xFF9333EA), // HTML: to-purple-600
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // HTML: shadow-lg
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12), // HTML: gap-3
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.settings.info.share,
                                style: const TextStyle(
                                  fontSize: 16, // HTML: text-base
                                  fontWeight: FontWeight.w600, // HTML: font-semibold
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                t.settings.info.shareSubtitle,
                                style: const TextStyle(
                                  fontSize: 14, // HTML: text-sm
                                  color: Color(0xFFE5E7EB), // HTML: opacity-90 white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // ✅ ELIMINADO: App Info Card fijo y footer fijo
            // Solo queda el footer atomizado dinámico
            const AppVersionFooter(
              showBuildNumber: false,
            ),
          ],
        ),
      ),
    );
  }

  /// Abre una URL externa
  Future<void> _openUrl(String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error opening URL: $e');
    }
  }

  /// Abre el cliente de email
  Future<void> _openEmail(String email) async {
    try {
      await launchUrl(
        Uri.parse('mailto:$email'),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error opening email: $e');
    }
  }

  /// Comparte la app usando el API nativo de compartir
  Future<void> _shareApp() async {
    try {
      await Share.share(
        'Check out MoneyT, the best app for managing your personal finances! https://moneyt.io',
        subject: 'MoneyT - Personal Finance Manager',
      );
    } catch (e) {
      debugPrint('Error sharing app: $e');
    }
  }
}