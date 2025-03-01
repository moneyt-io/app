import 'package:injectable/injectable.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/journal_detail.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/local/daos/journal_dao.dart';
import '../models/journal_entry_model.dart';
import '../models/journal_detail_model.dart';

@Injectable(as: JournalRepository)
class JournalRepositoryImpl implements JournalRepository {
  final JournalDao _dao;

  JournalRepositoryImpl(this._dao);

  @override
  Future<List<JournalEntry>> getAllJournalEntries() async {
    final entries = await _dao.getAllJournalEntries();
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getJournalDetailsForEntry(entry.id);
      return JournalEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        secuencial: entry.secuencial,
        date: entry.date,
        description: entry.description,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => JournalDetailModel(
          id: detail.id,
          journalId: detail.journalId,
          currencyId: detail.currencyId,
          chartAccountId: detail.chartAccountId,
          credit: detail.credit,
          debit: detail.debit,
          rateExchange: detail.rateExchange,
        )).toList(),
      );
    }));
  }

  @override
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details) async {
    final model = JournalEntryModel.fromEntity(entry);
    final id = await _dao.insertJournalEntry(model.toCompanion());
    
    final detailModels = details.map((detail) => JournalDetailModel(
      id: 0,
      journalId: id,
      currencyId: detail.currencyId,
      chartAccountId: detail.chartAccountId,
      credit: detail.credit,
      debit: detail.debit,
      rateExchange: detail.rateExchange,
    )).toList();
    
    await _dao.insertJournalDetails(detailModels.map((m) => m.toCompanion()).toList());
    
    final createdEntry = await getJournalEntryById(id);
    if (createdEntry == null) {
      throw Exception('Failed to create journal entry');
    }
    return createdEntry;
  }

  @override 
  Future<JournalEntry?> getJournalEntryById(int id) async {
    final entry = await _dao.getJournalEntryById(id);
    if (entry == null) return null;

    final details = await _dao.getJournalDetailsForEntry(entry.id);
    return JournalEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      secuencial: entry.secuencial,
      date: entry.date,
      description: entry.description,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    ).toEntity(
      details: details.map((detail) => JournalDetailModel(
        id: detail.id,
        journalId: detail.journalId,
        currencyId: detail.currencyId,
        chartAccountId: detail.chartAccountId,
        credit: detail.credit,
        debit: detail.debit,
        rateExchange: detail.rateExchange,
      )).toList(),
    );
  }

  @override
  Stream<List<JournalEntry>> watchAllJournalEntries() {
    return _dao.watchAllJournalEntries().asyncMap((entries) async {
      return Future.wait(entries.map((entry) async {
        final details = await _dao.getJournalDetailsForEntry(entry.id);
        return JournalEntryModel(
          id: entry.id,
          documentTypeId: entry.documentTypeId,
          secuencial: entry.secuencial,
          date: entry.date,
          description: entry.description,
          active: entry.active,
          createdAt: entry.createdAt,
          updatedAt: entry.updatedAt,
          deletedAt: entry.deletedAt,
        ).toEntity(
          details: details.map((detail) => JournalDetailModel(
            id: detail.id,
            journalId: detail.journalId,
            currencyId: detail.currencyId,
            chartAccountId: detail.chartAccountId,
            credit: detail.credit,
            debit: detail.debit,
            rateExchange: detail.rateExchange,
          )).toList(),
        );
      }));
    });
  }

  @override
  Future<void> updateJournalEntry(JournalEntry entry) async {
    final model = JournalEntryModel.fromEntity(entry);
    await _dao.updateJournalEntry(model.toCompanion());
  }

  @override
  Future<void> deleteJournalEntry(int id) async {
    await _dao.deleteJournalDetails(id); // Primero borramos los detalles
    await _dao.deleteJournalEntry(id);   // Luego borramos la entrada principal
  }

  // ...otros métodos del contrato...
}
