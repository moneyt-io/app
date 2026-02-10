import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<void> _loadWidgetConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    final String? configString = prefs.getString('dashboard_widgets_config');

    // Tipos permitidos
    final validTypes = {
      DashboardWidgetType.balance,
      DashboardWidgetType.quickActions,
      DashboardWidgetType.wallets,
      DashboardWidgetType.transactions,
    };

    if (configString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(configString);
        setState(() {
          _widgets = jsonList
              .map((item) => WidgetConfig(
                    type: DashboardWidgetType.values.firstWhere(
                        (e) => e.toString() == item['type'],
                        orElse: () => DashboardWidgetType.balance),
                    enabled: item['enabled'],
                    order: item['order'],
                  ))
              .where((w) => validTypes.contains(w.type))
              .toList();
          
          // Ordenar por orden guardado
          _widgets.sort((a, b) => a.order.compareTo(b.order));
        });
        
        // Si se filtraron widgets, guardar la configuración limpia
        if (_widgets.length != jsonList.length) {
          _autoSave();
        }
        return;
      } catch (e) {
        debugPrint('Error parsing widget config: $e');
      }
    }

    // Configuración por defecto si no hay guardada o error
    setState(() {
      _widgets = [
        const WidgetConfig(
            type: DashboardWidgetType.balance, enabled: true, order: 1),
        const WidgetConfig(
            type: DashboardWidgetType.quickActions, enabled: true, order: 2),
        const WidgetConfig(
            type: DashboardWidgetType.wallets, enabled: true, order: 3),
        const WidgetConfig(
            type: DashboardWidgetType.transactions, enabled: true, order: 4),
      ];
    });
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
    });
    _autoSave();
  }

  /// Maneja el toggle de un widget
  void _handleToggle(DashboardWidgetType type, bool enabled) {
    setState(() {
      final index = _widgets.indexWhere((w) => w.type == type);
      if (index != -1) {
        _widgets[index] = _widgets[index].copyWith(enabled: enabled);
      }
    });
    _autoSave();
  }

  /// Guarda los cambios automáticamente
  Future<void> _autoSave() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final List<Map<String, dynamic>> jsonList = _widgets
          .map((item) => {
                'type': item.type.toString(),
                'enabled': item.enabled,
                'order': item.order,
              })
          .toList();

      await prefs.setString('dashboard_widgets_config', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error auto-saving widget config: $e');
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
        // Always pass true so the home screen reloads the widgets configuration on return
        onLeadingPressed: () => Navigator.of(context).pop(true),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
