import 'package:drift/drift.dart';
import 'package:my_budget/src/core/components/database/database.dart';
import 'package:my_budget/src/core/components/database/src/tables/entry_table.dart';

part 'app_database.g.dart';

/// {@template app_database}
/// The drift-managed database configuration
/// {@endtemplate}
@DriftDatabase(tables: [EntryTable])
class AppDatabase extends _$AppDatabase {
  /// {@macro app_database}
  AppDatabase([QueryExecutor? executor]) : super(executor ?? createExecutor());

  @override
  int get schemaVersion => 1;
}
