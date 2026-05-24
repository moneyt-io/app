import 'package:flutter/material.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24, // Space for top navigation
        bottom: 120, // Space for bottom button in OnboardingScreen
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'La IA de Moneyt\n',
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232C),
            ),
          ),
          const Text(
            'hace todo el trabajo pesado\npor ti.',
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B63F1),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Por eso miles de personas ya tienen el control\nde su dinero.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6A707C),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          _buildTestimonialCard(
            avatarLetter: 'M',
            avatarColor: const Color(0xFF3E83F8),
            name: 'María P.',
            time: 'Hace 2 semanas',
            text: 'Moneyt con IA me muestra en qué gasto sin darme cuenta. ¡Un antes y después!',
          ),
          const SizedBox(height: 16),
          _buildTestimonialCard(
            avatarLetter: 'J',
            avatarColor: const Color(0xFF7E3AF2),
            name: 'Juan C.',
            time: 'Hace 1 mes',
            text: 'La IA categoriza todo automáticamente. No tengo que registrar nada.',
          ),
          const SizedBox(height: 16),
          _buildTestimonialCard(
            avatarLetter: 'A',
            avatarColor: const Color(0xFF31C48D),
            name: 'Alejandra R.',
            time: 'Hace 2 semanas',
            text: 'Gracias a Moneyt y su IA dejé de gastar impulsivamente. Ahora tengo control.',
          ),
          const SizedBox(height: 16),
          _buildTestimonialCard(
            avatarLetter: 'D',
            avatarColor: const Color(0xFFF98600),
            name: 'Diego L.',
            time: 'Hace 1 mes',
            text: 'Moneyt con IA es como tener un asesor financiero en mi bolsillo.',
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String avatarLetter,
    required Color avatarColor,
    required String name,
    required String time,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            radius: 20,
            child: Text(
              avatarLetter,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232C),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6A707C),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
