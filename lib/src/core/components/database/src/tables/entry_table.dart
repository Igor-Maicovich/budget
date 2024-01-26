// ignore_for_file: prefer-declaring-const-constructor
import 'package:drift/drift.dart';

/// Todos table definition
class EntryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get amount => integer()();

  TextColumn get place => text()();

  TextColumn get note => text()();

  TextColumn get categoryTitle => text().named('category_title')();

  TextColumn get categoryIcon => text().named('category_icon')();

  DateTimeColumn get date => dateTime()();
}
