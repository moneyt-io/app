import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'form_action_bar.dart';
import 'package:table_calendar/table_calendar.dart';

// HTML Color Palette
const Color _primaryBlue = Color(0xFF0C7FF2);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate500 = Color(0xFF64748B);
const Color _slate600 = Color(0xFF475569);
const Color _slate700 = Color(0xFF334155);
const Color _slate900 = Color(0xFF0F172A);

class DateSelectionDialog {
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DateDialog(initialDate: initialDate),
    );
  }
}

class _DateDialog extends StatefulWidget {
  final DateTime initialDate;

  const _DateDialog({Key? key, required this.initialDate}) : super(key: key);

  @override
  State<_DateDialog> createState() => _DateDialogState();
}

class _DateDialogState extends State<_DateDialog> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusedDate = widget.initialDate;
  }

  void _selectQuickDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _focusedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _slate300,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select date',
                      style: TextStyle(
                          color: _slate900,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  const Text('Choose transaction date',
                      style: TextStyle(color: _slate500, fontSize: 14)),
                ],
              ),
            ),
            const Divider(color: _slate100, height: 1),
            _buildQuickDateOptions(),
            const Divider(color: _slate100, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildCalendar(),
            ),
            const Divider(color: _slate100, height: 1),
            _buildSelectedDateDisplay(),
            FormActionBar(
              onCancel: () => Navigator.of(context).pop(),
              onSave: () => Navigator.of(context).pop(_selectedDate),
              saveText: 'Seleccionar',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDateOptions() {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
              child: _QuickDateButton(
                  label: 'Today',
                  date: today,
                  selectedDate: _selectedDate,
                  onSelect: _selectQuickDate)),
          const SizedBox(width: 8),
          Expanded(
              child: _QuickDateButton(
                  label: 'Yesterday',
                  date: yesterday,
                  selectedDate: _selectedDate,
                  onSelect: _selectQuickDate)),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _focusedDate = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDate = focusedDay;
        });
      },
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
            color: _slate900, fontSize: 16, fontWeight: FontWeight.w600),
        leftChevronIcon: Icon(Icons.chevron_left, color: _slate600),
        rightChevronIcon: Icon(Icons.chevron_right, color: _slate600),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);
          return Center(
            child: Text(text,
                style: const TextStyle(
                    color: _slate500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(day.day.toString(),
                style: const TextStyle(color: _slate700, fontSize: 14)),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(day.day.toString(),
                style: const TextStyle(color: _slate300, fontSize: 14)),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSameDay(day, _selectedDate) ? _primaryBlue : _slate100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                    color: isSameDay(day, _selectedDate)
                        ? Colors.white
                        : _slate700,
                    fontSize: 14),
              ),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedDateDisplay() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF), // blue-50
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                  color: Color(0xFFDBEAFE), shape: BoxShape.circle), // blue-100
              child: const Icon(Icons.calendar_today,
                  color: Color(0xFF2563EB), size: 20), // blue-600
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selected Date',
                    style: TextStyle(
                        color: Color(0xFF1E40AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600)), // blue-800
                Text(
                  DateFormat.yMMMMEEEEd('en_US').format(_selectedDate),
                  style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 16,
                      fontWeight: FontWeight.bold), // blue-700
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickDateButton extends StatelessWidget {
  final String label;
  final DateTime date;
  final DateTime selectedDate;
  final Function(DateTime) onSelect;

  const _QuickDateButton(
      {required this.label,
      required this.date,
      required this.selectedDate,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final bool isActive = isSameDay(date, selectedDate);
    return SizedBox(
      height: 32,
      child: TextButton(
        onPressed: () => onSelect(date),
        style: TextButton.styleFrom(
          backgroundColor:
              isActive ? const Color(0xFF0C7FF2).withOpacity(0.1) : _slate100,
          foregroundColor: isActive ? const Color(0xFF1D4ED8) : _slate600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: isActive ? const Color(0xFFBFDBFE) : _slate200),
          ),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
