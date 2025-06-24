import 'package:flutter/material.dart';
import '../../../domain/entities/credit_card.dart';

/// Representa un pago próximo de tarjeta de crédito
class CreditCardPayment {
  final CreditCard creditCard;
  final double amount;
  final DateTime dueDate;
  final int daysLeft;

  const CreditCardPayment({
    required this.creditCard,
    required this.amount,
    required this.dueDate,
    required this.daysLeft,
  });
}

/// Lista de próximos pagos de tarjetas de crédito
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white mt-6 mx-4 rounded-xl shadow-sm">
///   <div class="px-4 py-3 border-b border-slate-100">
///     <h3 class="text-slate-800 text-base font-semibold">Upcoming Payments</h3>
///   </div>
/// ```
class UpcomingPaymentsList extends StatelessWidget {
  const UpcomingPaymentsList({
    Key? key,
    required this.payments,
    this.onPaymentTap,
  }) : super(key: key);

  final List<CreditCardPayment> payments;
  final Function(CreditCardPayment)? onPaymentTap;

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0), // HTML: mt-6 mx-4
      decoration: BoxDecoration(
        color: Colors.white, // HTML: bg-white
        borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Upcoming Payments',
                  style: const TextStyle(
                    fontSize: 16, // HTML: text-base
                    fontWeight: FontWeight.w600, // HTML: font-semibold
                    color: Color(0xFF1E293B), // HTML: text-slate-800
                  ),
                ),
              ],
            ),
          ),
          
          // Payments list
          Container(
            padding: const EdgeInsets.all(4), // HTML: p-1
            child: Column(
              children: payments.map((payment) => _buildPaymentItem(payment)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(CreditCardPayment payment) {
    // Determinar color y urgencia basado en días restantes
    Color urgencyColor;
    if (payment.daysLeft <= 2) {
      urgencyColor = const Color(0xFFDC2626); // Rojo para urgente
    } else if (payment.daysLeft <= 5) {
      urgencyColor = const Color(0xFFF97316); // Naranja para pronto
    } else {
      urgencyColor = const Color(0xFF059669); // Verde para normal
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPaymentTap != null ? () => onPaymentTap!(payment) : null,
        borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12), // HTML: px-3 py-3
          child: Row(
            children: [
              // Icon
              Container(
                width: 40, // HTML: h-10 w-10
                height: 40,
                decoration: BoxDecoration(
                  color: urgencyColor.withOpacity(0.1), // HTML: bg-orange-100
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.schedule,
                  color: urgencyColor, // HTML: text-orange-600
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12), // HTML: gap-3
              
              // Card info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.creditCard.name,
                      style: const TextStyle(
                        fontSize: 14, // HTML: text-sm
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Color(0xFF1E293B), // HTML: text-slate-800
                      ),
                    ),
                    Text(
                      'Payment due: ${_formatDate(payment.dueDate)}',
                      style: const TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ],
                ),
              ),
              
              // Amount and days left
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${_formatAmount(payment.amount)}',
                    style: const TextStyle(
                      fontSize: 14, // HTML: text-sm
                      fontWeight: FontWeight.bold, // HTML: font-bold
                      color: Color(0xFF0F172A), // HTML: text-slate-900
                    ),
                  ),
                  Text(
                    '${payment.daysLeft} days left',
                    style: TextStyle(
                      fontSize: 12, // HTML: text-xs
                      fontWeight: FontWeight.w500, // HTML: font-medium
                      color: urgencyColor, // HTML: text-orange-600
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
