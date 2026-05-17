import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard2ActivityList extends StatelessWidget {
  const Dashboard2ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Actividad Reciente",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF131B2E),
                fontFamily: 'Manrope',
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF004AC6),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Manrope',
                ),
              ),
              child: const Text("Ver todo"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          title: "iMac",
          category: "Tecnología",
          date: "Hoy",
          amount: -500.00,
          emoji: "🖥️",
          progress: 0.87,
          progressColor: const Color(0xFF004AC6), // Primary blue
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          title: "Vans",
          category: "Ropa",
          date: "hace 4h",
          amount: -50.00,
          emoji: "👟",
          progress: 0.09,
          progressColor: const Color(0xFF6CF8BB), // Secondary green container
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          title: "Starbucks",
          category: "Comida",
          date: "hace 2h",
          amount: -25.00,
          emoji: "☕️",
          progress: 0.04,
          progressColor: const Color(0xFFFFB95F), // Tertiary orange
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          title: "Salario Mensual",
          category: "Ingresos",
          date: "Hoy",
          amount: 1200.00,
          emoji: "💰",
          progress: 0.0,
          progressColor: Colors.transparent, // No progress for income
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String category,
    required String date,
    required double amount,
    required String emoji,
    required double progress,
    required Color progressColor,
  }) {
    final formatCurrency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final isIncome = amount > 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // rounded-xl
      child: Container(
        color: progress > 0 ? progressColor.withValues(alpha: 0.05) : const Color(0xFFFFFFFF).withValues(alpha: 0.5),
            child: Stack(
              children: [
                if (progress > 0)
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(color: progressColor.withValues(alpha: 0.15)),
                    ),
                  ),
                Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF131B2E),
                            fontFamily: 'Manrope',
                          ),
                        ),
                        Text(
                          "$category • $date",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0x80434655), // on-surface-variant/50
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${isIncome ? '+' : ''}${formatCurrency.format(amount)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isIncome ? const Color(0xFF00714D) : const Color(0xFF131B2E),
                          fontFamily: 'Manrope',
                        ),
                      ),
                      if (progress > 0)
                        Text(
                          "(${(progress * 100).toInt()}%)",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF434655), // on-surface-variant
                            fontFamily: 'Manrope',
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
