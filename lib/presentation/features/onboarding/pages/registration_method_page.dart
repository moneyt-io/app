import 'package:flutter/material.dart';

enum CurrentMethod {
  voice('voice'),
  auto('auto'),
  write('write'),
  easy('easy');

  const CurrentMethod(this.key);
  final String key;
}

class RegistrationMethodPage extends StatelessWidget {
  final CurrentMethod? selectedMethod;
  final ValueChanged<CurrentMethod> onMethodSelected;

  const RegistrationMethodPage({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
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
                colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.19),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.assignment_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '¿Cómo preferirías\nregistrar tus gastos?',
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Elige una',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 32),
          _buildOption(
            value: CurrentMethod.voice,
            emoji: '🗣️',
            text: 'Solo decirlo en voz alta',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: CurrentMethod.auto,
            emoji: '💳',
            text: 'Automáticamente al pagar',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: CurrentMethod.write,
            emoji: '⌨️',
            text: 'Escribirlo – ordenar\nautomáticamente',
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: CurrentMethod.easy,
            emoji: '🤷‍♂️',
            text: 'Lo que sea más fácil en el\nmomento',
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required CurrentMethod value,
    required String emoji,
    required String text,
  }) {
    final isSelected = selectedMethod == value;

    return GestureDetector(
      onTap: () => onMethodSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
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
                style: const TextStyle(fontSize: 24, height: 1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
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
