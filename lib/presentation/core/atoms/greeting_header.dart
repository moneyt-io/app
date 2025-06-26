import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Header de saludo personalizado basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex items-center gap-3">
///   <button class="flex items-center justify-center h-10 w-10 rounded-full bg-blue-100 text-blue-600">
///     <span class="material-symbols-outlined">menu</span>
///   </button>
///   <div>
///     <h1 class="text-slate-900 text-lg font-semibold">Good morning, Alex</h1>
///     <p class="text-slate-500 text-sm">December 16, 2024</p>
///   </div>
/// </div>
/// ```
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    Key? key,
    required this.userName,
    required this.onMenuPressed,
    required this.onEditPressed,
    required this.onProfilePressed,
  }) : super(key: key);

  final String userName;
  final VoidCallback onMenuPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onProfilePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12), // HTML: p-4 pb-3
      child: Row(
        children: [
          // Menu button + greeting
          Expanded(
            child: Row(
              children: [
                // Menu button
                Material(
                  color: const Color(0xFFDBEAFE), // HTML: bg-blue-100
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: onMenuPressed,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40, // HTML: h-10 w-10
                      height: 40,
                      child: const Icon(
                        Icons.menu,
                        color: Color(0xFF2563EB), // HTML: text-blue-600
                        size: 24,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Greeting text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(userName),
                        style: const TextStyle(
                          fontSize: 18, // HTML: text-lg
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF0F172A), // HTML: text-slate-900
                        ),
                      ),
                      Text(
                        _getCurrentDate(),
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Row(
            children: [
              // Edit button
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: onEditPressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40, // HTML: h-10 w-10
                    height: 40,
                    child: const Icon(
                      Icons.edit,
                      color: Color(0xFF475569), // HTML: text-slate-600
                      size: 24,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 8), // HTML: gap-2
              
              // Profile button
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: onProfilePressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40, // HTML: w-10 h-10
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFBFDBFE), // HTML: border-blue-200
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBsQJ3sGZpJ3q69isqWPZ2PG3Z7ZK4fUlPLXSHh5KNSwjsn9DAaq6ujCXCl1zDsx2pQA5gPbPuHp2YAZmJXzZ89ZHGGCKDGSRWfetVNp2WrJY8E96LF44DLyevbiIlKQDFfn3Lg-DGC_MYR3GTnDzOUEtfPLGwDgHTY2czlIEF_brjjlnj4tuYQ_vyRuRh2KuvbT-gWvNbffV7EKW-hhC2uRwhVFQ6sne_qU5A8L4QM23oyYTonJSom0TtnwEEx6J5r2fUG6Io0zGSR',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Obtiene el saludo según la hora del día
  String _getGreeting(String name) {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good morning, $name';
    } else if (hour < 18) {
      return 'Good afternoon, $name';
    } else {
      return 'Good evening, $name';
    }
  }

  /// Obtiene la fecha actual formateada
  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d, yyyy', 'en_US');
    return formatter.format(now);
  }
}
