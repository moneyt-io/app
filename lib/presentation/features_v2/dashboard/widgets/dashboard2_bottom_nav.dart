import 'dart:ui';
import 'package:flutter/material.dart';
import '../../voice/voice_command_screen.dart';
import '../../transactions/new_transaction_screen.dart';
import '../../transactions/new_transactions_screen.dart';

class Dashboard2BottomNav extends StatelessWidget {
  const Dashboard2BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 24, left: 32, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NewTransactionsScreen(autoOpenSearch: true)),
                    );
                  },
                  icon: const Icon(Icons.search, size: 28, color: Color(0x4D131B2E)),
                ),
                const SizedBox(width: 72), // Espacio para el botón central
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const NewTransactionScreen()));
                  },
                  icon: const Icon(Icons.add, size: 28, color: Color(0x4D131B2E)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 52, // Exactamente 52px desde abajo, igual que en VoiceCommandScreen
            child: Hero(
              tag: 'mic_hero_button',
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 4), // Mismo borde que en la vista de grabación para transición fluida
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const VoiceCommandScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 350),
                        ),
                      );
                    },
                    child: const Icon(Icons.mic, size: 36, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
