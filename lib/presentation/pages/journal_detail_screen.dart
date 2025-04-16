import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/journal_detail.dart';
import '../../domain/usecases/chart_account_usecases.dart';
import '../molecules/journal_detail_list_item.dart';

class JournalDetailScreen extends StatefulWidget {
  // Modificar para aceptar null
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
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
              child: Column(
                children: [
                  // Encabezado del diario
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Diario Contable',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'N° ${journal.secuencial}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow('Tipo', _getDocumentTypeLabel()),
                            _buildInfoRow('Fecha', DateFormat('dd/MM/yyyy').format(journal.date)),
                            if (journal.description != null)
                              _buildInfoRow('Descripción', journal.description!),
                            _buildInfoRow('Creado', DateFormat('dd/MM/yyyy HH:mm').format(journal.createdAt)),
                            const SizedBox(height: 8),
                            Divider(color: colorScheme.outline.withOpacity(0.3)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estado:',
                                  style: textTheme.bodyMedium,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: journal.isBalanced 
                                        ? Colors.green.withOpacity(0.1) 
                                        : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    journal.isBalanced ? 'Balanceado' : 'Desbalanceado',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: journal.isBalanced 
                                          ? Colors.green 
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Detalles del diario
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Asientos',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...journal.details.map((detail) => 
                          JournalDetailListItem(
                            detail: detail,
                            account: _accountsMap[detail.chartAccountId],
                          ),
                        ).toList(),
                        
                        // Totales
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Card(
                            elevation: 0,
                            color: colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: colorScheme.primary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TOTALES',
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'DEBE',
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          totalDebit.toStringAsFixed(2),
                                          style: textTheme.titleMedium?.copyWith(
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'HABER',
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          totalCredit.toStringAsFixed(2),
                                          style: textTheme.titleMedium?.copyWith(
                                            color: Colors.green[800],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
