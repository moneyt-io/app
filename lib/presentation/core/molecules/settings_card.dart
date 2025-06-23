import 'package:flutter/material.dart';

/// Card de configuración basada en settings.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white mt-4 mx-4 rounded-xl shadow-sm">
///   <div class="px-4 py-3 border-b border-slate-100">
///     <h2 class="text-slate-800 text-sm font-semibold uppercase tracking-wide">Account</h2>
///   </div>
/// </div>
/// ```
class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), // HTML: mt-4 mx-4
      decoration: BoxDecoration(
        color: Colors.white, // HTML: bg-white
        borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12, // HTML: text-sm
                    fontWeight: FontWeight.w600, // HTML: font-semibold
                    color: Color(0xFF1E293B), // HTML: text-slate-800
                    letterSpacing: 0.5, // HTML: tracking-wide
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Container(
            padding: const EdgeInsets.all(4), // HTML: p-1
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
