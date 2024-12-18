// lib/presentation/interfaces/list_item_interface.dart
abstract class ListItemInterface {
  int get id;
  String get name;
  String? get description;
  DateTime get createdAt;
}