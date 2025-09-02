import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entities/contact.dart';
import '../../../core/molecules/info_card.dart';

class LoanLenderInfoCard extends StatelessWidget {
  final Contact? lender;

  const LoanLenderInfoCard({
    Key? key,
    this.lender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default lender info if no contact is provided
    final lenderName = lender?.name ?? 'Honda Finance';
    final lenderDescription = lender?.note ?? 'Auto Loan Department';
    final lenderPhone = lender?.phone;
    final lenderEmail = lender?.email;

    return InfoCard(
      title: 'Lender',
      child: Row(
        children: [
          // Lender Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE), // bg-blue-100
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance,
              color: Color(0xFF2563EB), // text-blue-600
              size: 24,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Lender Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lenderName,
                  style: const TextStyle(
                    color: Color(0xFF1F2937), // text-slate-800
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lenderDescription,
                  style: const TextStyle(
                    color: Color(0xFF6B7280), // text-slate-500
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lenderPhone?.isNotEmpty ?? false)
                _buildActionButton(
                  icon: Icons.phone,
                  backgroundColor: const Color(0xFFDBEAFE), // bg-blue-100
                  iconColor: const Color(0xFF2563EB), // text-blue-600
                  onTap: () => _launchUrl('tel:$lenderPhone'),
                ),
              
              const SizedBox(width: 8),
              
              if (lenderEmail?.isNotEmpty ?? false)
                _buildActionButton(
                  icon: Icons.language,
                  backgroundColor: const Color(0xFFDCFCE7), // bg-green-100
                  iconColor: const Color(0xFF16A34A), // text-green-600
                  onTap: () => _launchUrl('mailto:$lenderEmail'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Handle error silently or show a snackbar if context is available
      debugPrint('Could not launch $url');
    }
  }
}
