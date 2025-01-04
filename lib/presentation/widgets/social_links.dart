import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            translations.about,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.web,
            color: colorScheme.primary,
          ),
          title: Text(translations.webSite),
          subtitle: const Text('moneyt.io'),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('https://moneyt.io'),
        ),
        ListTile(
          leading: Icon(
            Icons.work,
            color: colorScheme.primary,
          ),
          title: Text(translations.linkedIn),
          subtitle: const Text('MONEYT, LLC'),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('https://linkedin.com/company/moneyt-io'),
        ),
        ListTile(
          leading: Icon(
            Icons.link,
            color: colorScheme.primary,
          ),
          title: Text(translations.gitHub),
          subtitle: const Text('@moneyt-io'),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('https://github.com/moneyt-io'),
        ),
        ListTile(
          leading: Icon(
            Icons.forum,
            color: colorScheme.primary,
          ),
          title: Text(translations.reddit),
          subtitle: const Text('r/moneyt_io'),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('https://reddit.com/r/moneyt_io'),
        ),
        ListTile(
          leading: Icon(
            Icons.discord,
            color: colorScheme.primary,
          ),
          title: Text(translations.discord),
          subtitle: Text(translations.joinOurCommunity),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('https://discord.gg/zG4yNyym'),
        ),
        ListTile(
          leading: Icon(
            Icons.email,
            color: colorScheme.primary,
          ),
          title: Text(translations.email),
          subtitle: const Text('admin@moneyt.io'),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () => _launchUrl('mailto:admin@moneyt.io'),
        ),
      ],
    );
  }
}
