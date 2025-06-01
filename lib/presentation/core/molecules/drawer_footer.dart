import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerFooter extends StatelessWidget {
  final String title;
  final IconData icon;

  const DrawerFooter({
    Key? key,
    required this.title,
    this.icon = Icons.info_outline,
  }) : super(key: key);

  Future<String> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return 'v${packageInfo.version}';
    } catch (e) {
      return 'v?.?.?';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<String>(
                future: _getAppVersion(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? 'Loading...',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
