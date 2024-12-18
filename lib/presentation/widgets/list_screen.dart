// lib/presentation/widgets/list_screen.dart
import 'package:flutter/material.dart';
import '../interfaces/list_item_interface.dart';

class ListScreen<T extends ListItemInterface> extends StatelessWidget {
  final String title;
  final Stream<List<T>> itemsStream;
  final Widget Function(T item) itemBuilder;
  final Future<void> Function(T item) onDelete;
  final Future<void> Function(T item) onUpdate;
  final VoidCallback onAdd;
  final Widget? drawer;
  final List<Widget>? actions;

  const ListScreen({
    Key? key,
    required this.title,
    required this.itemsStream,
    required this.itemBuilder,
    required this.onDelete,
    required this.onUpdate,
    required this.onAdd,
    this.drawer,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      drawer: drawer,
      body: StreamBuilder<List<T>>(
        stream: itemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final items = snapshot.data ?? [];
          
          if (items.isEmpty) {
            return Center(
              child: Text('No hay ${title.toLowerCase()} disponibles'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}