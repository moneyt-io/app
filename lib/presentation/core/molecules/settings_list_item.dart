import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final IconData leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  
  const SettingsListItem({
    Key? key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          leading,
          color: colorScheme.onPrimaryContainer,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
