import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/v2_colors.dart';
import '../../../core/l10n/generated/strings.g.dart';

class V2DateSelectionSheet extends StatefulWidget {
  final bool isRange;
  final DateTime? initialDate;
  final DateTimeRange? initialRange;

  const V2DateSelectionSheet({
    super.key,
    this.isRange = false,
    this.initialDate,
    this.initialRange,
  });

  static Future<DateTime?> showSingle(BuildContext context, {DateTime? initialDate}) {
    return showModalBottomSheet<DateTime?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2DateSelectionSheet(
        isRange: false,
        initialDate: initialDate,
      ),
    );
  }

  static Future<DateTimeRange?> showRange(BuildContext context, {DateTimeRange? initialRange}) {
    return showModalBottomSheet<DateTimeRange?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2DateSelectionSheet(
        isRange: true,
        initialRange: initialRange,
      ),
    );
  }

  @override
  State<V2DateSelectionSheet> createState() => _V2DateSelectionSheetState();
}


enum _DateSelectionMode { days, months, years }

class _V2DateSelectionSheetState extends State<V2DateSelectionSheet> {

  DateTime _focusedDay = DateTime.now();
  _DateSelectionMode _currentMode = _DateSelectionMode.days;
  int _selectedYearForMonths = DateTime.now().year;
  
  // Single selection
  DateTime? _selectedDay;
  
  // Range selection
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  void initState() {
    super.initState();
    if (widget.isRange) {
      _currentMode = _DateSelectionMode.months;
      if (widget.initialRange != null) {
        _rangeStart = widget.initialRange!.start;
        _rangeEnd = widget.initialRange!.end;
        _focusedDay = _rangeStart!;
      }
    } else {
      _selectedDay = widget.initialDate ?? DateTime.now();
      _focusedDay = _selectedDay!;
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!widget.isRange) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (widget.isRange) {
      setState(() {
        _selectedDay = null;
        _rangeStart = start;
        _rangeEnd = end;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
      });
    }
  }

  void _onSave() {
    if (widget.isRange) {
      if (_rangeStart != null && _rangeEnd != null) {
        Navigator.pop(context, DateTimeRange(start: _rangeStart!, end: _rangeEnd!));
      } else if (_rangeStart != null) {
        // If only start is selected, use it as single day range
        Navigator.pop(context, DateTimeRange(start: _rangeStart!, end: _rangeStart!));
      } else {
        Navigator.pop(context);
      }
    } else {
      if (_selectedDay != null) {
        Navigator.pop(context, _selectedDay);
      } else {
        Navigator.pop(context);
      }
    }
  }


  void _selectMonthAndPop(int month) {
    final start = DateTime(_selectedYearForMonths, month, 1);
    final end = DateTime(_selectedYearForMonths, month + 1, 0, 23, 59, 59);
    if (widget.isRange) {
      Navigator.pop(context, DateTimeRange(start: start, end: end));
    } else {
      Navigator.pop(context, start);
    }
  }

  void _selectYearAndPop(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31, 23, 59, 59);
    if (widget.isRange) {
      Navigator.pop(context, DateTimeRange(start: start, end: end));
    } else {
      Navigator.pop(context, start);
    }
  }

  Widget _buildModeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: V2Colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          if (widget.isRange) _buildModeTab(t.v2.dateSelection.years, _DateSelectionMode.years),
          if (widget.isRange) _buildModeTab(t.v2.dateSelection.months, _DateSelectionMode.months),
          _buildModeTab(t.v2.dateSelection.days, _DateSelectionMode.days),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, _DateSelectionMode mode) {
    final isSelected = _currentMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? V2Colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : V2Colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthsGrid() {
    final locale = Localizations.localeOf(context).languageCode;

    return Container(
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: V2Colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: V2Colors.onSurface),
                onPressed: () => setState(() => _selectedYearForMonths--),
              ),
              Text(
                '$_selectedYearForMonths',
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: V2Colors.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: V2Colors.onSurface),
                onPressed: () => setState(() => _selectedYearForMonths++),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _selectMonthAndPop(index + 1),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: V2Colors.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    toBeginningOfSentenceCase(DateFormat.MMM(locale).format(DateTime(2000, index + 1))) ?? '',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildYearsGrid() {
    final currentYear = DateTime.now().year;
    // Let's show 9 years: from currentYear - 7 to currentYear + 1
    final years = List.generate(9, (index) => currentYear - 7 + index);

    return Container(
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: V2Colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isCurrent = year == currentYear;
          return InkWell(
            onTap: () => _selectYearAndPop(year),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: isCurrent ? V2Colors.primary.withValues(alpha: 0.1) : V2Colors.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: isCurrent ? Border.all(color: V2Colors.primary.withValues(alpha: 0.5)) : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '$year',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15,
                  fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                  color: isCurrent ? V2Colors.primary : V2Colors.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 48,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isRange ? 'Seleccionar Período' : 'Seleccionar Fecha',
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: V2Colors.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: V2Colors.onSurfaceVariant),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (widget.isRange) ...[
            _buildModeSelector(),
            const SizedBox(height: 24),
          ],
          
          if (_currentMode == _DateSelectionMode.days) ...[
            // Calendar
            Container(
              decoration: BoxDecoration(
                color: V2Colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: V2Colors.outlineVariant.withValues(alpha: 0.2)),
              ),
              padding: const EdgeInsets.all(8),
              child: TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: widget.isRange ? null : (day) => isSameDay(_selectedDay, day),
                rangeStartDay: widget.isRange ? _rangeStart : null,
                rangeEndDay: widget.isRange ? _rangeEnd : null,
                calendarFormat: CalendarFormat.month,
                rangeSelectionMode: widget.isRange ? _rangeSelectionMode : RangeSelectionMode.disabled,
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: V2Colors.onSurface,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: V2Colors.onSurface),
                  rightChevronIcon: Icon(Icons.chevron_right, color: V2Colors.onSurface),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontFamily: 'Manrope', fontSize: 13, color: V2Colors.outline),
                  weekendStyle: TextStyle(fontFamily: 'Manrope', fontSize: 13, color: V2Colors.outline),
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500),
                  weekendTextStyle: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500),
                  todayDecoration: const BoxDecoration(
                    color: V2Colors.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(fontFamily: 'Manrope', color: V2Colors.onSurface, fontWeight: FontWeight.w700),
                  selectedDecoration: const BoxDecoration(
                    color: V2Colors.primary,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(fontFamily: 'Manrope', color: Colors.white, fontWeight: FontWeight.w700),
                  rangeStartDecoration: const BoxDecoration(
                    color: V2Colors.primary,
                    shape: BoxShape.circle,
                  ),
                  rangeEndDecoration: const BoxDecoration(
                    color: V2Colors.primary,
                    shape: BoxShape.circle,
                  ),
                  rangeHighlightColor: V2Colors.primary.withValues(alpha: 0.15),
                  withinRangeTextStyle: const TextStyle(fontFamily: 'Manrope', color: V2Colors.primary, fontWeight: FontWeight.w600),
                  withinRangeDecoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: V2Colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ] else if (_currentMode == _DateSelectionMode.months) ...[
            _buildMonthsGrid(),
            const SizedBox(height: 32),
          ] else if (_currentMode == _DateSelectionMode.years) ...[
            _buildYearsGrid(),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }
}
