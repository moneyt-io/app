import 'package:flutter/material.dart';

class BackupSettings {
  final Duration frequency;
  final bool enabled;
  final String backupDirectory;
  final TimeOfDay? scheduledTime;  // Nueva propiedad
  final int retentionDays;        // Nueva propiedad

  BackupSettings({
    required this.frequency,
    required this.enabled,
    required this.backupDirectory,
    this.scheduledTime,           // Opcional
    this.retentionDays = 30,     // Por defecto 30 días
  });
}
