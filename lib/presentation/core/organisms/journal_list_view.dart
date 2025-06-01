import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/journal_entry.dart';
import '../molecules/journal_list_item.dart';
import '../theme/app_dimensions.dart';

class JournalListView extends StatefulWidget {
  final List<JournalEntry> journals;
  final Function(JournalEntry) onJournalTap;

  const JournalListView({
    Key? key,
    required this.journals,
    required this.onJournalTap,
  }) : super(key: key);

  @override
  State<JournalListView> createState() => _JournalListViewState();
}

class _JournalListViewState extends State<JournalListView> {
  // Agrupar diarios por fecha
  Map<String, List<JournalEntry>> _groupJournalsByDate() {
    final Map<String, List<JournalEntry>> groupedJournals = {};
    
    for (final journal in widget.journals) {
      final dateKey = DateFormat('yyyy-MM-dd').format(journal.date);
      
      if (!groupedJournals.containsKey(dateKey)) {
        groupedJournals[dateKey] = [];
      }
      
      groupedJournals[dateKey]!.add(journal);
    }
    
    return groupedJournals;
  }

  @override
  Widget build(BuildContext context) {
    final groupedJournals = _groupJournalsByDate();
    final dateKeys = groupedJournals.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Ordenar por fecha descendente
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
      itemCount: dateKeys.length,
      itemBuilder: (context, index) {
        final dateKey = dateKeys[index];
        final journalsForDate = groupedJournals[dateKey]!;
        final displayDate = DateFormat('EEEE, d MMMM yyyy', 'es_ES')
          .format(DateTime.parse(dateKey));
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.spacing8, 
                horizontal: AppDimensions.spacing4
              ),
              child: Text(
                displayDate,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ...journalsForDate.map((journal) => JournalListItem(
              journal: journal,
              onTap: () => widget.onJournalTap(journal),
            )),
          ],
        );
      },
    );
  }
}
