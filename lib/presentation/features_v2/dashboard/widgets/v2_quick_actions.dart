import 'package:flutter/material.dart';

class V2QuickActions extends StatelessWidget {
  final VoidCallback onTransfer;
  final VoidCallback onIncome;
  final VoidCallback onExpense;
  final VoidCallback onMore;

  const V2QuickActions({
    super.key,
    required this.onTransfer,
    required this.onIncome,
    required this.onExpense,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.swap_horiz,
            label: "Transfer",
            onTap: onTransfer,
          ),
          _buildActionButton(
            icon: Icons.download,
            label: "Income",
            onTap: onIncome,
          ),
          _buildActionButton(
            icon: Icons.upload,
            label: "Expense",
            onTap: onExpense,
          ),
          _buildActionButton(
            icon: Icons.more_horiz,
            label: "More",
            onTap: onMore,
            isGhost: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isGhost = false,
  }) {
    final bgColor = isGhost ? const Color(0xFFF2F3FF) : const Color(0xFF004AC6);
    final iconColor = isGhost ? const Color(0xFF004AC6) : const Color(0xFFFFFFFF);
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20), // rounded-xl
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131B2E),
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }
}
