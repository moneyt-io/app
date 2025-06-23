import 'package:flutter/material.dart';

/// Botón inline dashed para agregar wallet basado en wallet_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="mt-6 px-4">
///   <button onclick="window.location.href='wallet_form.html'" class="flex items-center gap-3 w-full px-4 py-4 rounded-lg border-2 border-dashed border-blue-300 text-blue-600 hover:border-blue-400 hover:bg-blue-50">
///     <span class="material-symbols-outlined">add_circle</span>
///     <div class="text-left">
///       <p class="text-base font-medium">Add new wallet</p>
///       <p class="text-sm opacity-80">Create a bank account, cash or digital wallet</p>
///     </div>
///   </button>
/// </div>
/// ```
class AddWalletInlineButton extends StatelessWidget {
  const AddWalletInlineButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0), // HTML: mt-6 px-4
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
          splashColor: const Color(0xFF3B82F6).withOpacity(0.1), // HTML: hover:bg-blue-50
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16), // HTML: px-4 py-4
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF93C5FD), // HTML: border-blue-300
                width: 2,
                style: BorderStyle.solid, // Simular border-dashed con strokeDashArray no disponible
              ),
              borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
            ),
            child: Row(
              children: [
                // Add icon
                Icon(
                  Icons.add_circle_outline, // HTML: add_circle
                  color: const Color(0xFF2563EB), // HTML: text-blue-600
                  size: 24,
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add new wallet',
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.w500, // HTML: font-medium
                          color: Color(0xFF2563EB), // HTML: text-blue-600
                        ),
                      ),
                      Text(
                        'Create a bank account, cash or digital wallet',
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: const Color(0xFF2563EB).withOpacity(0.8), // HTML: opacity-80
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
    );
  }
}
