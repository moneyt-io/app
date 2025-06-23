import 'package:flutter/material.dart';

/// Switch específico para dark mode basado en settings.html
/// 
/// HTML Reference:
/// ```html
/// <label class="relative inline-flex items-center cursor-pointer">
///   <input type="checkbox" class="sr-only peer">
///   <div class="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
/// </label>
/// ```
class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44, // HTML: w-11
      height: 24, // HTML: h-6
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white, // HTML: after:bg-white
        activeTrackColor: const Color(0xFF2563EB), // HTML: peer-checked:bg-blue-600
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFE2E8F0), // HTML: bg-slate-200
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 0,
      ),
    );
  }
}
