import 'package:flutter/material.dart';
import '../molecules/widget_config_item.dart';

/// Lista de widgets con funcionalidad drag & drop
class DraggableWidgetList extends StatefulWidget {
  const DraggableWidgetList({
    Key? key,
    required this.widgets,
    required this.onReorder,
    required this.onToggle,
  }) : super(key: key);

  final List<WidgetConfig> widgets;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(DashboardWidgetType type, bool enabled) onToggle;

  @override
  State<DraggableWidgetList> createState() => _DraggableWidgetListState();
}

class _DraggableWidgetListState extends State<DraggableWidgetList> {
  int? _draggingIndex;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.widgets.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          _draggingIndex = null;
        });
        widget.onReorder(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final config = widget.widgets[index];
        
        return Container(
          key: ValueKey(config.type),
          margin: const EdgeInsets.only(bottom: 12), // HTML: space-y-3
          child: WidgetConfigItem(
            config: config,
            isDragging: _draggingIndex == index,
            onToggle: (enabled) => widget.onToggle(config.type, enabled),
            onDragStart: () {
              setState(() {
                _draggingIndex = index;
              });
            },
            onDragEnd: () {
              setState(() {
                _draggingIndex = null;
              });
            },
          ),
        );
      },
    );
  }
}
