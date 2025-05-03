import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/journal_entry.dart';
import '../../../domain/usecases/journal_usecases.dart';
import '../../atoms/app_button.dart';
import '../../molecules/empty_state.dart';
import '../../molecules/search_field.dart';
import '../../organisms/app_drawer.dart';
import '../../organisms/journal_list_view.dart';
import '../../routes/navigation_service.dart';
import '../../routes/app_routes.dart';
import '../../../core/presentation/app_dimensions.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({Key? key}) : super(key: key);

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final JournalUseCases _journalUseCases = GetIt.instance<JournalUseCases>();
  
  // TabController para manejar las pestañas de tipos de documentos
  late TabController _tabController;
  
  List<JournalEntry> _journals = [];
  String _searchQuery = '';
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedFilter = 'all'; // all, month, week, custom
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Inicializar TabController con 5 pestañas
    // (Todas, Ingresos, Gastos, Transferencias, Préstamos)
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _loadJournals();
      }
    });
    _loadJournals();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  String? _getDocumentTypeFromTab() {
    switch (_tabController.index) {
      case 1: return 'I'; // Ingresos
      case 2: return 'E'; // Gastos
      case 3: return 'T'; // Transferencias
      case 4: return 'L'; // Préstamos (combinamos L y B aquí)
      default: return null; // Todas
    }
  }

  Future<void> _loadJournals() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      var journals = await _journalUseCases.getAllJournalEntries();
      
      // Obtener el tipo de documento según la pestaña seleccionada
      final documentType = _getDocumentTypeFromTab();
      
      // Aplicar filtro por tipo de documento si está seleccionado
      if (documentType != null) {
        if (documentType == 'L') {
          // Para la pestaña de préstamos, mostrar tanto 'L' como 'B'
          journals = journals.where((j) => 
            j.documentTypeId == 'L' || j.documentTypeId == 'B'
          ).toList();
        } else {
          journals = journals.where((j) => 
            j.documentTypeId == documentType
          ).toList();
        }
      }
      
      // Aplicar filtros de fecha
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
      
      // Aplicar filtro de búsqueda
      if (_searchQuery.isNotEmpty) {
        journals = journals.where((j) => 
          j.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false
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

  // Método para aplicar el filtro de fecha
  void _applyDateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      final now = DateTime.now();
      
      switch (filter) {
        case 'all':
          _startDate = null;
          _endDate = null;
          break;
        case 'month':
          _startDate = DateTime(now.year, now.month, 1);
          _endDate = DateTime(now.year, now.month + 1, 0);
          break;
        case 'week':
          // Calcular el inicio de la semana (lunes)
          final weekDay = now.weekday;
          _startDate = now.subtract(Duration(days: weekDay - 1));
          _endDate = now.add(Duration(days: 7 - weekDay));
          break;
        case 'custom':
          // No hacer nada, el calendario se mostrará para selección personalizada
          break;
      }
      
      _loadJournals();
    });
  }

  // Método para mostrar el selector de fecha personalizada
  Future<void> _selectCustomDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now().subtract(const Duration(days: 30)),
        end: _endDate ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _selectedFilter = 'custom';
        _loadJournals();
      });
    }
  }

  // Método para mostrar diálogo de filtro de fecha
  Future<void> _showFilterDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtrar por fecha'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Todas'),
              leading: Radio<String>(
                value: 'all',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Este mes'),
              leading: Radio<String>(
                value: 'month',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Esta semana'),
              leading: Radio<String>(
                value: 'week',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Rango personalizado'),
              leading: Radio<String>(
                value: 'custom',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _selectCustomDateRange();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diarios Contables',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Botón de filtro de fecha
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: colorScheme.primary,
            ),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrar por fecha',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos'),
            Tab(text: 'Ingresos'),
            Tab(text: 'Gastos'),
            Tab(text: 'Transf.'),
            Tab(text: 'Préstamos'),
          ],
          labelColor: colorScheme.primary,
          indicatorColor: colorScheme.primary,
          dividerColor: Colors.transparent,
          isScrollable: true,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar diarios',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _loadJournals();
                });
              },
            ),
          ),
          
          // Lista de diarios
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadJournals,
              child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                  ? _buildErrorState()
                  : _journals.isEmpty
                    ? _buildEmptyState()
                    : JournalListView(
                        journals: _journals,
                        onJournalTap: _navigateToJournalDetail,
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.book_outlined,
      title: 'No hay diarios',
      message: _searchQuery.isNotEmpty || _startDate != null || _endDate != null
          ? 'No se encontraron diarios que coincidan con los filtros'
          : 'No hay diarios contables registrados',
      action: (_searchQuery.isNotEmpty || _startDate != null || _endDate != null)
          ? AppButton(
              text: 'Limpiar filtros',
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                  _applyDateFilter('all');
                });
              },
              type: AppButtonType.text,
            )
          : null,
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.iconSizeXLarge,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(height: AppDimensions.spacing16),
          Text(
            'Error al cargar diarios',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppDimensions.spacing8),
          Text(_error ?? 'Error desconocido'),
          SizedBox(height: AppDimensions.spacing24),
          ElevatedButton(
            onPressed: _loadJournals,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
