import 'package:flutter/material.dart';

import '../../../core/molecules/form_action_bar.dart';

// TODO: This should be moved to a shared theme file
const Color _primaryBlue = Color(0xFF0C7FF2);
const Color _slate50 = Color(0xFFF8FAFC);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate500 = Color(0xFF64748B);
const Color _slate600 = Color(0xFF475569);
const Color _slate800 = Color(0xFF1E293B);

class SelectableCategory {
  final String id;
  final String name;
  final String? parentId;
  final bool isIncome;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  SelectableCategory({
    required this.id,
    required this.name,
    this.parentId,
    required this.isIncome,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

class CategorySelectionDialog extends StatefulWidget {
  final List<SelectableCategory> categories;
  final SelectableCategory? initialSelection;

  const CategorySelectionDialog({
    super.key,
    required this.categories,
    this.initialSelection,
  });

  static Future<SelectableCategory?> show(
    BuildContext context, {
    required List<SelectableCategory> categories,
    SelectableCategory? initialSelection,
  }) {
    return showModalBottomSheet<SelectableCategory?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CategorySelectionDialog(
        categories: categories,
        initialSelection: initialSelection,
      ),
    );
  }

  @override
  State<CategorySelectionDialog> createState() => _CategorySelectionDialogState();
}

class _CategorySelectionDialogState extends State<CategorySelectionDialog> {
  final _searchController = TextEditingController();
  late SelectableCategory? _selectedCategory;
  List<SelectableCategory> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialSelection;
    _filteredCategories = widget.categories;
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = widget.categories.where((category) {
        return category.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      color: _slate300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Select category',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _slate800)),
                    SizedBox(height: 4),
                    Text('Choose a category for this transaction',
                        style: TextStyle(fontSize: 14, color: _slate500)),
                  ],
                ),
              ),
              const Divider(height: 1, color: _slate100),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search categories',
                    hintStyle: const TextStyle(color: _slate500),
                    prefixIcon: const Icon(Icons.search, color: _slate500),
                    filled: true,
                    fillColor: _slate100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _slate200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _slate200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: _primaryBlue, width: 1.5),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: _slate100),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: _buildCategoryList(),
                ),
              ),
              FormActionBar(
                onCancel: () => Navigator.of(context).pop(),
                onSave: () => Navigator.of(context).pop(_selectedCategory),
                saveText: 'Select',
                enabled: _selectedCategory != null,
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildCategoryList() {
    final List<Widget> listItems = [];
    final categories = _filteredCategories;

    final childrenByParentId = <String, List<SelectableCategory>>{};
    categories.where((c) => c.parentId != null).forEach((child) {
      childrenByParentId.putIfAbsent(child.parentId!, () => []).add(child);
    });

    final rootCategories = categories.where((c) => c.parentId == null).toList();

    for (final rootCategory in rootCategories) {
      final children = childrenByParentId[rootCategory.id] ?? [];
      final isParent = children.isNotEmpty;

      if (isParent) {
        listItems.add(_buildSectionHeader(rootCategory.name));
        for (final child in children) {
          listItems.add(Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _CategoryListItem(
              category: child,
              isSelected: _selectedCategory?.id == child.id,
              onTap: () => setState(() => _selectedCategory = child),
            ),
          ));
        }
      } else {
        listItems.add(_CategoryListItem(
          category: rootCategory,
          isSelected: _selectedCategory?.id == rootCategory.id,
          onTap: () => setState(() => _selectedCategory = rootCategory),
        ));
      }
    }

    return listItems;
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _slate50,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _slate600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CategoryListItem extends StatelessWidget {
  final SelectableCategory category;
  final bool isSelected;
  final VoidCallback? onTap;

  const _CategoryListItem({
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _slate200)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: category.iconBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(category.icon, color: category.iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _slate800)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (isSelected)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: _primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: _primaryBlue, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              )
            else
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _slate300, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
