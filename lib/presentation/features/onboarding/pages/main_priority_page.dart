import 'package:flutter/material.dart';

enum PersonalGoal {
  breakHabits('break_habits'),
  stopStress('stop_stress'),
  buildFuture('build_future'),
  feelControl('feel_control'),
  saveGoal('save_goal');

  const PersonalGoal(this.key);
  final String key;
}

class MainPriorityPage extends StatelessWidget {
  final PersonalGoal? selectedGoal;
  final ValueChanged<PersonalGoal> onGoalSelected;

  const MainPriorityPage({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24, // Space for top navigation
        bottom: 120, // Space for bottom button
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '¿Cuál es tu prioridad\nprincipal?',
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Elige la opción que más quieres que te ayude MoneyT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 32),
          _buildOption(
            value: PersonalGoal.breakHabits,
            emoji: '💊',
            text: 'Romper malos hábitos',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: PersonalGoal.stopStress,
            emoji: '😥',
            text: 'Dejar de estresarme por el dinero',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: PersonalGoal.buildFuture,
            emoji: '🏡',
            text: 'Construir un futuro abundante',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: PersonalGoal.feelControl,
            emoji: '👑',
            text: 'Sentir que controlo mis finanzas',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: PersonalGoal.saveGoal,
            emoji: '🌟',
            text: 'Ahorrar para una meta',
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required PersonalGoal value,
    required String emoji,
    required String text,
  }) {
    final isSelected = selectedGoal == value;

    return GestureDetector(
      onTap: () => onGoalSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
