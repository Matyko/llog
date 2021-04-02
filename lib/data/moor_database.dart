import 'package:llog/data/tables/table_events.dart';
import 'package:llog/data/tables/table_logs.dart';
import 'package:llog/data/tables/table_reminders.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'tables/table_units.dart';

part 'moor_database.g.dart';

@UseMoor(
    tables: [Logs, Events, Units, Reminders],
    daos: [LogDao, EventDao, UnitDao, ReminderDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator migrator) {
        return migrator.createAll();
      });
}

class LogWithEventAndUnit {
  final Log log;
  final Event event;
  final Unit unit;

  LogWithEventAndUnit(
      {@required this.log, @required this.event, @required this.unit});
}

class EventWithUnit {
  final Event event;
  final Unit unit;

  EventWithUnit({@required this.event, @required this.unit});
}

@UseDao(tables: [Logs, Events, Units])
class LogDao extends DatabaseAccessor<AppDatabase> with _$LogDaoMixin {
  final AppDatabase db;

  LogDao(this.db) : super(db);

  Future<List<Log>> getAllLogs() => select(logs).get();

  Stream<List<LogWithEventAndUnit>> watchAllLogs(OrderingMode mode,
      {int eventId}) {
    return (select(logs)
          ..where(eventId != null
              ? (table) => isNull(table.deletedAt) & table.eventId.equals(eventId)
              : (table) => isNull(table.deletedAt))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: mode)]))
        .join([
          leftOuterJoin(events, events.id.equalsExp(logs.eventId)),
          leftOuterJoin(units, units.id.equalsExp(events.unitId))
        ])
        .watch()
        .map((rows) => rows.map((row) {
              return LogWithEventAndUnit(
                  log: row.readTable(logs),
                  event: row.readTable(events),
                  unit: row.readTable(units));
            }).toList());
  }

  Future insertLog(Insertable<Log> log) => into(logs).insert(log);

  Future updateLog(Insertable<Log> log) => update(logs).replace(log);

  Future deleteLog(Insertable<Log> log) => delete(logs).delete(log);
}

@UseDao(tables: [Events, Units])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  final AppDatabase db;

  EventDao(this.db) : super(db);

  Stream<List<EventWithUnit>> watchEvents(OrderingMode mode) {
    return (select(events)
          ..where((table) => isNull(table.deletedAt))
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: mode)]))
        .join([leftOuterJoin(units, units.id.equalsExp(events.unitId))])
        .watch()
        .map((rows) => rows.map((row) {
              return EventWithUnit(
                  event: row.readTable(events), unit: row.readTable(units));
            }).toList());
  }

  Future insertEvent(Insertable<Event> event) => into(events).insert(event);

  Future updateEvent(Insertable<Event> event) => update(events).replace(event);

  Future deleteEvent(Insertable<Event> event) => delete(events).delete(event);
}

@UseDao(tables: [Units])
class UnitDao extends DatabaseAccessor<AppDatabase> with _$UnitDaoMixin {
  final AppDatabase db;

  UnitDao(this.db) : super(db);

  Stream<List<Unit>> watchUnits() =>
      (select(units)..where((table) => isNull(table.deletedAt)))
          .watch();

  Future insertUnit(Insertable<Unit> unit) => into(units).insert(unit);

  Future updateUnit(Insertable<Unit> unit) => update(units).replace(unit);

  Future deleteUnit(Insertable<Unit> unit) => delete(units).delete(unit);
}

@UseDao(tables: [Reminders])
class ReminderDao extends DatabaseAccessor<AppDatabase>
    with _$ReminderDaoMixin {
  final AppDatabase db;

  ReminderDao(this.db) : super(db);

  Stream<List<Reminder>> watchReminders() =>
      (select(reminders)..where((table) => isNull(table.deletedAt)))
          .watch();

  Future insertReminder(Insertable<Reminder> reminder) =>
      into(reminders).insert(reminder);

  Future updateReminder(Insertable<Reminder> reminder) =>
      update(reminders).replace(reminder);

  Future deleteReminder(Insertable<Reminder> reminder) =>
      delete(reminders).delete(reminder);
}
