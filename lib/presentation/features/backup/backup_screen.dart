import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart'; // ✅ AGREGADO: Para compartir
import 'package:intl/intl.dart'; // ✅ AGREGADO: Para formatear fecha al compartir
import 'backup_provider.dart';
import '../../core/molecules/backup_list_item.dart'; // ✅ CORREGIDO: Usar molecules en lugar de organisms
import '../../core/molecules/backup_filter_tabs.dart'; // ✅ AGREGADO: Import de filter tabs
import '../../core/molecules/backup_statistics_card.dart'; // ✅ AGREGADO: Import de statistics
import '../../core/atoms/expandable_fab.dart'; // ✅ AGREGADO: Import de ExpandableFab
import '../../core/atoms/app_app_bar.dart'; // ✅ AGREGADO: Import del AppBar
import '../../core/organisms/app_drawer.dart'; // ✅ AGREGADO: Import del drawer
import '../../core/design_system/tokens/app_colors.dart'; // ✅ AGREGADO: Import de colores
import '../../core/l10n/generated/strings.g.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedFilter = 'All'; // ✅ AGREGADO: Estado para filtros

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        Provider.of<BackupProvider>(context, listen: false).loadBackups();
      } catch (e) {
        print("Error accessing BackupProvider on init: $e");
      }
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      // ✅ CORREGIDO: Usar AppAppBar con blur effect
      appBar: AppAppBar(
        title: t.backups.title,
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.back, // ✅ CAMBIO: Botón de regresar
        actions: const [AppAppBarAction.none],
        onLeadingPressed: () => Navigator.pop(context),
      ),
      
      drawer: const AppDrawer(),
      
      body: Column(
        children: [
          // ✅ AGREGADO: Filter Section basado en backup_list.html
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Quick Filter Tabs
                BackupFilterTabs(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                ),
                
                const SizedBox(height: 12), // HTML: space-y-3
                
                // Date Filters
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildDateFilter(t.backups.filters.thisMonth),
                            const SizedBox(width: 8),
                            _buildDateFilter(t.backups.filters.lastMonth),
                            const SizedBox(width: 8),
                            _buildDateFilter(t.backups.filters.thisYear),
                            const SizedBox(width: 8),
                            _buildDateFilter(t.backups.filters.lastYear),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Consumer<BackupProvider>(
              builder: (context, backupProvider, child) {
                if (backupProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  );
                }

                if (backupProvider.errorMessage != null) {
                  return _buildErrorState(backupProvider.errorMessage!);
                }

                final backups = _getFilteredBackups(backupProvider.backupFiles ?? []);

                return RefreshIndicator(
                  onRefresh: () => backupProvider.loadBackups(),
                  color: AppColors.primaryBlue,
                  child: backups.isEmpty 
                      ? _buildEmptyState()
                      : _buildBackupsList(backups, backupProvider),
                );
              },
            ),
          ),
        ],
      ),
      
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
            label: t.backups.actions.create,
            icon: Icons.add, // Más limpio que backup
            backgroundColor: AppColors.primaryBlue,
            onPressed: () => _createNewBackup(context),
          ),
          FabAction(
            label: t.backups.actions.import,
            icon: Icons.upload_file,
            backgroundColor: const Color(0xFF64748B), // Slate 500 para acción secundaria
            onPressed: () => _importBackupFromFile(context),
          ),
        ],
      ),
    );
  }

  /// ✅ AGREGADO: Construye filtro de fecha
  Widget _buildDateFilter(String label) {
    return Container(
      height: 32, // HTML: h-8
      padding: const EdgeInsets.symmetric(horizontal: 12), // HTML: px-3
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // HTML: bg-slate-100
        borderRadius: BorderRadius.circular(16), // HTML: rounded-full
        border: Border.all(color: const Color(0xFFE2E8F0)), // HTML: border-slate-200
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12, // HTML: text-xs
            fontWeight: FontWeight.w500, // HTML: font-medium
            color: Color(0xFF64748B), // HTML: text-slate-600
          ),
        ),
      ),
    );
  }

  /// ✅ AGREGADO: Filtrar backups según selección
  List<File> _getFilteredBackups(List<File> backups) {
    if (_selectedFilter == 'All') return backups;
    
    return backups.where((backup) {
      final fileName = backup.path.toLowerCase();
      switch (_selectedFilter) {
        case 'Auto':
          return fileName.contains('auto');
        case 'Manual':
          return fileName.contains('manual');
        default:
          return true;
      }
    }).toList();
  }

  /// ✅ REFACTORIZADO: Lista de backups con estadísticas
  Widget _buildBackupsList(List<File> backups, BackupProvider provider) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80), // Espacio para FAB
      children: [
        // Backup Items
        ...backups.asMap().entries.map((entry) {
          final index = entry.key;
          final backupFile = entry.value;
          final isLatest = index == 0; // El primero es el más reciente
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BackupListItem(
              backupFile: backupFile,
              isLatest: isLatest,
              onRestore: () => _restoreBackup(context, provider, backupFile),
              onDelete: () => _deleteBackup(context, provider, backupFile),
              onShare: () => _shareBackup(backupFile),
              onGetMetadata: () => _showBackupMetadata(context, provider, backupFile),
            ),
          );
        }),
        
        const SizedBox(height: 24),
        
        // ✅ AGREGADO: Backup Statistics
        BackupStatisticsCard(backups: backups),
      ],
    );
  }

  /// ✅ AGREGADO: Mostrar metadatos del backup con BottomSheet
  Future<void> _showBackupMetadata(BuildContext context, BackupProvider provider, File backupFile) async {
    final fileName = backupFile.path.split(Platform.pathSeparator).last;
    // Formato de tamaño mejorado
    final bytes = backupFile.lengthSync();
    String fileSize;
    if (bytes < 1024) {
      fileSize = '$bytes B';
    } else if (bytes < 1024 * 1024) {
      fileSize = '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      fileSize = '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    
    final dateStr = DateFormat.yMMMd().add_jm().format(backupFile.lastModifiedSync());

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.description_outlined, color: AppColors.primaryBlue, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.backups.dialogs.info.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        t.backups.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.grey[500],
                ),
              ],
            ),
            
            const SizedBox(height: 32),

            // Info Items
            _buildMetadataItem(Icons.insert_drive_file_outlined, t.backups.dialogs.info.file, fileName),
            const SizedBox(height: 20),
            _buildMetadataItem(Icons.sd_storage_outlined, t.backups.dialogs.info.size, fileSize),
             const SizedBox(height: 20),
            _buildMetadataItem(Icons.calendar_today_outlined, t.backups.dialogs.info.created, dateStr),
            
            const SizedBox(height: 40),
            
            // Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(t.backups.actions.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9), // slate-100
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF64748B)), // slate-500
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B), // slate-500
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F172A), // slate-900
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              t.backups.status.error,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(error),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<BackupProvider>().loadBackups();
              },
              child: Text(t.backups.actions.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.backup_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              t.backups.status.empty,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              t.backups.status.emptyAction,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBackupSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.backups.menu.comingSoon),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  Future<void> _importBackupFromFile(BuildContext context) async {
    final backupProvider = Provider.of<BackupProvider>(context, listen: false);
    await backupProvider.restoreBackupFromFile(context);
  }

  // --- Métodos de Acción ---

  Future<void> _createNewBackup(BuildContext context) async {
    final backupProvider = Provider.of<BackupProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final createdFile = await backupProvider.createBackup();

    if (mounted) {
       if (createdFile != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(t.backups.status.created)),
        );
      } else if (backupProvider.errorMessage != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(t.backups.status.createError(error: backupProvider.errorMessage!)),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // --- Métodos de Gestión de Archivos ---

  Future<void> _shareBackup(File backupFile) async {
    try {
      if (!await backupFile.exists()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.backups.status.createError(error: 'File not found'))),
          );
        }
        return;
      }
      
      final box = context.findRenderObject() as RenderBox?;
      final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(backupFile.lastModifiedSync());

      await Share.shareXFiles(
        [XFile(backupFile.path)],
        subject: 'Copia de seguridad MoneyT',
        text: 'Adjunto mi copia de seguridad de MoneyT del $dateStr.',
        sharePositionOrigin: box != null ? box.localToGlobal(Offset.zero) & box.size : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al compartir: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _restoreBackup(BuildContext context, BackupProvider backupProvider, File backupFile) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.backups.dialogs.restore.title),
          content: Text(t.backups.dialogs.restore.content(file: backupFile.path.split(Platform.pathSeparator).last)),
          actions: <Widget>[
            TextButton(
              child: Text(t.backups.actions.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text(t.backups.actions.restore, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final success = await backupProvider.restoreBackup(backupFile);
       if (mounted) {
          if (success) {
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(t.backups.dialogs.restore.success)),
            );
          } else if (backupProvider.errorMessage != null) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(t.backups.status.restoreError(error: backupProvider.errorMessage!)),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
       }
    }
  }

  Future<void> _deleteBackup(BuildContext context, BackupProvider backupProvider, File backupFile) async {
     final scaffoldMessenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.backups.dialogs.delete.title),
          content: Text(t.backups.dialogs.delete.content(file: backupFile.path.split(Platform.pathSeparator).last)),
          actions: <Widget>[
            TextButton(
              child: Text(t.backups.actions.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text(t.backups.actions.delete, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await backupProvider.deleteBackup(backupFile);
       if (mounted) {
          if (backupProvider.errorMessage == null) {
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(t.backups.dialogs.delete.success)),
            );
          } else {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(t.backups.status.deleteError(error: backupProvider.errorMessage!)),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
       }
    }
  }
}
