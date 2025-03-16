import 'package:flutter/material.dart';
import '../../domain/entities/chart_account.dart';
import '../molecules/chart_account_list_item.dart';

class ChartAccountTreeView extends StatefulWidget {
  final List<ChartAccount> accounts;
  final Function(ChartAccount) onAccountTap;
  final Function(ChartAccount)? onAccountDelete;
  
  const ChartAccountTreeView({
    Key? key,
    required this.accounts,
    required this.onAccountTap,
    this.onAccountDelete,
  }) : super(key: key);

  @override
  State<ChartAccountTreeView> createState() => _ChartAccountTreeViewState();
}

class _ChartAccountTreeViewState extends State<ChartAccountTreeView> {
  // Mapa para rastrear qué nodos están expandidos
  final Map<int, bool> _expandedState = {};

  @override
  Widget build(BuildContext context) {
    // Organizar las cuentas en una estructura de árbol
    final rootAccounts = widget.accounts.where((account) => account.isRootAccount).toList()
      ..sort((a, b) => a.code.compareTo(b.code));
    
    return ListView.builder(
      itemCount: rootAccounts.length,
      itemBuilder: (context, index) {
        final rootAccount = rootAccounts[index];
        return _buildAccountTreeItem(rootAccount, 0);
      },
    );
  }
  
  // Construye un ítem del árbol y sus hijos recursivamente
  Widget _buildAccountTreeItem(ChartAccount account, int level) {
    // Encontrar los hijos de esta cuenta
    final children = widget.accounts
        .where((a) => a.parentId == account.id)
        .toList()
      ..sort((a, b) => a.code.compareTo(b.code));
    
    final hasChildren = children.isNotEmpty;
    final isExpanded = _expandedState[account.id] ?? false;
    
    return Column(
      children: [
        // El ítem actual
        InkWell(
          onTap: hasChildren 
            ? () => setState(() => _expandedState[account.id] = !isExpanded)
            : null,
          child: Row(
            children: [
              if (hasChildren)
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  ),
                  onPressed: () {
                    setState(() {
                      _expandedState[account.id] = !isExpanded;
                    });
                  },
                ),
              Expanded(
                child: ChartAccountListItem(
                  account: account,
                  indentation: level,
                  onTap: () => widget.onAccountTap(account),
                  onDelete: widget.onAccountDelete != null 
                    ? () => widget.onAccountDelete!(account)
                    : null,
                ),
              ),
            ],
          ),
        ),
        
        // Los hijos, si está expandido
        if (hasChildren && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: children.map((child) => _buildAccountTreeItem(child, level + 1)).toList(),
            ),
          ),
      ],
    );
  }
}
