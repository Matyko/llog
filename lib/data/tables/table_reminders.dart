import 'package:moor_flutter/moor_flutter.dart';

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get notificationId => integer()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get eventId =>
      integer().customConstraint('REFERENCES events(id)')();
}
