import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Card de estadísticas de backups basado en backup_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white mt-6 mx-4 rounded-xl shadow-sm border border-slate-200">
///   <div class="px-4 py-3 border-b border-slate-100">
///     <h3 class="text-slate-800 text-base font-semibold">Backup Statistics</h3>
///   </div>
/// ```
class BackupStatisticsCard extends StatelessWidget {
  const BackupStatisticsCard({
    Key? key,
    required this.backups,
  }) : super(key: key);

  final List<File> backups;

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStatistics();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // HTML: bg-white
        borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
        border: Border.all(color: const Color(0xFFE2E8F0)), // HTML: border-slate-200
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
                  'Backup Statistics',
                  style: const TextStyle(
                    fontSize: 16, // HTML: text-base
                    fontWeight: FontWeight.w600, // HTML: font-semibold
                    color: Color(0xFF1E293B), // HTML: text-slate-800
                  ),
                ),
              ],
            ),
          ),
          
          // Statistics Content
          Container(
            padding: const EdgeInsets.all(16), // HTML: p-4
            child: Column(
              children: [
                // ✅ CORREGIDO: Usar ?? para manejar valores null
                _buildStatRow('Total Backups', stats['totalBackups'] ?? '0'),
                const SizedBox(height: 12), // HTML: space-y-3
                _buildStatRow('Total Size', stats['totalSize'] ?? '0 MB'),
                const SizedBox(height: 12),
                _buildStatRow('Oldest Backup', stats['oldestBackup'] ?? 'N/A'),
                const SizedBox(height: 12),
                _buildStatRow('Latest Backup', stats['latestBackup'] ?? 'N/A'),
                
                // Auto Backup Status
                Container(
                  margin: const EdgeInsets.only(top: 12), // HTML: pt-3
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFF1F5F9), // HTML: border-slate-100
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Auto Backup Status',
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF475569), // HTML: text-slate-600
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8, // HTML: w-2
                            height: 8, // HTML: h-2
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981), // HTML: bg-green-500
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8), // HTML: gap-2
                          const Text(
                            'Active',
                            style: TextStyle(
                              fontSize: 14, // HTML: text-sm
                              fontWeight: FontWeight.w500, // HTML: font-medium
                              color: Color(0xFF059669), // HTML: text-green-600
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye una fila de estadística
  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14, // HTML: text-sm
            color: Color(0xFF475569), // HTML: text-slate-600
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14, // HTML: text-sm
            fontWeight: FontWeight.w500, // HTML: font-medium
            color: Color(0xFF0F172A), // HTML: text-slate-900
          ),
        ),
      ],
    );
  }

  /// Calcula las estadísticas de los backups
  Map<String, String> _calculateStatistics() {
    if (backups.isEmpty) {
      return {
        'totalBackups': '0',
        'totalSize': '0 MB',
        'oldestBackup': 'N/A',
        'latestBackup': 'N/A',
      };
    }

    // Calcular tamaño total
    int totalBytes = 0;
    DateTime? oldestDate;
    DateTime? latestDate;

    for (final backup in backups) {
      try {
        final stat = backup.statSync();
        totalBytes += stat.size;
        
        if (oldestDate == null || stat.modified.isBefore(oldestDate)) {
          oldestDate = stat.modified;
        }
        
        if (latestDate == null || stat.modified.isAfter(latestDate)) {
          latestDate = stat.modified;
        }
      } catch (e) {
        // Ignorar errores de archivos
      }
    }

    // Formatear tamaño
    String formattedSize;
    if (totalBytes > 1024 * 1024) {
      formattedSize = '${(totalBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else if (totalBytes > 1024) {
      formattedSize = '${(totalBytes / 1024).toStringAsFixed(1)} KB';
    } else {
      formattedSize = '$totalBytes B';
    }

    // Formatear fechas
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    return {
      'totalBackups': backups.length.toString(),
      'totalSize': formattedSize,
      'oldestBackup': oldestDate != null ? dateFormat.format(oldestDate) : 'N/A',
      'latestBackup': latestDate != null ? dateFormat.format(latestDate) : 'N/A',
    };
  }
}
