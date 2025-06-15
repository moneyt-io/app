import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Import contacts button que match el diseño HTML
class ImportContactsButton extends StatelessWidget {
  const ImportContactsButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.slate100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.slate100,
              ),
              child: Center(
                child: Icon(
                  Icons.import_contacts,
                  color: AppColors.slate600,
                  size: 24,
                ),
              ),
            ),
            
            SizedBox(width: AppDimensions.spacing12),
            
            // Text
            Text(
              'Import contacts', // TODO: Add to translations
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.slate800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
