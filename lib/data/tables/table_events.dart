import 'package:moor_flutter/moor_flutter.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get showSum => boolean()();
  BoolColumn get showChange => boolean()();
  BoolColumn get isFavourite => boolean()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 0, max: 250).nullable()();
  IntColumn get unitId => integer().nullable()();
}
