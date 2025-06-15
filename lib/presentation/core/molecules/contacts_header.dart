import 'package:flutter/material.dart';
import '../atoms/app_icon_button.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Header que match el diseño HTML exactamente
class ContactsHeader extends StatelessWidget {
  const ContactsHeader({
    Key? key,
    this.onBackPressed,
    this.onSearchPressed,
    this.title,
  }) : super(key: key);

  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      // CORREGIDO: shadow-sm del HTML = elevation muy sutil
      elevation: 0.5, // Reducido de 1 a 0.5 para match con shadow-sm
      shadowColor: Colors.black.withOpacity(0.05),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            // CORREGIDO: sombra más sutil para match shadow-sm
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02), // Reducido de 0.05 a 0.02
                blurRadius: 2, // Reducido de 4 a 2
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // Back button - 40x40px exacto como HTML
              SizedBox(
                width: 40,
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppColors.slate600,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Title - flex-1 como HTML
              Expanded(
                child: Text(
                  title ?? t.contacts.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20, // xl del HTML
                    fontWeight: FontWeight.w600, // font-semibold
                    color: AppColors.slate900,
                    letterSpacing: -0.3, // tracking-tight
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Search button - 40x40px exacto como HTML
              SizedBox(
                width: 40,
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onSearchPressed,
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        size: 24,
                        color: AppColors.slate600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
