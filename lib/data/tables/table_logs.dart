import 'package:moor_flutter/moor_flutter.dart';

class Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get value => real().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get eventId =>
      integer().customConstraint('REFERENCES events(id)')();
}
