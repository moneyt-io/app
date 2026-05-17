import 'package:flutter/material.dart';
import '../../core/organisms/app_drawer.dart';
import 'widgets/dashboard2_gauge.dart';
import 'widgets/dashboard2_income_expense.dart';
import 'widgets/dashboard2_activity_list.dart';
import 'widgets/dashboard2_bottom_nav.dart';

class NewHomeScreen extends StatelessWidget {
  final bool hasJustSeenPaywall;
  final VoidCallback onToggleLegacy;

  const NewHomeScreen({
    super.key, 
    this.hasJustSeenPaywall = false,
    required this.onToggleLegacy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF), // surface-container-lowest
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 140), // padding for bottom nav and extra spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderWithBackground(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -16),
                        child: const Dashboard2IncomeExpense(
                          income: 1200.00,
                          expenses: 575.00,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Dashboard2ActivityList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Dashboard2BottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeaderWithBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBwYJtbLoiRlK81HfQ0l7k4ySGsyJeulQ5JpR_i0oIcnwM_9Pw_1IBnZ81Yk48phFd11NOlBX-OHgmovM__zWyLxpcfQ721O5NjjvLM_7LkERh01LoHkOddGXkwHpoI-AHMuT8bcbMn849_lNZ7Su4h9TYOpv_qUTD6XXWe7Yps8HV7sQVkcNQKhhaIzTrwgESMzN-MvMbARMYlmjgpHQSr0vFRfsEkwAJWwGYqohbqQuSGjFSOnqyq7eDOq6wiFI3-d2d74TspvgIC',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.0),
                    const Color(0xFFFAF8FF),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "¡Buenos días, Rafiqur!",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Manrope',
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: onToggleLegacy,
                            icon: const Icon(Icons.swap_horiz, size: 16, color: Colors.white),
                            label: const Text(
                              "Legacy View", 
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.settings, color: Colors.white),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Total Balance Text
                const Text(
                  "BALANCE TOTAL",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontFamily: 'Manrope',
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "\$625.00",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontFamily: 'Manrope',
                    height: 1.1,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFilterChip("Este mes"),
                    const SizedBox(width: 8),
                    _buildFilterChip("Lista privada"),
                  ],
                ),
                const SizedBox(height: 32),
                // Gauge Chart
                const Dashboard2Gauge(percentage: 0.52),
                const SizedBox(height: 56), // Added more space to prevent overlap with income/expense cards
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.unfold_more, size: 14, color: Colors.white),
        ],
      ),
    );
  }
}
