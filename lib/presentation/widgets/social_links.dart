import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Social',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.work),
          title: const Text('LinkedIn'),
          subtitle: const Text('MONEYT, LLC'),
          onTap: () => _launchUrl('https://linkedin.com/company/moneyt-io'),
        ),
        ListTile(
          leading: const Icon(Icons.link),
          title: const Text('GitHub'),
          subtitle: const Text('@moneyt-io'),
          onTap: () => _launchUrl('https://github.com/moneyt-io'),
        ),
        ListTile(
          leading: const Icon(Icons.forum),
          title: const Text('Reddit'),
          subtitle: const Text('r/moneyt_io'),
          onTap: () => _launchUrl('https://reddit.com/r/moneyt_io'),
        ),
        ListTile(
          leading: const Icon(Icons.discord),
          title: const Text('Discord'),
          subtitle: const Text('Únete a nuestra comunidad'),
          onTap: () => _launchUrl('https://discord.gg/zG4yNyym'),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: const Text('admin@moneyt.com'),
          onTap: () => _launchUrl('mailto:admin@moneyt.io'),
        ),
      ],
    );
  }
}
