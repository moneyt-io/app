import 'package:flutter/material.dart';

class FeatureTourPage extends StatelessWidget {
  const FeatureTourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFFF8FAFC),
            Color(0x264AE3B5),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.payments,
                size: 96,
                color: Color(0xFF14B8A6),
              ),
              const SizedBox(height: 24),
              const Text(
                'Características principales',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gestiona préstamos, núcleo contable y mucho más',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF475569),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}