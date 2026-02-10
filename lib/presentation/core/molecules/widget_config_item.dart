import 'package:flutter/material.dart';
import '../atoms/drag_handle.dart';
import '../atoms/toggle_switch.dart';
import '../l10n/generated/strings.g.dart';

/// Tipos de widgets disponibles en el dashboard
enum DashboardWidgetType {
  balance,
  quickActions,
  wallets,
  loans,
  transactions,
  chartAccounts,
  creditCards,
}

/// Configuración de un widget individual
class WidgetConfig {
  final DashboardWidgetType type;
  final bool enabled;
  final int order;

  const WidgetConfig({
    required this.type,
    required this.enabled,
    required this.order,
  });

  WidgetConfig copyWith({
    DashboardWidgetType? type,
    bool? enabled,
    int? order,
  }) {
    return WidgetConfig(
      type: type ?? this.type,
      enabled: enabled ?? this.enabled,
      order: order ?? this.order,
    );
  }
}

/// Item de configuración de widget individual
/// 
/// HTML Reference:
/// ```html
/// <div class="widget-item bg-white rounded-xl shadow-sm border border-slate-200 p-4">
///   <div class="flex items-center justify-between">
///     <div class="flex items-center gap-3">
///       <button class="drag-handle">...</button>
///       <div class="flex items-center gap-3">
///         <div class="icon">...</div>
///         <div class="content">...</div>
///       </div>
///     </div>
///     <label class="toggle">...</label>
///   </div>
/// </div>
/// ```
class WidgetConfigItem extends StatelessWidget {
  const WidgetConfigItem({
    Key? key,
    required this.config,
    required this.onToggle,
    this.onDragStart,
    this.onDragEnd,
    this.isDragging = false,
  }) : super(key: key);

  final WidgetConfig config;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    final widgetInfo = _getWidgetInfo(config.type);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()
        ..scale(isDragging ? 1.05 : 1.0),
      child: Container(
        padding: const EdgeInsets.all(16), // HTML: p-4
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
          border: Border.all(
            color: const Color(0xFFE2E8F0), // HTML: border-slate-200
          ),
          boxShadow: isDragging 
              ? [
                  const BoxShadow(
                    color: Color(0x40000000), // HTML: shadow-lg when dragging
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color(0x0A000000), // HTML: shadow-sm
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
        ),
        child: Opacity(
          opacity: config.enabled ? 1.0 : 0.5, // HTML: disabled class opacity
          child: Row(
            children: [
              // Drag handle + Icon + Content
              Expanded(
                child: Row(
                  children: [
                    // Drag handle
                    DragHandle(
                      onTap: onDragStart,
                    ),
                    
                    const SizedBox(width: 12), // HTML: gap-3
                    
                    // Widget icon
                    Container(
                      width: 40, // HTML: h-10 w-10
                      height: 40,
                      decoration: BoxDecoration(
                        color: widgetInfo.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widgetInfo.icon,
                        color: widgetInfo.iconColor,
                        size: 24,
                      ),
                    ),
                    
                    const SizedBox(width: 12), // HTML: gap-3
                    
                    // Widget info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widgetInfo.title,
                            style: const TextStyle(
                              fontSize: 16, // HTML: text-base
                              fontWeight: FontWeight.w600, // HTML: font-semibold
                              color: Color(0xFF1E293B), // HTML: text-slate-800
                            ),
                          ),
                          Text(
                            widgetInfo.description,
                            style: const TextStyle(
                              fontSize: 14, // HTML: text-sm
                              color: Color(0xFF64748B), // HTML: text-slate-500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Toggle switch
              ToggleSwitch(
                value: config.enabled,
                onChanged: onToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Obtiene la información visual del widget según su tipo
  WidgetInfo _getWidgetInfo(DashboardWidgetType type) {
    switch (type) {
      case DashboardWidgetType.balance:
        return WidgetInfo(
          title: t.dashboard.widgets.balance.title,
          description: t.dashboard.widgets.balance.description,
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF2563EB), // HTML: text-blue-600
          backgroundColor: const Color(0xFFDBEAFE), // HTML: bg-blue-100
        );
      case DashboardWidgetType.quickActions:
        return WidgetInfo(
          title: t.dashboard.widgets.quickActions.title,
          description: t.dashboard.widgets.quickActions.description,
          icon: Icons.flash_on,
          iconColor: const Color(0xFF16A34A), // HTML: text-green-600
          backgroundColor: const Color(0xFFDCFCE7), // HTML: bg-green-100
        );
      case DashboardWidgetType.wallets:
        return WidgetInfo(
          title: t.dashboard.widgets.wallets.title,
          description: t.dashboard.widgets.wallets.description,
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF2563EB), // HTML: text-blue-600
          backgroundColor: const Color(0xFFDBEAFE), // HTML: bg-blue-100
        );
      case DashboardWidgetType.loans:
        return WidgetInfo(
          title: t.dashboard.widgets.loans.title,
          description: t.dashboard.widgets.loans.description,
          icon: Icons.handshake,
          iconColor: const Color(0xFFEA580C), // HTML: text-orange-600
          backgroundColor: const Color(0xFFFED7AA), // HTML: bg-orange-100
        );
      case DashboardWidgetType.transactions:
        return WidgetInfo(
          title: t.dashboard.widgets.transactions.title,
          description: t.dashboard.widgets.transactions.description,
          icon: Icons.receipt_long,
          iconColor: const Color(0xFF64748B), // HTML: text-slate-600
          backgroundColor: const Color(0xFFF1F5F9), // HTML: bg-slate-100
        );
      case DashboardWidgetType.chartAccounts:
        return WidgetInfo(
          title: t.dashboard.widgets.chartAccounts.title,
          description: t.dashboard.widgets.chartAccounts.description,
          icon: Icons.account_tree,
          iconColor: const Color(0xFF9333EA), // HTML: text-purple-600
          backgroundColor: const Color(0xFFF3E8FF), // HTML: bg-purple-100
        );
      case DashboardWidgetType.creditCards:
        return WidgetInfo(
          title: t.dashboard.widgets.creditCards.title,
          description: t.dashboard.widgets.creditCards.description,
          icon: Icons.credit_card,
          iconColor: const Color(0xFFDC2626), // HTML: text-red-600
          backgroundColor: const Color(0xFFFEE2E2), // HTML: bg-red-100
        );
    }
  }
}

/// Información visual de un widget
class WidgetInfo {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const WidgetInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}
