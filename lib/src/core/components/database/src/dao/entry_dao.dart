import 'package:drift/drift.dart';
import 'package:my_budget/src/core/components/database/database.dart';
import 'package:my_budget/src/feature/add_entry/model/entry.dart';

class EntryDao {
  final AppDatabase db;
  EntryDao(this.db);

  Future<List<Entry>> getAllEntries() async {
    var result = await db.entryTable.select().get();
    return result
        .map((e) => Entry(
            place: e.place,
            categoryIcon: e.categoryIcon,
            categoryTitle: e.categoryTitle,
            dateTime: e.date,
            note: e.note,
            amount: e.amount))
        .toList();
  }

  Future<int> insert(EntryTableCompanion entry) async =>
      db.entryTable.insert().insert(entry);
}
