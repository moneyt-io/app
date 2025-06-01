import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JournalFilterSection extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? documentType;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;
  final Function(String?) onDocumentTypeChanged;

  const JournalFilterSection({
    Key? key, 
    this.startDate,
    this.endDate,
    this.documentType,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onDocumentTypeChanged,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime now = DateTime.now();
    final initialDate = isStartDate 
        ? startDate ?? DateTime(now.year, now.month, 1) 
        : endDate ?? now;
        
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12, 31),
    );
    
    if (pickedDate != null) {
      if (isStartDate) {
        onStartDateChanged(pickedDate);
      } else {
        onEndDateChanged(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    context, 
                    'Desde', 
                    true, 
                    startDate,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDateSelector(
                    context, 
                    'Hasta', 
                    false, 
                    endDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTypeFilter(context),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    onStartDateChanged(null);
                    onEndDateChanged(null);
                    onDocumentTypeChanged(null);
                  },
                  child: const Text('Limpiar Filtros'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context, 
    String label, 
    bool isStartDate, 
    DateTime? selectedDate,
  ) {
    final dateFormatted = selectedDate != null 
        ? DateFormat('dd/MM/yyyy').format(selectedDate) 
        : 'Seleccionar';
        
    return InkWell(
      onTap: () => _selectDate(context, isStartDate),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateFormatted,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Icon(Icons.calendar_today, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeFilter(BuildContext context) {
    return DropdownButtonFormField<String?>(
      decoration: InputDecoration(
        labelText: 'Tipo de Documento',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8,
        ),
      ),
      value: documentType,
      items: const [
        DropdownMenuItem(
          value: null,
          child: Text('Todos'),
        ),
        DropdownMenuItem(
          value: 'I',
          child: Text('Ingreso'),
        ),
        DropdownMenuItem(
          value: 'E',
          child: Text('Gasto'),
        ),
        DropdownMenuItem(
          value: 'T',
          child: Text('Transferencia'),
        ),
        DropdownMenuItem(
          value: 'L',
          child: Text('Préstamo Otorgado'),
        ),
        DropdownMenuItem(
          value: 'B',
          child: Text('Préstamo Recibido'),
        ),
      ],
      onChanged: onDocumentTypeChanged,
    );
  }
}
