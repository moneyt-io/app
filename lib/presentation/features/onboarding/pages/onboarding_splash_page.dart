import 'package:flutter/material.dart';
import '../../../core/l10n/generated/strings.g.dart';

class OnboardingSplashPage extends StatelessWidget {
  const OnboardingSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 64, // Space for top navigation
        bottom: 120, // Space for bottom button
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 34,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: Color(0xFF000000),
                letterSpacing: -0.5,
              ),
              children: [
                TextSpan(text: t.v2.onboarding.splash.title1),
                TextSpan(
                  text: t.v2.onboarding.splash.title2,
                  style: const TextStyle(color: Color(0xFF3B82F6)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _BenefitItem(text: t.v2.onboarding.splash.benefit1),
          const SizedBox(height: 8),
          _BenefitItem(text: t.v2.onboarding.splash.benefit2),
          const SizedBox(height: 8),
          _BenefitItem(text: t.v2.onboarding.splash.benefit3),
          const SizedBox(height: 64),
          Center(
            child: Image.network(
              'https://raw.githubusercontent.com/fluentui/fluentui-emoji/main/assets/Seedling/3D/seedling_3d.png',
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4B5563),
        height: 1.3,
      ),
    );
  }
}
