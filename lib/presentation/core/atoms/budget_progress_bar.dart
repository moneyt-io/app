import 'package:flutter/material.dart';

class BudgetProgressBar extends StatelessWidget {
  final double value;
  final Color progressColor;
  final Color backgroundColor;
  final double height;
  
  const BudgetProgressBar({
    Key? key,
    required this.value,
    required this.progressColor,
    required this.backgroundColor,
    this.height = 8.0,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value.clamp(0.0, 1.0),
      backgroundColor: backgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
      borderRadius: BorderRadius.circular(4),
      minHeight: height,
    );
  }
}
