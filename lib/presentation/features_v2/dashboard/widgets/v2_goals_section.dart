import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';

class V2GoalsSection extends StatelessWidget {
  final String currencySymbol;

  const V2GoalsSection({
    super.key,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Financial Goals",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF131B2E),
            fontFamily: 'Manrope',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildGoalCard(
                title: "Emergency Fund",
                currentAmount: 2500,
                targetAmount: 5000,
                color: const Color(0xFF006C49), // Emerald
                icon: Icons.shield,
              ),
              const SizedBox(width: 16),
              _buildGoalCard(
                title: "New MacBook",
                currentAmount: 800,
                targetAmount: 2000,
                color: const Color(0xFF004AC6), // Brand Blue
                icon: Icons.laptop_mac,
              ),
              const SizedBox(width: 16),
              _buildGoalCard(
                title: "Vacation",
                currentAmount: 300,
                targetAmount: 1500,
                color: const Color(0xFF996100), // Tertiary
                icon: Icons.flight_takeoff,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard({
    required String title,
    required double currentAmount,
    required double targetAmount,
    required Color color,
    required IconData icon,
  }) {
    final double progress = currentAmount / targetAmount;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131B2E),
                    fontFamily: 'Manrope',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormatter.formatCurrency(currentAmount),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF131B2E),
                      fontFamily: 'Manrope',
                    ),
                  ),
                  Text(
                    NumberFormatter.formatCurrency(targetAmount),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
