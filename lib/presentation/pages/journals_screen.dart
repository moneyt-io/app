import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';
import '../molecules/empty_state.dart';
import '../molecules/journal_entry_list_item.dart';
import '../organisms/app_drawer.dart';
import '../organisms/journal_filter_section.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({Key? key}) : super(key: key);

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  final JournalUseCases _journalUseCases = GetIt.instance<JournalUseCases>();
  
  List<JournalEntry> _journals = [];
  bool _isLoading = true;
  String? _error;
  
  // Filtros
  DateTime? _startDate;
  DateTime? _endDate;
  String? _documentType;

  @override
  void initState() {
    super.initState();
    _loadJournals();
  }

  Future<void> _loadJournals() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      var journals = await _journalUseCases.getAllJournalEntries();
      
      // Aplicar filtros si están configurados
      if (_startDate != null) {
        journals = journals.where((j) => 
          j.date.isAfter(_startDate!) || 
          j.date.isAtSameMomentAs(_startDate!)
        ).toList();
      }
      
      if (_endDate != null) {
        // Ajustar para incluir todo el día final
        final endOfDay = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);
        journals = journals.where((j) => 
          j.date.isBefore(endOfDay) || 
          j.date.isAtSameMomentAs(endOfDay)
        ).toList();
      }
      
      if (_documentType != null) {
        journals = journals.where((j) => 
          j.documentTypeId == _documentType
        ).toList();
      }
      
      // Ordenar por fecha descendente
      journals.sort((a, b) => b.date.compareTo(a.date));
      
      setState(() {
        _journals = journals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _navigateToJournalDetail(JournalEntry journal) {
    NavigationService.navigateTo(
      AppRoutes.journalDetail, 
      arguments: journal
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diarios Contables'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _loadJournals,
        child: Column(
          children: [
            // Sección de filtros
            JournalFilterSection(
              startDate: _startDate,
              endDate: _endDate,
              documentType: _documentType,
              onStartDateChanged: (date) {
                setState(() {
                  _startDate = date;
                  _loadJournals();
                });
              },
              onEndDateChanged: (date) {
                setState(() {
                  _endDate = date;
                  _loadJournals();
                });
              },
              onDocumentTypeChanged: (type) {
                setState(() {
                  _documentType = type;
                  _loadJournals();
                });
              },
            ),
            
            // Lista de diarios
            Expanded(
              child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                  ? _buildErrorState()
                  : _journals.isEmpty
                    ? _buildEmptyState()
                    : _buildJournalList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _journals.length,
      itemBuilder: (context, index) {
        final journal = _journals[index];
        return JournalEntryListItem(
          journal: journal,
          onTap: () => _navigateToJournalDetail(journal),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('Error al cargar los diarios contables'),
          const SizedBox(height: 8),
          Text(_error ?? 'Error desconocido'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadJournals,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.book,
      title: 'No hay diarios contables',
      message: _hasActiveFilters()
        ? 'No se encontraron diarios con los filtros aplicados'
        : 'Aún no se han registrado diarios contables',
    );
  }
  
  bool _hasActiveFilters() {
    return _startDate != null || _endDate != null || _documentType != null;
  }
}
