import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/journal_table.dart';
import '../tables/journal_details_table.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [Journal, JournalDetails])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(AppDatabase db) : super(db);

  // Consultas básicas para Journal
  Future<List<JournalData>> getAllJournals() => select(journal).get();
  Stream<List<JournalData>> watchAllJournals() => select(journal).watch();
  Future<JournalData> getJournalById(int id) =>
      (select(journal)..where((j) => j.id.equals(id))).getSingle();

  // Operaciones CRUD para Journal sin usar Companions
  Future<int> createJournal({
    required int documentTypeId,
    required DateTime date,
    String? description,
    bool active = true,
  }) {
    return customInsert(
      'INSERT INTO journal (document_type_id, date, description, active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)',
      variables: [
        Variable.withInt(documentTypeId),
        Variable.withDateTime(date),
        Variable.withString(description ?? ''),
        Variable.withBool(active),
        Variable.withDateTime(DateTime.now()),
        Variable.withDateTime(DateTime.now()),
      ],
    );
  }

  Future<bool> updateJournal({
    required int id,
    int? documentTypeId,
    DateTime? date,
    String? description,
    bool? active,
  }) async {
    final updates = <String, dynamic>{};
    if (documentTypeId != null) updates['document_type_id'] = documentTypeId;
    if (date != null) updates['date'] = date;
    if (description != null) updates['description'] = description;
    if (active != null) updates['active'] = active;
    updates['updated_at'] = DateTime.now();

    final setClause = updates.keys.map((key) => '$key = ?').join(', ');
    final variables = [...updates.values.map((v) => Variable(v)), Variable(id)];

    final result = await customUpdate(
      'UPDATE journal SET $setClause WHERE id = ?',
      variables: variables,
      updates: {journal},
    );
    return result > 0;
  }

  Future<int> deleteJournal(int id) =>
      (delete(journal)..where((j) => j.id.equals(id))).go();

  // Operaciones para JournalDetails sin usar Companions
  Future<int> createJournalDetail({
    required int journalId,
    required int chartAccountId,
    required double credit,
    required double debit,
  }) {
    return customInsert(
      'INSERT INTO journal_details (journal_id, chart_account_id, credit, debit) VALUES (?, ?, ?, ?)',
      variables: [
        Variable.withInt(journalId),
        Variable.withInt(chartAccountId),
        Variable.withReal(credit),
        Variable.withReal(debit),
      ],
    );
  }

  Future<bool> updateJournalDetail({
    required int id,
    required int journalId,
    required int chartAccountId,
    required double credit,
    required double debit,
  }) async {
    final updates = <String, dynamic>{
      'journal_id': journalId,
      'chart_account_id': chartAccountId,
      'credit': credit,
      'debit': debit,
      'updated_at': DateTime.now(),
    };

    final setClause = updates.keys.map((key) => '$key = ?').join(', ');
    final variables = [...updates.values.map((v) => Variable(v)), Variable(id)];

    final result = await customUpdate(
      'UPDATE journal_details SET $setClause WHERE id = ?',
      variables: variables,
      updates: {journalDetails},
    );
    return result > 0;
  }

  Future<int> deleteJournalDetail(int id) =>
      (delete(journalDetails)..where((jd) => jd.id.equals(id))).go();

  // Métodos de consulta para JournalDetails
  Future<List<JournalDetail>> getJournalDetailsByJournalId(int journalId) =>
      (select(journalDetails)..where((jd) => jd.journalId.equals(journalId))).get();

  Stream<List<JournalDetail>> watchJournalDetailsByJournalId(int journalId) =>
      (select(journalDetails)..where((jd) => jd.journalId.equals(journalId))).watch();

  // Método para crear un journal completo con sus detalles
  Future<int> createCompleteJournal({
    required int documentTypeId,
    required DateTime date,
    String? description,
    required List<JournalDetailInput> details,
  }) async {
    return transaction(() async {
      // Crear el journal usando SQL directo
      final journalId = await createJournal(
        documentTypeId: documentTypeId,
        date: date,
        description: description,
      );

      // Crear los detalles usando SQL directo
      for (final detail in details) {
        await createJournalDetail(
          journalId: journalId,
          chartAccountId: detail.chartAccountId,
          credit: detail.credit,
          debit: detail.debit,
        );
      }

      return journalId;
    });
  }
}

// Clase auxiliar para crear detalles del journal
class JournalDetailInput {
  final int chartAccountId;
  final double credit;
  final double debit;

  JournalDetailInput({
    required this.chartAccountId,
    required this.credit,
    required this.debit,
  });
}
