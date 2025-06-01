import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../l10n/l10n_helper.dart';
import '../design_system/tokens/app_dimensions.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: AppDimensions.buttonHeightMedium,
        height: AppDimensions.buttonHeightMedium,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        child: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: colorScheme.onPrimaryContainer,
          size: AppDimensions.iconSizeMedium,
        ),
      ),
      title: Text(t.settings.darkTheme),
      trailing: Switch(
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          themeProvider.toggleTheme();
        },
      ),
    );
  }
}
