// lib/presentation/interfaces/list_item_interface.dart
abstract class ListItemInterface {
  int get id;
  String get name;
  DateTime get createdAt;
  DateTime? get updatedAt;
}
