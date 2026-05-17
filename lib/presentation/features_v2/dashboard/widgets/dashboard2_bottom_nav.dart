import 'dart:ui';
import 'package:flutter/material.dart';
import '../../voice/voice_command_screen.dart';
import '../../transactions/new_transaction_screen.dart';
import '../../categories/categories_chip_selection_screen.dart';

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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesChipSelectionScreen()));
                  },
                  icon: const Icon(Icons.search, size: 28, color: Color(0x4D131B2E)),
                ),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFF004AC6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF004AC6).withValues(alpha: 0.4),
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
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceCommandScreen()));
                        },
                        child: const Icon(Icons.mic, size: 36, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const NewTransactionScreen()));
                  },
                  icon: const Icon(Icons.add, size: 28, color: Color(0x4D131B2E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
