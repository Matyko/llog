import 'dart:convert';

import 'package:moor_flutter/moor_flutter.dart';

class Days {
  static const MONDAY = 'MONDAY';
  static const TUESDAY = 'TUESDAY';
  static const WEDNESDAY = 'WEDNESDAY';
  static const THURSDAY = 'THURSDAY';
  static const FRIDAY = 'FRIDAY';
  static const SATURDAY = 'SATURDAY';
  static const SUNDAY = 'SUNDAY';
}

class StringListConverter extends TypeConverter<List, String> {
  const StringListConverter();

  List<String> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return jsonDecode(fromDb) as List<String>;
  }

  String mapToSql(List list) {
    if (list == null) {
      return null;
    }
    return json.encode(list);
  }
}

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get notificationId => integer()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get days => text().map(StringListConverter()).nullable()();
  IntColumn get eventId =>
      integer().customConstraint('REFERENCES events(id)')();
}
