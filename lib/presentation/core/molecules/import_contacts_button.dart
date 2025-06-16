import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Import contacts button que match exactamente el diseño HTML
/// 
/// HTML: class="flex items-center gap-3 w-full px-4 py-3 text-left hover:bg-slate-50 border-b border-slate-100"
class ImportContactsButton extends StatelessWidget {
  const ImportContactsButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F5F9), // HTML: border-slate-100
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: const Color(0xFFF8FAFC).withOpacity(0.5), // hover:bg-slate-50 effect
          highlightColor: const Color(0xFFF1F5F9), // focus:bg-slate-100 effect
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3 (12px = py-3)
            child: Row(
              children: [
                // Icon container (exacto del HTML)
                Container(
                  width: 40, // HTML: h-10 w-10
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF1F5F9), // HTML: bg-slate-100
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.import_contacts, // HTML: import_contacts
                      color: Color(0xFF475569), // HTML: text-slate-600
                      size: 24, // HTML: material-icons default
                    ),
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Text (exacto del HTML)
                Text(
                  'Import contacts', // HTML: "Import contacts"
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 16, // HTML: text-base
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: const Color(0xFF1E293B), // HTML: text-slate-800
                    height: 1.25, // HTML: leading-normal
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
