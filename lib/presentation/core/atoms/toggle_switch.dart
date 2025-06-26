import 'package:flutter/material.dart';

/// Toggle switch personalizado que replica el diseño HTML exactamente
/// 
/// HTML Reference:
/// ```html
/// <div class="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
/// ```
class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFF2563EB), // HTML: bg-blue-600
    this.inactiveColor = const Color(0xFFE2E8F0), // HTML: bg-slate-200
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44, // HTML: w-11 (44px)
        height: 24, // HTML: h-6 (24px)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // HTML: rounded-full
          color: value ? activeColor : inactiveColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20, // HTML: h-5 w-5 (20px)
            height: 20,
            margin: const EdgeInsets.all(2), // HTML: top-[2px] left-[2px]
            decoration: const BoxDecoration(
              color: Colors.white, // HTML: bg-white
              shape: BoxShape.circle, // HTML: rounded-full
            ),
          ),
        ),
      ),
    );
  }
}
