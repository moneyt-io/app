import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/entities/journal_entry.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../molecules/journal_detail_list_item.dart';
import '../../../core/presentation/app_dimensions.dart';

class JournalDetailScreen extends StatefulWidget {
  final JournalEntry? journal;

  const JournalDetailScreen({
    Key? key,
    this.journal,
  }) : super(key: key);

  @override
  State<JournalDetailScreen> createState() => _JournalDetailScreenState();
}

class _JournalDetailScreenState extends State<JournalDetailScreen> {
  final ChartAccountUseCases _chartAccountUseCases = 
      GetIt.instance<ChartAccountUseCases>();
  
  Map<int, ChartAccount> _accountsMap = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obtenemos todas las cuentas y creamos un mapa para acceso rápido
      final accounts = await _chartAccountUseCases.getAllChartAccounts();
      final accountsMap = {for (var acc in accounts) acc.id: acc};
      
      setState(() {
        _accountsMap = accountsMap;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar las cuentas: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  String _getDocumentTypeLabel() {
    switch (widget.journal!.documentTypeId) {
      case 'I': return 'Ingreso';
      case 'E': return 'Gasto';
      case 'T': return 'Transferencia';
      case 'L': return 'Préstamo Otorgado';
      case 'B': return 'Préstamo Recibido';
      default: return 'Otro';
    }
  }

  Color _getDocumentTypeColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (widget.journal!.documentTypeId) {
      case 'I': return Colors.green;
      case 'E': return colorScheme.error;
      case 'T': return colorScheme.tertiary;
      case 'L': return Colors.blue;
      case 'B': return Colors.orange;
      default: return colorScheme.primary;
    }
  }

  IconData _getDocumentTypeIcon() {
    switch (widget.journal!.documentTypeId) {
      case 'I': return Icons.arrow_upward;
      case 'E': return Icons.arrow_downward;
      case 'T': return Icons.swap_horiz;
      case 'L': return Icons.attach_money;
      case 'B': return Icons.money_off;
      default: return Icons.receipt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    if (widget.journal == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de Diario'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('No se encontró el diario contable'),
        ),
      );
    }
    
    final journal = widget.journal!;
    
    // Calcular totales
    double totalDebit = 0;
    double totalCredit = 0;
    
    for (final detail in journal.details) {
      totalDebit += detail.debit;
      totalCredit += detail.credit;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Diario N° ${journal.secuencial}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado del diario con mejoras visuales
                  _buildJournalHeader(journal, colorScheme, textTheme),
                  
                  SizedBox(height: AppDimensions.spacing24),
                  
                  // Sección de detalles
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                      side: BorderSide(
                        color: colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimensions.spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Asientos Contables',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacing16),
                          
                          // Encabezados de la tabla
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppDimensions.spacing8,
                              right: AppDimensions.spacing8,
                              bottom: AppDimensions.spacing8
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    'Cuenta',
                                    style: textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Débito',
                                    style: textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Crédito',
                                    style: textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Divider(color: colorScheme.outline.withOpacity(0.2)),
                          
                          // Lista de asientos
                          ...journal.details.map((detail) => 
                            JournalDetailListItem(
                              detail: detail,
                              account: _accountsMap[detail.chartAccountId],
                            ),
                          ).toList(),
                          
                          Divider(color: colorScheme.outline.withOpacity(0.2)),
                          
                          // Totales
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.spacing8,
                              vertical: AppDimensions.spacing8
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    'TOTALES',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    NumberFormat.currency(symbol: '\$').format(totalDebit),
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    NumberFormat.currency(symbol: '\$').format(totalCredit),
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Estado del balance
                          if (totalDebit != totalCredit) ...[
                            SizedBox(height: AppDimensions.spacing8),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppDimensions.spacing8),
                              decoration: BoxDecoration(
                                color: colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                              ),
                              child: Text(
                                'Los débitos y créditos no coinciden. Diferencia: ${NumberFormat.currency(symbol: '\$').format((totalDebit - totalCredit).abs())}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.error,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ] else ...[
                            SizedBox(height: AppDimensions.spacing8),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppDimensions.spacing8),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                              ),
                              child: Text(
                                'El asiento contable está balanceado',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.green.shade900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildJournalHeader(JournalEntry journal, ColorScheme colorScheme, TextTheme textTheme) {
    final typeColor = _getDocumentTypeColor(context);
    final typeIcon = _getDocumentTypeIcon();
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icono del tipo de documento
                Container(
                  padding: EdgeInsets.all(AppDimensions.spacing8),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    typeIcon,
                    color: typeColor,
                    size: AppDimensions.iconSizeMedium,
                  ),
                ),
                SizedBox(width: AppDimensions.spacing12),
                
                // Título y fecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDocumentTypeLabel(),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing4),
                      Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(journal.date)}',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                
                // Número de diario
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'N° ${journal.secuencial}',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacing4),
                    Text(
                      'ID: ${journal.id}',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            
            if (journal.description != null) ...[
              SizedBox(height: AppDimensions.spacing16),
              Divider(),
              SizedBox(height: AppDimensions.spacing8),
              Text(
                'Descripción:',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.spacing4),
              Text(
                journal.description!,
                style: textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
