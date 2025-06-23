import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input field especializado para montos monetarios con prefijo $ basado en wallet_form.html
/// 
/// HTML Reference:
/// ```html
/// <div class="relative">
///   <span class="absolute left-4 top-1/2 transform -translate-y-1/2 text-slate-500 text-base">$</span>
///   <input class="form-input w-full rounded-lg border-slate-300 bg-slate-50 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 h-14 pl-8 pr-4 text-base font-normal leading-normal" id="initial-balance" placeholder="0.00" type="number" step="0.01"/>
/// </div>
/// ```
class MoneyInputField extends StatelessWidget {
  const MoneyInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.placeholder = '0.00',
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.currencySymbol = '\$',
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String placeholder;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating label exacto del HTML
        Container(
          child: Stack(
            children: [
              // Input field
              Container(
                height: 56, // HTML: h-14
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                  borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                  border: Border.all(
                    color: const Color(0xFFCBD5E1), // HTML: border-slate-300
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Currency symbol prefix
                    Container(
                      width: 32, // HTML: left-4 top-1/2
                      height: 56,
                      child: Center(
                        child: Text(
                          currencySymbol,
                          style: const TextStyle(
                            fontSize: 16, // HTML: text-base
                            color: Color(0xFF64748B), // HTML: text-slate-500
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    
                    // Text input
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        enabled: enabled,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        validator: validator,
                        onChanged: onChanged,
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.normal, // HTML: font-normal
                          color: Color(0xFF0F172A), // HTML: text-slate-900
                          height: 1.5, // HTML: leading-normal
                        ),
                        decoration: InputDecoration(
                          hintText: placeholder,
                          hintStyle: const TextStyle(
                            color: Color(0xFF94A3B8), // HTML: placeholder-slate-400
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            right: 16, // HTML: pr-4
                            top: 16,
                            bottom: 16,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Floating label positioned exactly like HTML
              Positioned(
                left: 12, // HTML: left-3
                top: -8, // HTML: -top-2
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4), // HTML: px-1
                  color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12, // HTML: text-xs
                      color: Color(0xFF64748B), // HTML: text-slate-500
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Helper text like HTML
        const SizedBox(height: 4),
        Text(
          'Enter the current balance of this wallet',
          style: const TextStyle(
            fontSize: 12, // HTML: text-xs
            color: Color(0xFF64748B), // HTML: text-slate-500
          ),
        ),
      ],
    );
  }
}
