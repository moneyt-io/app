import 'package:flutter/material.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/widget_config_item.dart';
import '../../core/molecules/sticky_action_footer.dart';
import '../../core/organisms/draggable_widget_list.dart';
import '../../navigation/navigation_service.dart';
import '../../core/l10n/generated/strings.g.dart';

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
      const WidgetConfig(
          type: DashboardWidgetType.balance, enabled: true, order: 1),
      const WidgetConfig(
          type: DashboardWidgetType.quickActions, enabled: true, order: 2),
      const WidgetConfig(
          type: DashboardWidgetType.wallets, enabled: true, order: 3),
      const WidgetConfig(
          type: DashboardWidgetType.loans, enabled: true, order: 4),
      const WidgetConfig(
          type: DashboardWidgetType.transactions, enabled: true, order: 5),
      const WidgetConfig(
          type: DashboardWidgetType.chartAccounts, enabled: false, order: 6),
      const WidgetConfig(
          type: DashboardWidgetType.creditCards, enabled: false, order: 7),
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
        title: Text(t.dashboard.widgets.settings.reset.dialogTitle),
        content: Text(
          t.dashboard.widgets.settings.reset.dialogContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.dashboard.widgets.settings.reset.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _loadWidgetConfiguration();
                _hasChanges = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.dashboard.widgets.settings.reset.success),
                  backgroundColor: const Color(0xFF16A34A),
                ),
              );
            },
            child: Text(t.dashboard.widgets.settings.reset.confirm),
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
      await Future.delayed(
          const Duration(milliseconds: 800)); // Simular guardado

      if (mounted) {
        setState(() {
          _hasChanges = false;
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.dashboard.widgets.settings.saveSuccess),
            backgroundColor: const Color(0xFF16A34A),
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
            content: Text(t.dashboard.widgets.settings.saveError(error: e.toString())),
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
        title: t.dashboard.widgets.settings.title,
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
                    text: t.dashboard.widgets.settings.reset.button,
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
            primaryText: _isSaving ? t.dashboard.widgets.settings.saving : t.dashboard.widgets.settings.save,
            onPrimaryPressed: _saveChanges,
            isLoading: _isSaving,
            isPrimaryEnabled: _hasChanges && !_isSaving,
          ),
        ],
      ),
    );
  }
}
