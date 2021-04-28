// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Log extends DataClass implements Insertable<Log> {
  final int id;
  final double value;
  final DateTime date;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime deletedAt;
  final int eventId;
  Log(
      {@required this.id,
      @required this.value,
      @required this.date,
      @required this.createdAt,
      @required this.modifiedAt,
      this.deletedAt,
      @required this.eventId});
  factory Log.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Log(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      deletedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_at']),
      eventId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<DateTime>(modifiedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<int>(eventId);
    }
    return map;
  }

  LogsCompanion toCompanion(bool nullToAbsent) {
    return LogsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
    );
  }

  factory Log.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Log(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<double>(json['value']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      eventId: serializer.fromJson<int>(json['eventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<double>(value),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'eventId': serializer.toJson<int>(eventId),
    };
  }

  Log copyWith(
          {int id,
          double value,
          DateTime date,
          DateTime createdAt,
          DateTime modifiedAt,
          DateTime deletedAt,
          int eventId}) =>
      Log(
        id: id ?? this.id,
        value: value ?? this.value,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        eventId: eventId ?? this.eventId,
      );
  @override
  String toString() {
    return (StringBuffer('Log(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          value.hashCode,
          $mrjc(
              date.hashCode,
              $mrjc(
                  createdAt.hashCode,
                  $mrjc(modifiedAt.hashCode,
                      $mrjc(deletedAt.hashCode, eventId.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Log &&
          other.id == this.id &&
          other.value == this.value &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.deletedAt == this.deletedAt &&
          other.eventId == this.eventId);
}

class LogsCompanion extends UpdateCompanion<Log> {
  final Value<int> id;
  final Value<double> value;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<DateTime> deletedAt;
  final Value<int> eventId;
  const LogsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.eventId = const Value.absent(),
  });
  LogsCompanion.insert({
    this.id = const Value.absent(),
    @required double value,
    @required DateTime date,
    @required DateTime createdAt,
    @required DateTime modifiedAt,
    this.deletedAt = const Value.absent(),
    @required int eventId,
  })  : value = Value(value),
        date = Value(date),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        eventId = Value(eventId);
  static Insertable<Log> custom({
    Expression<int> id,
    Expression<double> value,
    Expression<DateTime> date,
    Expression<DateTime> createdAt,
    Expression<DateTime> modifiedAt,
    Expression<DateTime> deletedAt,
    Expression<int> eventId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (eventId != null) 'event_id': eventId,
    });
  }

  LogsCompanion copyWith(
      {Value<int> id,
      Value<double> value,
      Value<DateTime> date,
      Value<DateTime> createdAt,
      Value<DateTime> modifiedAt,
      Value<DateTime> deletedAt,
      Value<int> eventId}) {
    return LogsCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      eventId: eventId ?? this.eventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }
}

class $LogsTable extends Logs with TableInfo<$LogsTable, Log> {
  final GeneratedDatabase _db;
  final String _alias;
  $LogsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedDateTimeColumn _modifiedAt;
  @override
  GeneratedDateTimeColumn get modifiedAt =>
      _modifiedAt ??= _constructModifiedAt();
  GeneratedDateTimeColumn _constructModifiedAt() {
    return GeneratedDateTimeColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  GeneratedDateTimeColumn _deletedAt;
  @override
  GeneratedDateTimeColumn get deletedAt => _deletedAt ??= _constructDeletedAt();
  GeneratedDateTimeColumn _constructDeletedAt() {
    return GeneratedDateTimeColumn(
      'deleted_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedIntColumn _eventId;
  @override
  GeneratedIntColumn get eventId => _eventId ??= _constructEventId();
  GeneratedIntColumn _constructEventId() {
    return GeneratedIntColumn('event_id', $tableName, false,
        $customConstraints: 'REFERENCES events(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, value, date, createdAt, modifiedAt, deletedAt, eventId];
  @override
  $LogsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'logs';
  @override
  final String actualTableName = 'logs';
  @override
  VerificationContext validateIntegrity(Insertable<Log> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at'], _deletedAtMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Log map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Log.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $LogsTable createAlias(String alias) {
    return $LogsTable(_db, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime deletedAt;
  final bool showSum;
  final bool showChange;
  final String name;
  final String description;
  final int unitId;
  Event(
      {@required this.id,
      @required this.createdAt,
      @required this.modifiedAt,
      this.deletedAt,
      @required this.showSum,
      @required this.showChange,
      @required this.name,
      this.description,
      this.unitId});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    final stringType = db.typeSystem.forDartType<String>();
    return Event(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      deletedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_at']),
      showSum:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}show_sum']),
      showChange: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}show_change']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      unitId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}unit_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<DateTime>(modifiedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || showSum != null) {
      map['show_sum'] = Variable<bool>(showSum);
    }
    if (!nullToAbsent || showChange != null) {
      map['show_change'] = Variable<bool>(showChange);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<int>(unitId);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      showSum: showSum == null && nullToAbsent
          ? const Value.absent()
          : Value(showSum),
      showChange: showChange == null && nullToAbsent
          ? const Value.absent()
          : Value(showChange),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      unitId:
          unitId == null && nullToAbsent ? const Value.absent() : Value(unitId),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      showSum: serializer.fromJson<bool>(json['showSum']),
      showChange: serializer.fromJson<bool>(json['showChange']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      unitId: serializer.fromJson<int>(json['unitId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'showSum': serializer.toJson<bool>(showSum),
      'showChange': serializer.toJson<bool>(showChange),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'unitId': serializer.toJson<int>(unitId),
    };
  }

  Event copyWith(
          {int id,
          DateTime createdAt,
          DateTime modifiedAt,
          DateTime deletedAt,
          bool showSum,
          bool showChange,
          String name,
          String description,
          int unitId}) =>
      Event(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        showSum: showSum ?? this.showSum,
        showChange: showChange ?? this.showChange,
        name: name ?? this.name,
        description: description ?? this.description,
        unitId: unitId ?? this.unitId,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('showSum: $showSum, ')
          ..write('showChange: $showChange, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          createdAt.hashCode,
          $mrjc(
              modifiedAt.hashCode,
              $mrjc(
                  deletedAt.hashCode,
                  $mrjc(
                      showSum.hashCode,
                      $mrjc(
                          showChange.hashCode,
                          $mrjc(
                              name.hashCode,
                              $mrjc(description.hashCode,
                                  unitId.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.deletedAt == this.deletedAt &&
          other.showSum == this.showSum &&
          other.showChange == this.showChange &&
          other.name == this.name &&
          other.description == this.description &&
          other.unitId == this.unitId);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<DateTime> deletedAt;
  final Value<bool> showSum;
  final Value<bool> showChange;
  final Value<String> name;
  final Value<String> description;
  final Value<int> unitId;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.showSum = const Value.absent(),
    this.showChange = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.unitId = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime createdAt,
    @required DateTime modifiedAt,
    this.deletedAt = const Value.absent(),
    @required bool showSum,
    @required bool showChange,
    @required String name,
    this.description = const Value.absent(),
    this.unitId = const Value.absent(),
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        showSum = Value(showSum),
        showChange = Value(showChange),
        name = Value(name);
  static Insertable<Event> custom({
    Expression<int> id,
    Expression<DateTime> createdAt,
    Expression<DateTime> modifiedAt,
    Expression<DateTime> deletedAt,
    Expression<bool> showSum,
    Expression<bool> showChange,
    Expression<String> name,
    Expression<String> description,
    Expression<int> unitId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (showSum != null) 'show_sum': showSum,
      if (showChange != null) 'show_change': showChange,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (unitId != null) 'unit_id': unitId,
    });
  }

  EventsCompanion copyWith(
      {Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime> modifiedAt,
      Value<DateTime> deletedAt,
      Value<bool> showSum,
      Value<bool> showChange,
      Value<String> name,
      Value<String> description,
      Value<int> unitId}) {
    return EventsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      showSum: showSum ?? this.showSum,
      showChange: showChange ?? this.showChange,
      name: name ?? this.name,
      description: description ?? this.description,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (showSum.present) {
      map['show_sum'] = Variable<bool>(showSum.value);
    }
    if (showChange.present) {
      map['show_change'] = Variable<bool>(showChange.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('showSum: $showSum, ')
          ..write('showChange: $showChange, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedDateTimeColumn _modifiedAt;
  @override
  GeneratedDateTimeColumn get modifiedAt =>
      _modifiedAt ??= _constructModifiedAt();
  GeneratedDateTimeColumn _constructModifiedAt() {
    return GeneratedDateTimeColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  GeneratedDateTimeColumn _deletedAt;
  @override
  GeneratedDateTimeColumn get deletedAt => _deletedAt ??= _constructDeletedAt();
  GeneratedDateTimeColumn _constructDeletedAt() {
    return GeneratedDateTimeColumn(
      'deleted_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _showSumMeta = const VerificationMeta('showSum');
  GeneratedBoolColumn _showSum;
  @override
  GeneratedBoolColumn get showSum => _showSum ??= _constructShowSum();
  GeneratedBoolColumn _constructShowSum() {
    return GeneratedBoolColumn(
      'show_sum',
      $tableName,
      false,
    );
  }

  final VerificationMeta _showChangeMeta = const VerificationMeta('showChange');
  GeneratedBoolColumn _showChange;
  @override
  GeneratedBoolColumn get showChange => _showChange ??= _constructShowChange();
  GeneratedBoolColumn _constructShowChange() {
    return GeneratedBoolColumn(
      'show_change',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 0, maxTextLength: 250);
  }

  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  GeneratedIntColumn _unitId;
  @override
  GeneratedIntColumn get unitId => _unitId ??= _constructUnitId();
  GeneratedIntColumn _constructUnitId() {
    return GeneratedIntColumn(
      'unit_id',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        modifiedAt,
        deletedAt,
        showSum,
        showChange,
        name,
        description,
        unitId
      ];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at'], _deletedAtMeta));
    }
    if (data.containsKey('show_sum')) {
      context.handle(_showSumMeta,
          showSum.isAcceptableOrUnknown(data['show_sum'], _showSumMeta));
    } else if (isInserting) {
      context.missing(_showSumMeta);
    }
    if (data.containsKey('show_change')) {
      context.handle(
          _showChangeMeta,
          showChange.isAcceptableOrUnknown(
              data['show_change'], _showChangeMeta));
    } else if (isInserting) {
      context.missing(_showChangeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id'], _unitIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

class Unit extends DataClass implements Insertable<Unit> {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime deletedAt;
  Unit(
      {@required this.id,
      @required this.name,
      this.description,
      @required this.createdAt,
      @required this.modifiedAt,
      this.deletedAt});
  factory Unit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Unit(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      deletedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<DateTime>(modifiedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Unit.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Unit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
    };
  }

  Unit copyWith(
          {int id,
          String name,
          String description,
          DateTime createdAt,
          DateTime modifiedAt,
          DateTime deletedAt}) =>
      Unit(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Unit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(createdAt.hashCode,
                  $mrjc(modifiedAt.hashCode, deletedAt.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Unit &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.deletedAt == this.deletedAt);
}

class UnitsCompanion extends UpdateCompanion<Unit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<DateTime> deletedAt;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  UnitsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.description = const Value.absent(),
    @required DateTime createdAt,
    @required DateTime modifiedAt,
    this.deletedAt = const Value.absent(),
  })  : name = Value(name),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<Unit> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<DateTime> createdAt,
    Expression<DateTime> modifiedAt,
    Expression<DateTime> deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  UnitsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime> modifiedAt,
      Value<DateTime> deletedAt}) {
    return UnitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, Unit> {
  final GeneratedDatabase _db;
  final String _alias;
  $UnitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 0, maxTextLength: 250);
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedDateTimeColumn _modifiedAt;
  @override
  GeneratedDateTimeColumn get modifiedAt =>
      _modifiedAt ??= _constructModifiedAt();
  GeneratedDateTimeColumn _constructModifiedAt() {
    return GeneratedDateTimeColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  GeneratedDateTimeColumn _deletedAt;
  @override
  GeneratedDateTimeColumn get deletedAt => _deletedAt ??= _constructDeletedAt();
  GeneratedDateTimeColumn _constructDeletedAt() {
    return GeneratedDateTimeColumn(
      'deleted_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, createdAt, modifiedAt, deletedAt];
  @override
  $UnitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'units';
  @override
  final String actualTableName = 'units';
  @override
  VerificationContext validateIntegrity(Insertable<Unit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at'], _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Unit map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Unit.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(_db, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final int notificationId;
  final DateTime deletedAt;
  final int eventId;
  Reminder(
      {@required this.id,
      @required this.notificationId,
      this.deletedAt,
      @required this.eventId});
  factory Reminder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Reminder(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      notificationId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}notification_id']),
      deletedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted_at']),
      eventId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || notificationId != null) {
      map['notification_id'] = Variable<int>(notificationId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<int>(eventId);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      notificationId: notificationId == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      eventId: serializer.fromJson<int>(json['eventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationId': serializer.toJson<int>(notificationId),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'eventId': serializer.toJson<int>(eventId),
    };
  }

  Reminder copyWith(
          {int id, int notificationId, DateTime deletedAt, int eventId}) =>
      Reminder(
        id: id ?? this.id,
        notificationId: notificationId ?? this.notificationId,
        deletedAt: deletedAt ?? this.deletedAt,
        eventId: eventId ?? this.eventId,
      );
  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('notificationId: $notificationId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(notificationId.hashCode,
          $mrjc(deletedAt.hashCode, eventId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.notificationId == this.notificationId &&
          other.deletedAt == this.deletedAt &&
          other.eventId == this.eventId);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<int> notificationId;
  final Value<DateTime> deletedAt;
  final Value<int> eventId;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.eventId = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    @required int notificationId,
    this.deletedAt = const Value.absent(),
    @required int eventId,
  })  : notificationId = Value(notificationId),
        eventId = Value(eventId);
  static Insertable<Reminder> custom({
    Expression<int> id,
    Expression<int> notificationId,
    Expression<DateTime> deletedAt,
    Expression<int> eventId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationId != null) 'notification_id': notificationId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (eventId != null) 'event_id': eventId,
    });
  }

  RemindersCompanion copyWith(
      {Value<int> id,
      Value<int> notificationId,
      Value<DateTime> deletedAt,
      Value<int> eventId}) {
    return RemindersCompanion(
      id: id ?? this.id,
      notificationId: notificationId ?? this.notificationId,
      deletedAt: deletedAt ?? this.deletedAt,
      eventId: eventId ?? this.eventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('notificationId: $notificationId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  final GeneratedDatabase _db;
  final String _alias;
  $RemindersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  GeneratedIntColumn _notificationId;
  @override
  GeneratedIntColumn get notificationId =>
      _notificationId ??= _constructNotificationId();
  GeneratedIntColumn _constructNotificationId() {
    return GeneratedIntColumn(
      'notification_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  GeneratedDateTimeColumn _deletedAt;
  @override
  GeneratedDateTimeColumn get deletedAt => _deletedAt ??= _constructDeletedAt();
  GeneratedDateTimeColumn _constructDeletedAt() {
    return GeneratedDateTimeColumn(
      'deleted_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedIntColumn _eventId;
  @override
  GeneratedIntColumn get eventId => _eventId ??= _constructEventId();
  GeneratedIntColumn _constructEventId() {
    return GeneratedIntColumn('event_id', $tableName, false,
        $customConstraints: 'REFERENCES events(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, notificationId, deletedAt, eventId];
  @override
  $RemindersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'reminders';
  @override
  final String actualTableName = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id'], _notificationIdMeta));
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at'], _deletedAtMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Reminder.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $LogsTable _logs;
  $LogsTable get logs => _logs ??= $LogsTable(this);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  $UnitsTable _units;
  $UnitsTable get units => _units ??= $UnitsTable(this);
  $RemindersTable _reminders;
  $RemindersTable get reminders => _reminders ??= $RemindersTable(this);
  LogDao _logDao;
  LogDao get logDao => _logDao ??= LogDao(this as AppDatabase);
  EventDao _eventDao;
  EventDao get eventDao => _eventDao ??= EventDao(this as AppDatabase);
  UnitDao _unitDao;
  UnitDao get unitDao => _unitDao ??= UnitDao(this as AppDatabase);
  ReminderDao _reminderDao;
  ReminderDao get reminderDao =>
      _reminderDao ??= ReminderDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [logs, events, units, reminders];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$LogDaoMixin on DatabaseAccessor<AppDatabase> {
  $LogsTable get logs => attachedDatabase.logs;
  $EventsTable get events => attachedDatabase.events;
  $UnitsTable get units => attachedDatabase.units;
}
mixin _$EventDaoMixin on DatabaseAccessor<AppDatabase> {
  $EventsTable get events => attachedDatabase.events;
  $UnitsTable get units => attachedDatabase.units;
}
mixin _$UnitDaoMixin on DatabaseAccessor<AppDatabase> {
  $UnitsTable get units => attachedDatabase.units;
}
mixin _$ReminderDaoMixin on DatabaseAccessor<AppDatabase> {
  $RemindersTable get reminders => attachedDatabase.reminders;
}
