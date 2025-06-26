import 'package:flutter/material.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/widget_config_item.dart';
import '../../core/molecules/sticky_action_footer.dart';
import '../../core/organisms/draggable_widget_list.dart';
import '../../navigation/navigation_service.dart';

/// Pantalla de configuración de widgets del dashboard
/// Basada en dashboard_widgets.html
class DashboardWidgetsScreen extends StatefulWidget {
  const DashboardWidgetsScreen({Key? key}) : super(key: key);

  @override
  State<DashboardWidgetsScreen> createState() => _DashboardWidgetsScreenState();
}

class _DashboardWidgetsScreenState extends State<DashboardWidgetsScreen> {
  List<WidgetConfig> _widgets = [];
  bool _hasChanges = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadWidgetConfiguration();
  }

  /// Carga la configuración inicial de widgets
  void _loadWidgetConfiguration() {
    // TODO: Cargar desde SharedPreferences o servicio
    _widgets = [
      const WidgetConfig(type: DashboardWidgetType.balance, enabled: true, order: 1),
      const WidgetConfig(type: DashboardWidgetType.quickActions, enabled: true, order: 2),
      const WidgetConfig(type: DashboardWidgetType.wallets, enabled: true, order: 3),
      const WidgetConfig(type: DashboardWidgetType.loans, enabled: true, order: 4),
      const WidgetConfig(type: DashboardWidgetType.transactions, enabled: true, order: 5),
      const WidgetConfig(type: DashboardWidgetType.chartAccounts, enabled: false, order: 6),
      const WidgetConfig(type: DashboardWidgetType.creditCards, enabled: false, order: 7),
    ];
  }

  /// Maneja el reordenamiento de widgets
  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _widgets.removeAt(oldIndex);
      _widgets.insert(newIndex, item);
      
      // Actualizar órdenes
      for (int i = 0; i < _widgets.length; i++) {
        _widgets[i] = _widgets[i].copyWith(order: i + 1);
      }
      
      _hasChanges = true;
    });
  }

  /// Maneja el toggle de un widget
  void _handleToggle(DashboardWidgetType type, bool enabled) {
    setState(() {
      final index = _widgets.indexWhere((w) => w.type == type);
      if (index != -1) {
        _widgets[index] = _widgets[index].copyWith(enabled: enabled);
        _hasChanges = true;
      }
    });
  }

  /// Resetea a la configuración por defecto
  void _resetToDefault() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Default Layout'),
        content: const Text(
          'Reset dashboard to default layout? This will restore all widgets to their original positions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _loadWidgetConfiguration();
                _hasChanges = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dashboard reset to default layout!'),
                  backgroundColor: Color(0xFF16A34A),
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  /// Guarda los cambios
  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // TODO: Guardar en SharedPreferences o servicio
      await Future.delayed(const Duration(milliseconds: 800)); // Simular guardado
      
      if (mounted) {
        setState(() {
          _hasChanges = false;
          _isSaving = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changes saved successfully!'),
            backgroundColor: Color(0xFF16A34A),
          ),
        );
        
        // Regresar al dashboard después de un momento
        Future.delayed(const Duration(milliseconds: 500), () {
          NavigationService.goBack();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving changes: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      appBar: AppAppBar(
        title: 'Dashboard Widgets',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        onLeadingPressed: () => NavigationService.goBack(),
      ),
      
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16), // HTML: px-4
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget List
                  DraggableWidgetList(
                    widgets: _widgets,
                    onReorder: _handleReorder,
                    onToggle: _handleToggle,
                  ),
                  
                  const SizedBox(height: 24), // HTML: mt-6
                  
                  // Reset Button
                  AppButton(
                    text: 'Reset to Default Layout',
                    onPressed: _resetToDefault,
                    type: AppButtonType.outlined,
                    icon: Icons.refresh,
                    isFullWidth: true,
                  ),
                  
                  const SizedBox(height: 100), // Space for sticky footer
                ],
              ),
            ),
          ),
          
          // Sticky Footer
          StickyActionFooter(
            primaryText: _isSaving ? 'Saving...' : 'Save Changes',
            onPrimaryPressed: _saveChanges,
            isLoading: _isSaving,
            isPrimaryEnabled: _hasChanges && !_isSaving,
          ),
        ],
      ),
    );
  }
}
