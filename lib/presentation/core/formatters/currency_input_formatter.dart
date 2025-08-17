import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Get the new text and remove all non-digit characters except the decimal point.
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Handle the case of multiple decimal points.
    if (newText.split('.').length > 2) {
      newText = oldValue.text;
    }

    double value = double.tryParse(newText) ?? 0.0;

    // Use NumberFormat for currency formatting.
    final formatter = NumberFormat.decimalPattern('en_US');

    String formattedText;
    int decimalIndex = newText.indexOf('.');

    if (decimalIndex != -1) {
      String integerPart = newText.substring(0, decimalIndex);
      String decimalPart = newText.substring(decimalIndex);
      if (decimalPart.length > 3) {
        decimalPart = decimalPart.substring(0, 3);
      }
      double integerValue = double.tryParse(integerPart) ?? 0;
      formattedText = formatter.format(integerValue) + decimalPart;
    } else {
      formattedText = formatter.format(value);
    }

    // If the user is typing a decimal point, ensure it's preserved.
    if (newValue.text.endsWith('.') && !formattedText.endsWith('.')) {
       formattedText += '.';
    }
    
    // If the original text was empty and user enters '0', it should be '0'.
    if (newText == '0') {
      formattedText = '0';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
