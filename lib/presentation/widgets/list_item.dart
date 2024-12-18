// lib/presentation/widgets/list_item.dart
import 'package:flutter/material.dart';
import '../interfaces/list_item_interface.dart';
import '../../domain/entities/category.dart';

class ListItem<T extends ListItemInterface> extends StatelessWidget {
  final T item;
  final Future<void> Function(T) onDelete;
  final Future<void> Function(T) onUpdate;
  final Widget? leading;
  final List<PopupMenuEntry<String>> Function(T)? extraActions;

  const ListItem({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onUpdate,
    this.leading,
    this.extraActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este elemento?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(item),
      child: ListTile(
        leading: leading ?? Icon(
          item is CategoryEntity && (item as CategoryEntity).isMainCategory
              ? Icons.folder
              : Icons.subdirectory_arrow_right,
        ),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item is CategoryEntity)
              Row(
                children: [
                  Icon(
                    (item as CategoryEntity).type == 'I' 
                        ? Icons.arrow_upward 
                        : Icons.arrow_downward,
                    size: 16,
                    color: (item as CategoryEntity).type == 'I' 
                        ? Colors.green 
                        : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (item as CategoryEntity).type == 'I' 
                        ? 'Ingreso' 
                        : 'Egreso',
                    style: TextStyle(
                      color: (item as CategoryEntity).type == 'I' 
                          ? Colors.green 
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            if (item.description != null)
              Text(
                item.description!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                await onUpdate(item);
                break;
              case 'delete':
                if (context.mounted) {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text('¿Estás seguro de que deseas eliminar este elemento?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await onDelete(item);
                  }
                }
                break;
              case 'details':
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(item.name),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item is CategoryEntity)
                            Text('Tipo: ${(item as CategoryEntity).type == 'I' ? 'Ingreso' : 'Egreso'}'),
                          if (item.description != null)
                            Text('Descripción: ${item.description}'),
                          const SizedBox(height: 8),
                          Text('Creado: ${item.createdAt.toString()}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                }
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Eliminar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'details',
              child: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 8),
                  Text('Detalles'),
                ],
              ),
            ),
            if (extraActions != null) ...extraActions!(item),
          ],
        ),
      ),
    );
  }
}