// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountingTypesTable extends AccountingTypes
    with TableInfo<$AccountingTypesTable, AccountingType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountingTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounting_types';
  @override
  VerificationContext validateIntegrity(Insertable<AccountingType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AccountingType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountingType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AccountingTypesTable createAlias(String alias) {
    return $AccountingTypesTable(attachedDatabase, alias);
  }
}

class AccountingType extends DataClass implements Insertable<AccountingType> {
  final String id;
  final String name;
  const AccountingType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AccountingTypeCompanion toCompanion(bool nullToAbsent) {
    return AccountingTypeCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory AccountingType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountingType(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  AccountingType copyWith({String? id, String? name}) => AccountingType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  AccountingType copyWithCompanion(AccountingTypeCompanion data) {
    return AccountingType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountingType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountingType &&
          other.id == this.id &&
          other.name == this.name);
}

class AccountingTypeCompanion extends UpdateCompanion<AccountingType> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const AccountingTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountingTypeCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<AccountingType> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountingTypeCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return AccountingTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountingTypeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentTypesTable extends DocumentTypes
    with TableInfo<$DocumentTypesTable, DocumentType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_types';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DocumentType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DocumentTypesTable createAlias(String alias) {
    return $DocumentTypesTable(attachedDatabase, alias);
  }
}

class DocumentType extends DataClass implements Insertable<DocumentType> {
  final String id;
  final String name;
  const DocumentType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DocumentTypeCompanion toCompanion(bool nullToAbsent) {
    return DocumentTypeCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory DocumentType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentType(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  DocumentType copyWith({String? id, String? name}) => DocumentType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  DocumentType copyWithCompanion(DocumentTypeCompanion data) {
    return DocumentType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentType && other.id == this.id && other.name == this.name);
}

class DocumentTypeCompanion extends UpdateCompanion<DocumentType> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const DocumentTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentTypeCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<DocumentType> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentTypeCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return DocumentTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTypeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlowTypesTable extends FlowTypes
    with TableInfo<$FlowTypesTable, FlowType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlowTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flow_types';
  @override
  VerificationContext validateIntegrity(Insertable<FlowType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FlowType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlowType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $FlowTypesTable createAlias(String alias) {
    return $FlowTypesTable(attachedDatabase, alias);
  }
}

class FlowType extends DataClass implements Insertable<FlowType> {
  final String id;
  final String name;
  const FlowType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  FlowTypeCompanion toCompanion(bool nullToAbsent) {
    return FlowTypeCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory FlowType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlowType(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  FlowType copyWith({String? id, String? name}) => FlowType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  FlowType copyWithCompanion(FlowTypeCompanion data) {
    return FlowType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlowType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlowType && other.id == this.id && other.name == this.name);
}

class FlowTypeCompanion extends UpdateCompanion<FlowType> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const FlowTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlowTypeCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<FlowType> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlowTypeCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return FlowTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlowTypeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentTypesTable extends PaymentTypes
    with TableInfo<$PaymentTypesTable, PaymentType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_types';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PaymentType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $PaymentTypesTable createAlias(String alias) {
    return $PaymentTypesTable(attachedDatabase, alias);
  }
}

class PaymentType extends DataClass implements Insertable<PaymentType> {
  final String id;
  final String name;
  const PaymentType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PaymentTypeCompanion toCompanion(bool nullToAbsent) {
    return PaymentTypeCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory PaymentType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentType(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PaymentType copyWith({String? id, String? name}) => PaymentType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  PaymentType copyWithCompanion(PaymentTypeCompanion data) {
    return PaymentType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentType && other.id == this.id && other.name == this.name);
}

class PaymentTypeCompanion extends UpdateCompanion<PaymentType> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const PaymentTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentTypeCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PaymentType> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentTypeCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return PaymentTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentTypeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurrenciesTable extends Currencies
    with TableInfo<$CurrenciesTable, Currency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
      'symbol', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 5),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _rateExchangeMeta =
      const VerificationMeta('rateExchange');
  @override
  late final GeneratedColumn<double> rateExchange = GeneratedColumn<double>(
      'rate_exchange', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, symbol, rateExchange, active, createdAt, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencies';
  @override
  VerificationContext validateIntegrity(Insertable<Currency> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('rate_exchange')) {
      context.handle(
          _rateExchangeMeta,
          rateExchange.isAcceptableOrUnknown(
              data['rate_exchange']!, _rateExchangeMeta));
    } else if (isInserting) {
      context.missing(_rateExchangeMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Currency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Currency(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symbol'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CurrenciesTable createAlias(String alias) {
    return $CurrenciesTable(attachedDatabase, alias);
  }
}

class Currency extends DataClass implements Insertable<Currency> {
  final String id;
  final String name;
  final String symbol;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Currency(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.rateExchange,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['symbol'] = Variable<String>(symbol);
    map['rate_exchange'] = Variable<double>(rateExchange);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CurrencyCompanion toCompanion(bool nullToAbsent) {
    return CurrencyCompanion(
      id: Value(id),
      name: Value(name),
      symbol: Value(symbol),
      rateExchange: Value(rateExchange),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Currency.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Currency(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      symbol: serializer.fromJson<String>(json['symbol']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'symbol': serializer.toJson<String>(symbol),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Currency copyWith(
          {String? id,
          String? name,
          String? symbol,
          double? rateExchange,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Currency(
        id: id ?? this.id,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        rateExchange: rateExchange ?? this.rateExchange,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Currency copyWithCompanion(CurrencyCompanion data) {
    return Currency(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Currency(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, symbol, rateExchange, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Currency &&
          other.id == this.id &&
          other.name == this.name &&
          other.symbol == this.symbol &&
          other.rateExchange == this.rateExchange &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CurrencyCompanion extends UpdateCompanion<Currency> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> symbol;
  final Value<double> rateExchange;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CurrencyCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyCompanion.insert({
    required String id,
    required String name,
    required String symbol,
    required double rateExchange,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        symbol = Value(symbol),
        rateExchange = Value(rateExchange);
  static Insertable<Currency> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? symbol,
    Expression<double>? rateExchange,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (symbol != null) 'symbol': symbol,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? symbol,
      Value<double>? rateExchange,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return CurrencyCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      rateExchange: rateExchange ?? this.rateExchange,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (rateExchange.present) {
      map['rate_exchange'] = Variable<double>(rateExchange.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChartAccountsTable extends ChartAccounts
    with TableInfo<$ChartAccountsTable, ChartAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChartAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_accounts (id)'));
  static const VerificationMeta _accountingTypeIdMeta =
      const VerificationMeta('accountingTypeId');
  @override
  late final GeneratedColumn<String> accountingTypeId = GeneratedColumn<String>(
      'accounting_type_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounting_types (id)'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentId,
        accountingTypeId,
        code,
        level,
        name,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chart_accounts';
  @override
  VerificationContext validateIntegrity(Insertable<ChartAccount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('accounting_type_id')) {
      context.handle(
          _accountingTypeIdMeta,
          accountingTypeId.isAcceptableOrUnknown(
              data['accounting_type_id']!, _accountingTypeIdMeta));
    } else if (isInserting) {
      context.missing(_accountingTypeIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ChartAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChartAccount(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      accountingTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}accounting_type_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChartAccountsTable createAlias(String alias) {
    return $ChartAccountsTable(attachedDatabase, alias);
  }
}

class ChartAccount extends DataClass implements Insertable<ChartAccount> {
  final String id;
  final String? parentId;
  final String accountingTypeId;
  final String code;
  final int level;
  final String name;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const ChartAccount(
      {required this.id,
      this.parentId,
      required this.accountingTypeId,
      required this.code,
      required this.level,
      required this.name,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['accounting_type_id'] = Variable<String>(accountingTypeId);
    map['code'] = Variable<String>(code);
    map['level'] = Variable<int>(level);
    map['name'] = Variable<String>(name);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ChartAccountCompanion toCompanion(bool nullToAbsent) {
    return ChartAccountCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      accountingTypeId: Value(accountingTypeId),
      code: Value(code),
      level: Value(level),
      name: Value(name),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ChartAccount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChartAccount(
      id: serializer.fromJson<String>(json['id']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      accountingTypeId: serializer.fromJson<String>(json['accountingTypeId']),
      code: serializer.fromJson<String>(json['code']),
      level: serializer.fromJson<int>(json['level']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentId': serializer.toJson<String?>(parentId),
      'accountingTypeId': serializer.toJson<String>(accountingTypeId),
      'code': serializer.toJson<String>(code),
      'level': serializer.toJson<int>(level),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ChartAccount copyWith(
          {String? id,
          Value<String?> parentId = const Value.absent(),
          String? accountingTypeId,
          String? code,
          int? level,
          String? name,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ChartAccount(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        accountingTypeId: accountingTypeId ?? this.accountingTypeId,
        code: code ?? this.code,
        level: level ?? this.level,
        name: name ?? this.name,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ChartAccount copyWithCompanion(ChartAccountCompanion data) {
    return ChartAccount(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      accountingTypeId: data.accountingTypeId.present
          ? data.accountingTypeId.value
          : this.accountingTypeId,
      code: data.code.present ? data.code.value : this.code,
      level: data.level.present ? data.level.value : this.level,
      name: data.name.present ? data.name.value : this.name,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChartAccount(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('accountingTypeId: $accountingTypeId, ')
          ..write('code: $code, ')
          ..write('level: $level, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, accountingTypeId, code, level,
      name, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChartAccount &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.accountingTypeId == this.accountingTypeId &&
          other.code == this.code &&
          other.level == this.level &&
          other.name == this.name &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ChartAccountCompanion extends UpdateCompanion<ChartAccount> {
  final Value<String> id;
  final Value<String?> parentId;
  final Value<String> accountingTypeId;
  final Value<String> code;
  final Value<int> level;
  final Value<String> name;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ChartAccountCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.accountingTypeId = const Value.absent(),
    this.code = const Value.absent(),
    this.level = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChartAccountCompanion.insert({
    required String id,
    this.parentId = const Value.absent(),
    required String accountingTypeId,
    required String code,
    required int level,
    required String name,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        accountingTypeId = Value(accountingTypeId),
        code = Value(code),
        level = Value(level),
        name = Value(name);
  static Insertable<ChartAccount> custom({
    Expression<String>? id,
    Expression<String>? parentId,
    Expression<String>? accountingTypeId,
    Expression<String>? code,
    Expression<int>? level,
    Expression<String>? name,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (accountingTypeId != null) 'accounting_type_id': accountingTypeId,
      if (code != null) 'code': code,
      if (level != null) 'level': level,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChartAccountCompanion copyWith(
      {Value<String>? id,
      Value<String?>? parentId,
      Value<String>? accountingTypeId,
      Value<String>? code,
      Value<int>? level,
      Value<String>? name,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ChartAccountCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      accountingTypeId: accountingTypeId ?? this.accountingTypeId,
      code: code ?? this.code,
      level: level ?? this.level,
      name: name ?? this.name,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (accountingTypeId.present) {
      map['accounting_type_id'] = Variable<String>(accountingTypeId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChartAccountCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('accountingTypeId: $accountingTypeId, ')
          ..write('code: $code, ')
          ..write('level: $level, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _documentTypeIdMeta =
      const VerificationMeta('documentTypeId');
  @override
  late final GeneratedColumn<String> documentTypeId = GeneratedColumn<String>(
      'document_type_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES document_types (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<String> chartAccountId = GeneratedColumn<String>(
      'chart_account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_accounts (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentId,
        documentTypeId,
        chartAccountId,
        name,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('document_type_id')) {
      context.handle(
          _documentTypeIdMeta,
          documentTypeId.isAcceptableOrUnknown(
              data['document_type_id']!, _documentTypeIdMeta));
    } else if (isInserting) {
      context.missing(_documentTypeIdMeta);
    }
    if (data.containsKey('chart_account_id')) {
      context.handle(
          _chartAccountIdMeta,
          chartAccountId.isAcceptableOrUnknown(
              data['chart_account_id']!, _chartAccountIdMeta));
    } else if (isInserting) {
      context.missing(_chartAccountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      chartAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}chart_account_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final int? parentId;
  final String documentTypeId;
  final String chartAccountId;
  final String name;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Category(
      {required this.id,
      this.parentId,
      required this.documentTypeId,
      required this.chartAccountId,
      required this.name,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['document_type_id'] = Variable<String>(documentTypeId);
    map['chart_account_id'] = Variable<String>(chartAccountId);
    map['name'] = Variable<String>(name);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      documentTypeId: Value(documentTypeId),
      chartAccountId: Value(chartAccountId),
      name: Value(name),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      chartAccountId: serializer.fromJson<String>(json['chartAccountId']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'documentTypeId': serializer.toJson<String>(documentTypeId),
      'chartAccountId': serializer.toJson<String>(chartAccountId),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Category copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? documentTypeId,
          String? chartAccountId,
          String? name,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        name: name ?? this.name,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Category copyWithCompanion(CategoryCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      chartAccountId: data.chartAccountId.present
          ? data.chartAccountId.value
          : this.chartAccountId,
      name: data.name.present ? data.name.value : this.name,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, documentTypeId, chartAccountId,
      name, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.documentTypeId == this.documentTypeId &&
          other.chartAccountId == this.chartAccountId &&
          other.name == this.name &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CategoryCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> documentTypeId;
  final Value<String> chartAccountId;
  final Value<String> name;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String documentTypeId,
    required String chartAccountId,
    required String name,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        chartAccountId = Value(chartAccountId),
        name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? documentTypeId,
    Expression<String>? chartAccountId,
    Expression<String>? name,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (documentTypeId != null) 'document_type_id': documentTypeId,
      if (chartAccountId != null) 'chart_account_id': chartAccountId,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CategoryCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? documentTypeId,
      Value<String>? chartAccountId,
      Value<String>? name,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return CategoryCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (documentTypeId.present) {
      map['document_type_id'] = Variable<String>(documentTypeId.value);
    }
    if (chartAccountId.present) {
      map['chart_account_id'] = Variable<String>(chartAccountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, phone, note, active, createdAt, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? note;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Contact(
      {required this.id,
      required this.name,
      this.email,
      this.phone,
      this.note,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ContactCompanion toCompanion(bool nullToAbsent) {
    return ContactCompanion(
      id: Value(id),
      name: Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      note: serializer.fromJson<String?>(json['note']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'note': serializer.toJson<String?>(note),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Contact copyWith(
          {int? id,
          String? name,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> note = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        note: note.present ? note.value : this.note,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Contact copyWithCompanion(ContactCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      note: data.note.present ? data.note.value : this.note,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, email, phone, note, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.note == this.note &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ContactCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> note;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const ContactCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  ContactCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? note,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (note != null) 'note': note,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  ContactCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? note,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return ContactCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardsTable extends CreditCards
    with TableInfo<$CreditCardsTable, CreditCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _currencyIdMeta =
      const VerificationMeta('currencyId');
  @override
  late final GeneratedColumn<String> currencyId = GeneratedColumn<String>(
      'currency_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES currencies (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<String> chartAccountId = GeneratedColumn<String>(
      'chart_account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_accounts (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quotaMeta = const VerificationMeta('quota');
  @override
  late final GeneratedColumn<double> quota = GeneratedColumn<double>(
      'quota', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _closingDateMeta =
      const VerificationMeta('closingDate');
  @override
  late final GeneratedColumn<int> closingDate = GeneratedColumn<int>(
      'closing_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        currencyId,
        chartAccountId,
        name,
        description,
        quota,
        closingDate,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards';
  @override
  VerificationContext validateIntegrity(Insertable<CreditCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('chart_account_id')) {
      context.handle(
          _chartAccountIdMeta,
          chartAccountId.isAcceptableOrUnknown(
              data['chart_account_id']!, _chartAccountIdMeta));
    } else if (isInserting) {
      context.missing(_chartAccountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('quota')) {
      context.handle(
          _quotaMeta, quota.isAcceptableOrUnknown(data['quota']!, _quotaMeta));
    } else if (isInserting) {
      context.missing(_quotaMeta);
    }
    if (data.containsKey('closing_date')) {
      context.handle(
          _closingDateMeta,
          closingDate.isAcceptableOrUnknown(
              data['closing_date']!, _closingDateMeta));
    } else if (isInserting) {
      context.missing(_closingDateMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      chartAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}chart_account_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      quota: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quota'])!,
      closingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}closing_date'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CreditCardsTable createAlias(String alias) {
    return $CreditCardsTable(attachedDatabase, alias);
  }
}

class CreditCard extends DataClass implements Insertable<CreditCard> {
  final int id;
  final String currencyId;
  final String chartAccountId;
  final String name;
  final String? description;
  final double quota;
  final int closingDate;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const CreditCard(
      {required this.id,
      required this.currencyId,
      required this.chartAccountId,
      required this.name,
      this.description,
      required this.quota,
      required this.closingDate,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_id'] = Variable<String>(currencyId);
    map['chart_account_id'] = Variable<String>(chartAccountId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['quota'] = Variable<double>(quota);
    map['closing_date'] = Variable<int>(closingDate);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CreditCardCompanion toCompanion(bool nullToAbsent) {
    return CreditCardCompanion(
      id: Value(id),
      currencyId: Value(currencyId),
      chartAccountId: Value(chartAccountId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      quota: Value(quota),
      closingDate: Value(closingDate),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CreditCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCard(
      id: serializer.fromJson<int>(json['id']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      chartAccountId: serializer.fromJson<String>(json['chartAccountId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      quota: serializer.fromJson<double>(json['quota']),
      closingDate: serializer.fromJson<int>(json['closingDate']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyId': serializer.toJson<String>(currencyId),
      'chartAccountId': serializer.toJson<String>(chartAccountId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'quota': serializer.toJson<double>(quota),
      'closingDate': serializer.toJson<int>(closingDate),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  CreditCard copyWith(
          {int? id,
          String? currencyId,
          String? chartAccountId,
          String? name,
          Value<String?> description = const Value.absent(),
          double? quota,
          int? closingDate,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      CreditCard(
        id: id ?? this.id,
        currencyId: currencyId ?? this.currencyId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        quota: quota ?? this.quota,
        closingDate: closingDate ?? this.closingDate,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  CreditCard copyWithCompanion(CreditCardCompanion data) {
    return CreditCard(
      id: data.id.present ? data.id.value : this.id,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      chartAccountId: data.chartAccountId.present
          ? data.chartAccountId.value
          : this.chartAccountId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      quota: data.quota.present ? data.quota.value : this.quota,
      closingDate:
          data.closingDate.present ? data.closingDate.value : this.closingDate,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCard(')
          ..write('id: $id, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quota: $quota, ')
          ..write('closingDate: $closingDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currencyId, chartAccountId, name,
      description, quota, closingDate, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCard &&
          other.id == this.id &&
          other.currencyId == this.currencyId &&
          other.chartAccountId == this.chartAccountId &&
          other.name == this.name &&
          other.description == this.description &&
          other.quota == this.quota &&
          other.closingDate == this.closingDate &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CreditCardCompanion extends UpdateCompanion<CreditCard> {
  final Value<int> id;
  final Value<String> currencyId;
  final Value<String> chartAccountId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> quota;
  final Value<int> closingDate;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const CreditCardCompanion({
    this.id = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.quota = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CreditCardCompanion.insert({
    this.id = const Value.absent(),
    required String currencyId,
    required String chartAccountId,
    required String name,
    this.description = const Value.absent(),
    required double quota,
    required int closingDate,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : currencyId = Value(currencyId),
        chartAccountId = Value(chartAccountId),
        name = Value(name),
        quota = Value(quota),
        closingDate = Value(closingDate);
  static Insertable<CreditCard> custom({
    Expression<int>? id,
    Expression<String>? currencyId,
    Expression<String>? chartAccountId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? quota,
    Expression<int>? closingDate,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyId != null) 'currency_id': currencyId,
      if (chartAccountId != null) 'chart_account_id': chartAccountId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (quota != null) 'quota': quota,
      if (closingDate != null) 'closing_date': closingDate,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CreditCardCompanion copyWith(
      {Value<int>? id,
      Value<String>? currencyId,
      Value<String>? chartAccountId,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? quota,
      Value<int>? closingDate,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return CreditCardCompanion(
      id: id ?? this.id,
      currencyId: currencyId ?? this.currencyId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
      description: description ?? this.description,
      quota: quota ?? this.quota,
      closingDate: closingDate ?? this.closingDate,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (chartAccountId.present) {
      map['chart_account_id'] = Variable<String>(chartAccountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quota.present) {
      map['quota'] = Variable<double>(quota.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<int>(closingDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardCompanion(')
          ..write('id: $id, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quota: $quota, ')
          ..write('closingDate: $closingDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $JournalTable extends Journal with TableInfo<$JournalTable, Journal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _documentTypeIdMeta =
      const VerificationMeta('documentTypeId');
  @override
  late final GeneratedColumn<String> documentTypeId = GeneratedColumn<String>(
      'document_type_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES document_types (id)'));
  static const VerificationMeta _secuencialMeta =
      const VerificationMeta('secuencial');
  @override
  late final GeneratedColumn<int> secuencial = GeneratedColumn<int>(
      'secuencial', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        documentTypeId,
        secuencial,
        date,
        description,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal';
  @override
  VerificationContext validateIntegrity(Insertable<Journal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_type_id')) {
      context.handle(
          _documentTypeIdMeta,
          documentTypeId.isAcceptableOrUnknown(
              data['document_type_id']!, _documentTypeIdMeta));
    } else if (isInserting) {
      context.missing(_documentTypeIdMeta);
    }
    if (data.containsKey('secuencial')) {
      context.handle(
          _secuencialMeta,
          secuencial.isAcceptableOrUnknown(
              data['secuencial']!, _secuencialMeta));
    } else if (isInserting) {
      context.missing(_secuencialMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Journal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Journal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      secuencial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}secuencial'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $JournalTable createAlias(String alias) {
    return $JournalTable(attachedDatabase, alias);
  }
}

class Journal extends DataClass implements Insertable<Journal> {
  final int id;
  final String documentTypeId;
  final int secuencial;
  final DateTime date;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Journal(
      {required this.id,
      required this.documentTypeId,
      required this.secuencial,
      required this.date,
      this.description,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_type_id'] = Variable<String>(documentTypeId);
    map['secuencial'] = Variable<int>(secuencial);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  JournalCompanion toCompanion(bool nullToAbsent) {
    return JournalCompanion(
      id: Value(id),
      documentTypeId: Value(documentTypeId),
      secuencial: Value(secuencial),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Journal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Journal(
      id: serializer.fromJson<int>(json['id']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      secuencial: serializer.fromJson<int>(json['secuencial']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentTypeId': serializer.toJson<String>(documentTypeId),
      'secuencial': serializer.toJson<int>(secuencial),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Journal copyWith(
          {int? id,
          String? documentTypeId,
          int? secuencial,
          DateTime? date,
          Value<String?> description = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Journal(
        id: id ?? this.id,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        secuencial: secuencial ?? this.secuencial,
        date: date ?? this.date,
        description: description.present ? description.value : this.description,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Journal copyWithCompanion(JournalCompanion data) {
    return Journal(
      id: data.id.present ? data.id.value : this.id,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      secuencial:
          data.secuencial.present ? data.secuencial.value : this.secuencial,
      date: data.date.present ? data.date.value : this.date,
      description:
          data.description.present ? data.description.value : this.description,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Journal(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, documentTypeId, secuencial, date,
      description, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Journal &&
          other.id == this.id &&
          other.documentTypeId == this.documentTypeId &&
          other.secuencial == this.secuencial &&
          other.date == this.date &&
          other.description == this.description &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class JournalCompanion extends UpdateCompanion<Journal> {
  final Value<int> id;
  final Value<String> documentTypeId;
  final Value<int> secuencial;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const JournalCompanion({
    this.id = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.secuencial = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  JournalCompanion.insert({
    this.id = const Value.absent(),
    required String documentTypeId,
    required int secuencial,
    required DateTime date,
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        secuencial = Value(secuencial),
        date = Value(date);
  static Insertable<Journal> custom({
    Expression<int>? id,
    Expression<String>? documentTypeId,
    Expression<int>? secuencial,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentTypeId != null) 'document_type_id': documentTypeId,
      if (secuencial != null) 'secuencial': secuencial,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  JournalCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentTypeId,
      Value<int>? secuencial,
      Value<DateTime>? date,
      Value<String?>? description,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return JournalCompanion(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      description: description ?? this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentTypeId.present) {
      map['document_type_id'] = Variable<String>(documentTypeId.value);
    }
    if (secuencial.present) {
      map['secuencial'] = Variable<int>(secuencial.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalCompanion(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $JournalDetailsTable extends JournalDetails
    with TableInfo<$JournalDetailsTable, JournalDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _journalIdMeta =
      const VerificationMeta('journalId');
  @override
  late final GeneratedColumn<int> journalId = GeneratedColumn<int>(
      'journal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journal (id)'));
  static const VerificationMeta _currencyIdMeta =
      const VerificationMeta('currencyId');
  @override
  late final GeneratedColumn<String> currencyId = GeneratedColumn<String>(
      'currency_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES currencies (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<String> chartAccountId = GeneratedColumn<String>(
      'chart_account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_accounts (id)'));
  static const VerificationMeta _creditMeta = const VerificationMeta('credit');
  @override
  late final GeneratedColumn<double> credit = GeneratedColumn<double>(
      'credit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _debitMeta = const VerificationMeta('debit');
  @override
  late final GeneratedColumn<double> debit = GeneratedColumn<double>(
      'debit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rateExchangeMeta =
      const VerificationMeta('rateExchange');
  @override
  late final GeneratedColumn<double> rateExchange = GeneratedColumn<double>(
      'rate_exchange', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, journalId, currencyId, chartAccountId, credit, debit, rateExchange];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_details';
  @override
  VerificationContext validateIntegrity(Insertable<JournalDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('journal_id')) {
      context.handle(_journalIdMeta,
          journalId.isAcceptableOrUnknown(data['journal_id']!, _journalIdMeta));
    } else if (isInserting) {
      context.missing(_journalIdMeta);
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('chart_account_id')) {
      context.handle(
          _chartAccountIdMeta,
          chartAccountId.isAcceptableOrUnknown(
              data['chart_account_id']!, _chartAccountIdMeta));
    } else if (isInserting) {
      context.missing(_chartAccountIdMeta);
    }
    if (data.containsKey('credit')) {
      context.handle(_creditMeta,
          credit.isAcceptableOrUnknown(data['credit']!, _creditMeta));
    } else if (isInserting) {
      context.missing(_creditMeta);
    }
    if (data.containsKey('debit')) {
      context.handle(
          _debitMeta, debit.isAcceptableOrUnknown(data['debit']!, _debitMeta));
    } else if (isInserting) {
      context.missing(_debitMeta);
    }
    if (data.containsKey('rate_exchange')) {
      context.handle(
          _rateExchangeMeta,
          rateExchange.isAcceptableOrUnknown(
              data['rate_exchange']!, _rateExchangeMeta));
    } else if (isInserting) {
      context.missing(_rateExchangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      journalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journal_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      chartAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}chart_account_id'])!,
      credit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit'])!,
      debit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}debit'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
    );
  }

  @override
  $JournalDetailsTable createAlias(String alias) {
    return $JournalDetailsTable(attachedDatabase, alias);
  }
}

class JournalDetail extends DataClass implements Insertable<JournalDetail> {
  final int id;
  final int journalId;
  final String currencyId;
  final String chartAccountId;
  final double credit;
  final double debit;
  final double rateExchange;
  const JournalDetail(
      {required this.id,
      required this.journalId,
      required this.currencyId,
      required this.chartAccountId,
      required this.credit,
      required this.debit,
      required this.rateExchange});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['journal_id'] = Variable<int>(journalId);
    map['currency_id'] = Variable<String>(currencyId);
    map['chart_account_id'] = Variable<String>(chartAccountId);
    map['credit'] = Variable<double>(credit);
    map['debit'] = Variable<double>(debit);
    map['rate_exchange'] = Variable<double>(rateExchange);
    return map;
  }

  JournalDetailCompanion toCompanion(bool nullToAbsent) {
    return JournalDetailCompanion(
      id: Value(id),
      journalId: Value(journalId),
      currencyId: Value(currencyId),
      chartAccountId: Value(chartAccountId),
      credit: Value(credit),
      debit: Value(debit),
      rateExchange: Value(rateExchange),
    );
  }

  factory JournalDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalDetail(
      id: serializer.fromJson<int>(json['id']),
      journalId: serializer.fromJson<int>(json['journalId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      chartAccountId: serializer.fromJson<String>(json['chartAccountId']),
      credit: serializer.fromJson<double>(json['credit']),
      debit: serializer.fromJson<double>(json['debit']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'journalId': serializer.toJson<int>(journalId),
      'currencyId': serializer.toJson<String>(currencyId),
      'chartAccountId': serializer.toJson<String>(chartAccountId),
      'credit': serializer.toJson<double>(credit),
      'debit': serializer.toJson<double>(debit),
      'rateExchange': serializer.toJson<double>(rateExchange),
    };
  }

  JournalDetail copyWith(
          {int? id,
          int? journalId,
          String? currencyId,
          String? chartAccountId,
          double? credit,
          double? debit,
          double? rateExchange}) =>
      JournalDetail(
        id: id ?? this.id,
        journalId: journalId ?? this.journalId,
        currencyId: currencyId ?? this.currencyId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        credit: credit ?? this.credit,
        debit: debit ?? this.debit,
        rateExchange: rateExchange ?? this.rateExchange,
      );
  JournalDetail copyWithCompanion(JournalDetailCompanion data) {
    return JournalDetail(
      id: data.id.present ? data.id.value : this.id,
      journalId: data.journalId.present ? data.journalId.value : this.journalId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      chartAccountId: data.chartAccountId.present
          ? data.chartAccountId.value
          : this.chartAccountId,
      credit: data.credit.present ? data.credit.value : this.credit,
      debit: data.debit.present ? data.debit.value : this.debit,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalDetail(')
          ..write('id: $id, ')
          ..write('journalId: $journalId, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('credit: $credit, ')
          ..write('debit: $debit, ')
          ..write('rateExchange: $rateExchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, journalId, currencyId, chartAccountId, credit, debit, rateExchange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalDetail &&
          other.id == this.id &&
          other.journalId == this.journalId &&
          other.currencyId == this.currencyId &&
          other.chartAccountId == this.chartAccountId &&
          other.credit == this.credit &&
          other.debit == this.debit &&
          other.rateExchange == this.rateExchange);
}

class JournalDetailCompanion extends UpdateCompanion<JournalDetail> {
  final Value<int> id;
  final Value<int> journalId;
  final Value<String> currencyId;
  final Value<String> chartAccountId;
  final Value<double> credit;
  final Value<double> debit;
  final Value<double> rateExchange;
  const JournalDetailCompanion({
    this.id = const Value.absent(),
    this.journalId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.credit = const Value.absent(),
    this.debit = const Value.absent(),
    this.rateExchange = const Value.absent(),
  });
  JournalDetailCompanion.insert({
    this.id = const Value.absent(),
    required int journalId,
    required String currencyId,
    required String chartAccountId,
    required double credit,
    required double debit,
    required double rateExchange,
  })  : journalId = Value(journalId),
        currencyId = Value(currencyId),
        chartAccountId = Value(chartAccountId),
        credit = Value(credit),
        debit = Value(debit),
        rateExchange = Value(rateExchange);
  static Insertable<JournalDetail> custom({
    Expression<int>? id,
    Expression<int>? journalId,
    Expression<String>? currencyId,
    Expression<String>? chartAccountId,
    Expression<double>? credit,
    Expression<double>? debit,
    Expression<double>? rateExchange,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (journalId != null) 'journal_id': journalId,
      if (currencyId != null) 'currency_id': currencyId,
      if (chartAccountId != null) 'chart_account_id': chartAccountId,
      if (credit != null) 'credit': credit,
      if (debit != null) 'debit': debit,
      if (rateExchange != null) 'rate_exchange': rateExchange,
    });
  }

  JournalDetailCompanion copyWith(
      {Value<int>? id,
      Value<int>? journalId,
      Value<String>? currencyId,
      Value<String>? chartAccountId,
      Value<double>? credit,
      Value<double>? debit,
      Value<double>? rateExchange}) {
    return JournalDetailCompanion(
      id: id ?? this.id,
      journalId: journalId ?? this.journalId,
      currencyId: currencyId ?? this.currencyId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      rateExchange: rateExchange ?? this.rateExchange,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (journalId.present) {
      map['journal_id'] = Variable<int>(journalId.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (chartAccountId.present) {
      map['chart_account_id'] = Variable<String>(chartAccountId.value);
    }
    if (credit.present) {
      map['credit'] = Variable<double>(credit.value);
    }
    if (debit.present) {
      map['debit'] = Variable<double>(debit.value);
    }
    if (rateExchange.present) {
      map['rate_exchange'] = Variable<double>(rateExchange.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalDetailCompanion(')
          ..write('id: $id, ')
          ..write('journalId: $journalId, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('credit: $credit, ')
          ..write('debit: $debit, ')
          ..write('rateExchange: $rateExchange')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _documentTypeIdMeta =
      const VerificationMeta('documentTypeId');
  @override
  late final GeneratedColumn<String> documentTypeId = GeneratedColumn<String>(
      'document_type_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES document_types (id)'));
  static const VerificationMeta _currencyIdMeta =
      const VerificationMeta('currencyId');
  @override
  late final GeneratedColumn<String> currencyId = GeneratedColumn<String>(
      'currency_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES currencies (id)'));
  static const VerificationMeta _journalIdMeta =
      const VerificationMeta('journalId');
  @override
  late final GeneratedColumn<int> journalId = GeneratedColumn<int>(
      'journal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journal (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  static const VerificationMeta _secuencialMeta =
      const VerificationMeta('secuencial');
  @override
  late final GeneratedColumn<int> secuencial = GeneratedColumn<int>(
      'secuencial', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rateExchangeMeta =
      const VerificationMeta('rateExchange');
  @override
  late final GeneratedColumn<double> rateExchange = GeneratedColumn<double>(
      'rate_exchange', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        documentTypeId,
        currencyId,
        journalId,
        contactId,
        secuencial,
        date,
        amount,
        rateExchange,
        description,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_type_id')) {
      context.handle(
          _documentTypeIdMeta,
          documentTypeId.isAcceptableOrUnknown(
              data['document_type_id']!, _documentTypeIdMeta));
    } else if (isInserting) {
      context.missing(_documentTypeIdMeta);
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('journal_id')) {
      context.handle(_journalIdMeta,
          journalId.isAcceptableOrUnknown(data['journal_id']!, _journalIdMeta));
    } else if (isInserting) {
      context.missing(_journalIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    }
    if (data.containsKey('secuencial')) {
      context.handle(
          _secuencialMeta,
          secuencial.isAcceptableOrUnknown(
              data['secuencial']!, _secuencialMeta));
    } else if (isInserting) {
      context.missing(_secuencialMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('rate_exchange')) {
      context.handle(
          _rateExchangeMeta,
          rateExchange.isAcceptableOrUnknown(
              data['rate_exchange']!, _rateExchangeMeta));
    } else if (isInserting) {
      context.missing(_rateExchangeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      journalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journal_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id']),
      secuencial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}secuencial'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int journalId;
  final int? contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Transaction(
      {required this.id,
      required this.documentTypeId,
      required this.currencyId,
      required this.journalId,
      this.contactId,
      required this.secuencial,
      required this.date,
      required this.amount,
      required this.rateExchange,
      this.description,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_type_id'] = Variable<String>(documentTypeId);
    map['currency_id'] = Variable<String>(currencyId);
    map['journal_id'] = Variable<int>(journalId);
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<int>(contactId);
    }
    map['secuencial'] = Variable<int>(secuencial);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['rate_exchange'] = Variable<double>(rateExchange);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TransactionCompanion toCompanion(bool nullToAbsent) {
    return TransactionCompanion(
      id: Value(id),
      documentTypeId: Value(documentTypeId),
      currencyId: Value(currencyId),
      journalId: Value(journalId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      secuencial: Value(secuencial),
      date: Value(date),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      journalId: serializer.fromJson<int>(json['journalId']),
      contactId: serializer.fromJson<int?>(json['contactId']),
      secuencial: serializer.fromJson<int>(json['secuencial']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
      description: serializer.fromJson<String?>(json['description']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentTypeId': serializer.toJson<String>(documentTypeId),
      'currencyId': serializer.toJson<String>(currencyId),
      'journalId': serializer.toJson<int>(journalId),
      'contactId': serializer.toJson<int?>(contactId),
      'secuencial': serializer.toJson<int>(secuencial),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'description': serializer.toJson<String?>(description),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Transaction copyWith(
          {int? id,
          String? documentTypeId,
          String? currencyId,
          int? journalId,
          Value<int?> contactId = const Value.absent(),
          int? secuencial,
          DateTime? date,
          double? amount,
          double? rateExchange,
          Value<String?> description = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Transaction(
        id: id ?? this.id,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        currencyId: currencyId ?? this.currencyId,
        journalId: journalId ?? this.journalId,
        contactId: contactId.present ? contactId.value : this.contactId,
        secuencial: secuencial ?? this.secuencial,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
        description: description.present ? description.value : this.description,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Transaction copyWithCompanion(TransactionCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      journalId: data.journalId.present ? data.journalId.value : this.journalId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      secuencial:
          data.secuencial.present ? data.secuencial.value : this.secuencial,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
      description:
          data.description.present ? data.description.value : this.description,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('journalId: $journalId, ')
          ..write('contactId: $contactId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      documentTypeId,
      currencyId,
      journalId,
      contactId,
      secuencial,
      date,
      amount,
      rateExchange,
      description,
      active,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.documentTypeId == this.documentTypeId &&
          other.currencyId == this.currencyId &&
          other.journalId == this.journalId &&
          other.contactId == this.contactId &&
          other.secuencial == this.secuencial &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange &&
          other.description == this.description &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TransactionCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> documentTypeId;
  final Value<String> currencyId;
  final Value<int> journalId;
  final Value<int?> contactId;
  final Value<int> secuencial;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<double> rateExchange;
  final Value<String?> description;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const TransactionCompanion({
    this.id = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.journalId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.secuencial = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  TransactionCompanion.insert({
    this.id = const Value.absent(),
    required String documentTypeId,
    required String currencyId,
    required int journalId,
    this.contactId = const Value.absent(),
    required int secuencial,
    required DateTime date,
    required double amount,
    required double rateExchange,
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        currencyId = Value(currencyId),
        journalId = Value(journalId),
        secuencial = Value(secuencial),
        date = Value(date),
        amount = Value(amount),
        rateExchange = Value(rateExchange);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? documentTypeId,
    Expression<String>? currencyId,
    Expression<int>? journalId,
    Expression<int>? contactId,
    Expression<int>? secuencial,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<double>? rateExchange,
    Expression<String>? description,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentTypeId != null) 'document_type_id': documentTypeId,
      if (currencyId != null) 'currency_id': currencyId,
      if (journalId != null) 'journal_id': journalId,
      if (contactId != null) 'contact_id': contactId,
      if (secuencial != null) 'secuencial': secuencial,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (description != null) 'description': description,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  TransactionCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentTypeId,
      Value<String>? currencyId,
      Value<int>? journalId,
      Value<int?>? contactId,
      Value<int>? secuencial,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<double>? rateExchange,
      Value<String?>? description,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return TransactionCompanion(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      currencyId: currencyId ?? this.currencyId,
      journalId: journalId ?? this.journalId,
      contactId: contactId ?? this.contactId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      description: description ?? this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentTypeId.present) {
      map['document_type_id'] = Variable<String>(documentTypeId.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (journalId.present) {
      map['journal_id'] = Variable<int>(journalId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    if (secuencial.present) {
      map['secuencial'] = Variable<int>(secuencial.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rateExchange.present) {
      map['rate_exchange'] = Variable<double>(rateExchange.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionCompanion(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('journalId: $journalId, ')
          ..write('contactId: $contactId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionDetailsTable extends TransactionDetails
    with TableInfo<$TransactionDetailsTable, TransactionDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES transactions (id)'));
  static const VerificationMeta _currencyIdMeta =
      const VerificationMeta('currencyId');
  @override
  late final GeneratedColumn<String> currencyId = GeneratedColumn<String>(
      'currency_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES currencies (id)'));
  static const VerificationMeta _flowIdMeta = const VerificationMeta('flowId');
  @override
  late final GeneratedColumn<String> flowId = GeneratedColumn<String>(
      'flow_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES flow_types (id)'));
  static const VerificationMeta _paymentTypeIdMeta =
      const VerificationMeta('paymentTypeId');
  @override
  late final GeneratedColumn<String> paymentTypeId = GeneratedColumn<String>(
      'payment_type_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES payment_types (id)'));
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<int> paymentId = GeneratedColumn<int>(
      'payment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rateExchangeMeta =
      const VerificationMeta('rateExchange');
  @override
  late final GeneratedColumn<double> rateExchange = GeneratedColumn<double>(
      'rate_exchange', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        transactionId,
        currencyId,
        flowId,
        paymentTypeId,
        paymentId,
        categoryId,
        amount,
        rateExchange
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_details';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('flow_id')) {
      context.handle(_flowIdMeta,
          flowId.isAcceptableOrUnknown(data['flow_id']!, _flowIdMeta));
    } else if (isInserting) {
      context.missing(_flowIdMeta);
    }
    if (data.containsKey('payment_type_id')) {
      context.handle(
          _paymentTypeIdMeta,
          paymentTypeId.isAcceptableOrUnknown(
              data['payment_type_id']!, _paymentTypeIdMeta));
    } else if (isInserting) {
      context.missing(_paymentTypeIdMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('rate_exchange')) {
      context.handle(
          _rateExchangeMeta,
          rateExchange.isAcceptableOrUnknown(
              data['rate_exchange']!, _rateExchangeMeta));
    } else if (isInserting) {
      context.missing(_rateExchangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      flowId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flow_id'])!,
      paymentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_type_id'])!,
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
    );
  }

  @override
  $TransactionDetailsTable createAlias(String alias) {
    return $TransactionDetailsTable(attachedDatabase, alias);
  }
}

class TransactionDetail extends DataClass
    implements Insertable<TransactionDetail> {
  final int id;
  final int transactionId;
  final String currencyId;
  final String flowId;
  final String paymentTypeId;
  final int paymentId;
  final int categoryId;
  final double amount;
  final double rateExchange;
  const TransactionDetail(
      {required this.id,
      required this.transactionId,
      required this.currencyId,
      required this.flowId,
      required this.paymentTypeId,
      required this.paymentId,
      required this.categoryId,
      required this.amount,
      required this.rateExchange});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    map['currency_id'] = Variable<String>(currencyId);
    map['flow_id'] = Variable<String>(flowId);
    map['payment_type_id'] = Variable<String>(paymentTypeId);
    map['payment_id'] = Variable<int>(paymentId);
    map['category_id'] = Variable<int>(categoryId);
    map['amount'] = Variable<double>(amount);
    map['rate_exchange'] = Variable<double>(rateExchange);
    return map;
  }

  TransactionDetailCompanion toCompanion(bool nullToAbsent) {
    return TransactionDetailCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      currencyId: Value(currencyId),
      flowId: Value(flowId),
      paymentTypeId: Value(paymentTypeId),
      paymentId: Value(paymentId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
    );
  }

  factory TransactionDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDetail(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      flowId: serializer.fromJson<String>(json['flowId']),
      paymentTypeId: serializer.fromJson<String>(json['paymentTypeId']),
      paymentId: serializer.fromJson<int>(json['paymentId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'currencyId': serializer.toJson<String>(currencyId),
      'flowId': serializer.toJson<String>(flowId),
      'paymentTypeId': serializer.toJson<String>(paymentTypeId),
      'paymentId': serializer.toJson<int>(paymentId),
      'categoryId': serializer.toJson<int>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
    };
  }

  TransactionDetail copyWith(
          {int? id,
          int? transactionId,
          String? currencyId,
          String? flowId,
          String? paymentTypeId,
          int? paymentId,
          int? categoryId,
          double? amount,
          double? rateExchange}) =>
      TransactionDetail(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        currencyId: currencyId ?? this.currencyId,
        flowId: flowId ?? this.flowId,
        paymentTypeId: paymentTypeId ?? this.paymentTypeId,
        paymentId: paymentId ?? this.paymentId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
      );
  TransactionDetail copyWithCompanion(TransactionDetailCompanion data) {
    return TransactionDetail(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      flowId: data.flowId.present ? data.flowId.value : this.flowId,
      paymentTypeId: data.paymentTypeId.present
          ? data.paymentTypeId.value
          : this.paymentTypeId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionDetail(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('currencyId: $currencyId, ')
          ..write('flowId: $flowId, ')
          ..write('paymentTypeId: $paymentTypeId, ')
          ..write('paymentId: $paymentId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transactionId, currencyId, flowId,
      paymentTypeId, paymentId, categoryId, amount, rateExchange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDetail &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.currencyId == this.currencyId &&
          other.flowId == this.flowId &&
          other.paymentTypeId == this.paymentTypeId &&
          other.paymentId == this.paymentId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange);
}

class TransactionDetailCompanion extends UpdateCompanion<TransactionDetail> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<String> currencyId;
  final Value<String> flowId;
  final Value<String> paymentTypeId;
  final Value<int> paymentId;
  final Value<int> categoryId;
  final Value<double> amount;
  final Value<double> rateExchange;
  const TransactionDetailCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.flowId = const Value.absent(),
    this.paymentTypeId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
  });
  TransactionDetailCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    required String currencyId,
    required String flowId,
    required String paymentTypeId,
    required int paymentId,
    required int categoryId,
    required double amount,
    required double rateExchange,
  })  : transactionId = Value(transactionId),
        currencyId = Value(currencyId),
        flowId = Value(flowId),
        paymentTypeId = Value(paymentTypeId),
        paymentId = Value(paymentId),
        categoryId = Value(categoryId),
        amount = Value(amount),
        rateExchange = Value(rateExchange);
  static Insertable<TransactionDetail> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<String>? currencyId,
    Expression<String>? flowId,
    Expression<String>? paymentTypeId,
    Expression<int>? paymentId,
    Expression<int>? categoryId,
    Expression<double>? amount,
    Expression<double>? rateExchange,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (currencyId != null) 'currency_id': currencyId,
      if (flowId != null) 'flow_id': flowId,
      if (paymentTypeId != null) 'payment_type_id': paymentTypeId,
      if (paymentId != null) 'payment_id': paymentId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
    });
  }

  TransactionDetailCompanion copyWith(
      {Value<int>? id,
      Value<int>? transactionId,
      Value<String>? currencyId,
      Value<String>? flowId,
      Value<String>? paymentTypeId,
      Value<int>? paymentId,
      Value<int>? categoryId,
      Value<double>? amount,
      Value<double>? rateExchange}) {
    return TransactionDetailCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      currencyId: currencyId ?? this.currencyId,
      flowId: flowId ?? this.flowId,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      paymentId: paymentId ?? this.paymentId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (flowId.present) {
      map['flow_id'] = Variable<String>(flowId.value);
    }
    if (paymentTypeId.present) {
      map['payment_type_id'] = Variable<String>(paymentTypeId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<int>(paymentId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rateExchange.present) {
      map['rate_exchange'] = Variable<double>(rateExchange.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionDetailCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('currencyId: $currencyId, ')
          ..write('flowId: $flowId, ')
          ..write('paymentTypeId: $paymentTypeId, ')
          ..write('paymentId: $paymentId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountingTypesTable accountingTypes =
      $AccountingTypesTable(this);
  late final $DocumentTypesTable documentTypes = $DocumentTypesTable(this);
  late final $FlowTypesTable flowTypes = $FlowTypesTable(this);
  late final $PaymentTypesTable paymentTypes = $PaymentTypesTable(this);
  late final $CurrenciesTable currencies = $CurrenciesTable(this);
  late final $ChartAccountsTable chartAccounts = $ChartAccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $CreditCardsTable creditCards = $CreditCardsTable(this);
  late final $JournalTable journal = $JournalTable(this);
  late final $JournalDetailsTable journalDetails = $JournalDetailsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $TransactionDetailsTable transactionDetails =
      $TransactionDetailsTable(this);
  late final ChartAccountsDao chartAccountsDao =
      ChartAccountsDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final CashBankDao cashBankDao = CashBankDao(this as AppDatabase);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  late final CreditCardDao creditCardDao = CreditCardDao(this as AppDatabase);
  late final JournalDao journalDao = JournalDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountingTypes,
        documentTypes,
        flowTypes,
        paymentTypes,
        currencies,
        chartAccounts,
        categories,
        contacts,
        creditCards,
        journal,
        journalDetails,
        transactions,
        transactionDetails
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$AccountingTypesTableCreateCompanionBuilder = AccountingTypeCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$AccountingTypesTableUpdateCompanionBuilder = AccountingTypeCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$AccountingTypesTableReferences extends BaseReferences<
    _$AppDatabase, $AccountingTypesTable, AccountingType> {
  $$AccountingTypesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChartAccountsTable, List<ChartAccount>>
      _chartAccountsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.chartAccounts,
              aliasName: $_aliasNameGenerator(
                  db.accountingTypes.id, db.chartAccounts.accountingTypeId));

  $$ChartAccountsTableProcessedTableManager get chartAccountsRefs {
    final manager = $$ChartAccountsTableTableManager($_db, $_db.chartAccounts)
        .filter((f) => f.accountingTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_chartAccountsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountingTypesTableFilterComposer
    extends Composer<_$AppDatabase, $AccountingTypesTable> {
  $$AccountingTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> chartAccountsRefs(
      Expression<bool> Function($$ChartAccountsTableFilterComposer f) f) {
    final $$ChartAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.accountingTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableFilterComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountingTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountingTypesTable> {
  $$AccountingTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$AccountingTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountingTypesTable> {
  $$AccountingTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> chartAccountsRefs<T extends Object>(
      Expression<T> Function($$ChartAccountsTableAnnotationComposer a) f) {
    final $$ChartAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.accountingTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountingTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountingTypesTable,
    AccountingType,
    $$AccountingTypesTableFilterComposer,
    $$AccountingTypesTableOrderingComposer,
    $$AccountingTypesTableAnnotationComposer,
    $$AccountingTypesTableCreateCompanionBuilder,
    $$AccountingTypesTableUpdateCompanionBuilder,
    (AccountingType, $$AccountingTypesTableReferences),
    AccountingType,
    PrefetchHooks Function({bool chartAccountsRefs})> {
  $$AccountingTypesTableTableManager(
      _$AppDatabase db, $AccountingTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountingTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountingTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountingTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountingTypeCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountingTypeCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AccountingTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({chartAccountsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chartAccountsRefs) db.chartAccounts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chartAccountsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AccountingTypesTableReferences
                            ._chartAccountsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountingTypesTableReferences(db, table, p0)
                                .chartAccountsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.accountingTypeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AccountingTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountingTypesTable,
    AccountingType,
    $$AccountingTypesTableFilterComposer,
    $$AccountingTypesTableOrderingComposer,
    $$AccountingTypesTableAnnotationComposer,
    $$AccountingTypesTableCreateCompanionBuilder,
    $$AccountingTypesTableUpdateCompanionBuilder,
    (AccountingType, $$AccountingTypesTableReferences),
    AccountingType,
    PrefetchHooks Function({bool chartAccountsRefs})>;
typedef $$DocumentTypesTableCreateCompanionBuilder = DocumentTypeCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$DocumentTypesTableUpdateCompanionBuilder = DocumentTypeCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$DocumentTypesTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentTypesTable, DocumentType> {
  $$DocumentTypesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoriesTable, List<Category>>
      _categoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.categories,
              aliasName: $_aliasNameGenerator(
                  db.documentTypes.id, db.categories.documentTypeId));

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalTable, List<Journal>> _journalRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.journal,
          aliasName: $_aliasNameGenerator(
              db.documentTypes.id, db.journal.documentTypeId));

  $$JournalTableProcessedTableManager get journalRefs {
    final manager = $$JournalTableTableManager($_db, $_db.journal)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: $_aliasNameGenerator(
                  db.documentTypes.id, db.transactions.documentTypeId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DocumentTypesTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentTypesTable> {
  $$DocumentTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> categoriesRefs(
      Expression<bool> Function($$CategoriesTableFilterComposer f) f) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalRefs(
      Expression<bool> Function($$JournalTableFilterComposer f) f) {
    final $$JournalTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableFilterComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DocumentTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentTypesTable> {
  $$DocumentTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$DocumentTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentTypesTable> {
  $$DocumentTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> categoriesRefs<T extends Object>(
      Expression<T> Function($$CategoriesTableAnnotationComposer a) f) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalRefs<T extends Object>(
      Expression<T> Function($$JournalTableAnnotationComposer a) f) {
    final $$JournalTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableAnnotationComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DocumentTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentTypesTable,
    DocumentType,
    $$DocumentTypesTableFilterComposer,
    $$DocumentTypesTableOrderingComposer,
    $$DocumentTypesTableAnnotationComposer,
    $$DocumentTypesTableCreateCompanionBuilder,
    $$DocumentTypesTableUpdateCompanionBuilder,
    (DocumentType, $$DocumentTypesTableReferences),
    DocumentType,
    PrefetchHooks Function(
        {bool categoriesRefs, bool journalRefs, bool transactionsRefs})> {
  $$DocumentTypesTableTableManager(_$AppDatabase db, $DocumentTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentTypeCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentTypeCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DocumentTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {categoriesRefs = false,
              journalRefs = false,
              transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoriesRefs) db.categories,
                if (journalRefs) db.journal,
                if (transactionsRefs) db.transactions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypesTableReferences
                            ._categoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypesTableReferences(db, table, p0)
                                .categoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (journalRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypesTableReferences
                            ._journalRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypesTableReferences(db, table, p0)
                                .journalRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypesTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypesTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DocumentTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentTypesTable,
    DocumentType,
    $$DocumentTypesTableFilterComposer,
    $$DocumentTypesTableOrderingComposer,
    $$DocumentTypesTableAnnotationComposer,
    $$DocumentTypesTableCreateCompanionBuilder,
    $$DocumentTypesTableUpdateCompanionBuilder,
    (DocumentType, $$DocumentTypesTableReferences),
    DocumentType,
    PrefetchHooks Function(
        {bool categoriesRefs, bool journalRefs, bool transactionsRefs})>;
typedef $$FlowTypesTableCreateCompanionBuilder = FlowTypeCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$FlowTypesTableUpdateCompanionBuilder = FlowTypeCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$FlowTypesTableReferences
    extends BaseReferences<_$AppDatabase, $FlowTypesTable, FlowType> {
  $$FlowTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionDetailsTable, List<TransactionDetail>>
      _transactionDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetails,
              aliasName: $_aliasNameGenerator(
                  db.flowTypes.id, db.transactionDetails.flowId));

  $$TransactionDetailsTableProcessedTableManager get transactionDetailsRefs {
    final manager =
        $$TransactionDetailsTableTableManager($_db, $_db.transactionDetails)
            .filter((f) => f.flowId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FlowTypesTableFilterComposer
    extends Composer<_$AppDatabase, $FlowTypesTable> {
  $$FlowTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionDetailsRefs(
      Expression<bool> Function($$TransactionDetailsTableFilterComposer f) f) {
    final $$TransactionDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetails,
        getReferencedColumn: (t) => t.flowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailsTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FlowTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $FlowTypesTable> {
  $$FlowTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$FlowTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlowTypesTable> {
  $$FlowTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> transactionDetailsRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailsTableAnnotationComposer a) f) {
    final $$TransactionDetailsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetails,
            getReferencedColumn: (t) => t.flowId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetails,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FlowTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FlowTypesTable,
    FlowType,
    $$FlowTypesTableFilterComposer,
    $$FlowTypesTableOrderingComposer,
    $$FlowTypesTableAnnotationComposer,
    $$FlowTypesTableCreateCompanionBuilder,
    $$FlowTypesTableUpdateCompanionBuilder,
    (FlowType, $$FlowTypesTableReferences),
    FlowType,
    PrefetchHooks Function({bool transactionDetailsRefs})> {
  $$FlowTypesTableTableManager(_$AppDatabase db, $FlowTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlowTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlowTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlowTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FlowTypeCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              FlowTypeCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FlowTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({transactionDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailsRefs) db.transactionDetails
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$FlowTypesTableReferences
                            ._transactionDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FlowTypesTableReferences(db, table, p0)
                                .transactionDetailsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.flowId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FlowTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FlowTypesTable,
    FlowType,
    $$FlowTypesTableFilterComposer,
    $$FlowTypesTableOrderingComposer,
    $$FlowTypesTableAnnotationComposer,
    $$FlowTypesTableCreateCompanionBuilder,
    $$FlowTypesTableUpdateCompanionBuilder,
    (FlowType, $$FlowTypesTableReferences),
    FlowType,
    PrefetchHooks Function({bool transactionDetailsRefs})>;
typedef $$PaymentTypesTableCreateCompanionBuilder = PaymentTypeCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$PaymentTypesTableUpdateCompanionBuilder = PaymentTypeCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$PaymentTypesTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentTypesTable, PaymentType> {
  $$PaymentTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionDetailsTable, List<TransactionDetail>>
      _transactionDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetails,
              aliasName: $_aliasNameGenerator(
                  db.paymentTypes.id, db.transactionDetails.paymentTypeId));

  $$TransactionDetailsTableProcessedTableManager get transactionDetailsRefs {
    final manager =
        $$TransactionDetailsTableTableManager($_db, $_db.transactionDetails)
            .filter((f) => f.paymentTypeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PaymentTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentTypesTable> {
  $$PaymentTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionDetailsRefs(
      Expression<bool> Function($$TransactionDetailsTableFilterComposer f) f) {
    final $$TransactionDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetails,
        getReferencedColumn: (t) => t.paymentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailsTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PaymentTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentTypesTable> {
  $$PaymentTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$PaymentTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentTypesTable> {
  $$PaymentTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> transactionDetailsRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailsTableAnnotationComposer a) f) {
    final $$TransactionDetailsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetails,
            getReferencedColumn: (t) => t.paymentTypeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetails,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PaymentTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentTypesTable,
    PaymentType,
    $$PaymentTypesTableFilterComposer,
    $$PaymentTypesTableOrderingComposer,
    $$PaymentTypesTableAnnotationComposer,
    $$PaymentTypesTableCreateCompanionBuilder,
    $$PaymentTypesTableUpdateCompanionBuilder,
    (PaymentType, $$PaymentTypesTableReferences),
    PaymentType,
    PrefetchHooks Function({bool transactionDetailsRefs})> {
  $$PaymentTypesTableTableManager(_$AppDatabase db, $PaymentTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentTypeCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentTypeCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PaymentTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({transactionDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailsRefs) db.transactionDetails
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PaymentTypesTableReferences
                            ._transactionDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PaymentTypesTableReferences(db, table, p0)
                                .transactionDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.paymentTypeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PaymentTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentTypesTable,
    PaymentType,
    $$PaymentTypesTableFilterComposer,
    $$PaymentTypesTableOrderingComposer,
    $$PaymentTypesTableAnnotationComposer,
    $$PaymentTypesTableCreateCompanionBuilder,
    $$PaymentTypesTableUpdateCompanionBuilder,
    (PaymentType, $$PaymentTypesTableReferences),
    PaymentType,
    PrefetchHooks Function({bool transactionDetailsRefs})>;
typedef $$CurrenciesTableCreateCompanionBuilder = CurrencyCompanion Function({
  required String id,
  required String name,
  required String symbol,
  required double rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$CurrenciesTableUpdateCompanionBuilder = CurrencyCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> symbol,
  Value<double> rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$CurrenciesTableReferences
    extends BaseReferences<_$AppDatabase, $CurrenciesTable, Currency> {
  $$CurrenciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CreditCardsTable, List<CreditCard>>
      _creditCardsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.creditCards,
              aliasName: $_aliasNameGenerator(
                  db.currencies.id, db.creditCards.currencyId));

  $$CreditCardsTableProcessedTableManager get creditCardsRefs {
    final manager = $$CreditCardsTableTableManager($_db, $_db.creditCards)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_creditCardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalDetailsTable, List<JournalDetail>>
      _journalDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetails,
              aliasName: $_aliasNameGenerator(
                  db.currencies.id, db.journalDetails.currencyId));

  $$JournalDetailsTableProcessedTableManager get journalDetailsRefs {
    final manager = $$JournalDetailsTableTableManager($_db, $_db.journalDetails)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: $_aliasNameGenerator(
                  db.currencies.id, db.transactions.currencyId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionDetailsTable, List<TransactionDetail>>
      _transactionDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetails,
              aliasName: $_aliasNameGenerator(
                  db.currencies.id, db.transactionDetails.currencyId));

  $$TransactionDetailsTableProcessedTableManager get transactionDetailsRefs {
    final manager =
        $$TransactionDetailsTableTableManager($_db, $_db.transactionDetails)
            .filter((f) => f.currencyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CurrenciesTableFilterComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> creditCardsRefs(
      Expression<bool> Function($$CreditCardsTableFilterComposer f) f) {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCards,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardsTableFilterComposer(
              $db: $db,
              $table: $db.creditCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalDetailsRefs(
      Expression<bool> Function($$JournalDetailsTableFilterComposer f) f) {
    final $$JournalDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableFilterComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionDetailsRefs(
      Expression<bool> Function($$TransactionDetailsTableFilterComposer f) f) {
    final $$TransactionDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetails,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailsTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CurrenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$CurrenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> creditCardsRefs<T extends Object>(
      Expression<T> Function($$CreditCardsTableAnnotationComposer a) f) {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCards,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardsTableAnnotationComposer(
              $db: $db,
              $table: $db.creditCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalDetailsRefs<T extends Object>(
      Expression<T> Function($$JournalDetailsTableAnnotationComposer a) f) {
    final $$JournalDetailsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionDetailsRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailsTableAnnotationComposer a) f) {
    final $$TransactionDetailsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetails,
            getReferencedColumn: (t) => t.currencyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetails,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CurrenciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CurrenciesTable,
    Currency,
    $$CurrenciesTableFilterComposer,
    $$CurrenciesTableOrderingComposer,
    $$CurrenciesTableAnnotationComposer,
    $$CurrenciesTableCreateCompanionBuilder,
    $$CurrenciesTableUpdateCompanionBuilder,
    (Currency, $$CurrenciesTableReferences),
    Currency,
    PrefetchHooks Function(
        {bool creditCardsRefs,
        bool journalDetailsRefs,
        bool transactionsRefs,
        bool transactionDetailsRefs})> {
  $$CurrenciesTableTableManager(_$AppDatabase db, $CurrenciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrenciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> symbol = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CurrencyCompanion(
            id: id,
            name: name,
            symbol: symbol,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String symbol,
            required double rateExchange,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CurrencyCompanion.insert(
            id: id,
            name: name,
            symbol: symbol,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CurrenciesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {creditCardsRefs = false,
              journalDetailsRefs = false,
              transactionsRefs = false,
              transactionDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (creditCardsRefs) db.creditCards,
                if (journalDetailsRefs) db.journalDetails,
                if (transactionsRefs) db.transactions,
                if (transactionDetailsRefs) db.transactionDetails
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (creditCardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrenciesTableReferences
                            ._creditCardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrenciesTableReferences(db, table, p0)
                                .creditCardsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (journalDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrenciesTableReferences
                            ._journalDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrenciesTableReferences(db, table, p0)
                                .journalDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrenciesTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrenciesTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (transactionDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrenciesTableReferences
                            ._transactionDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrenciesTableReferences(db, table, p0)
                                .transactionDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CurrenciesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CurrenciesTable,
    Currency,
    $$CurrenciesTableFilterComposer,
    $$CurrenciesTableOrderingComposer,
    $$CurrenciesTableAnnotationComposer,
    $$CurrenciesTableCreateCompanionBuilder,
    $$CurrenciesTableUpdateCompanionBuilder,
    (Currency, $$CurrenciesTableReferences),
    Currency,
    PrefetchHooks Function(
        {bool creditCardsRefs,
        bool journalDetailsRefs,
        bool transactionsRefs,
        bool transactionDetailsRefs})>;
typedef $$ChartAccountsTableCreateCompanionBuilder = ChartAccountCompanion
    Function({
  required String id,
  Value<String?> parentId,
  required String accountingTypeId,
  required String code,
  required int level,
  required String name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ChartAccountsTableUpdateCompanionBuilder = ChartAccountCompanion
    Function({
  Value<String> id,
  Value<String?> parentId,
  Value<String> accountingTypeId,
  Value<String> code,
  Value<int> level,
  Value<String> name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ChartAccountsTableReferences
    extends BaseReferences<_$AppDatabase, $ChartAccountsTable, ChartAccount> {
  $$ChartAccountsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChartAccountsTable _parentIdTable(_$AppDatabase db) =>
      db.chartAccounts.createAlias(
          $_aliasNameGenerator(db.chartAccounts.parentId, db.chartAccounts.id));

  $$ChartAccountsTableProcessedTableManager? get parentId {
    if ($_item.parentId == null) return null;
    final manager = $$ChartAccountsTableTableManager($_db, $_db.chartAccounts)
        .filter((f) => f.id($_item.parentId!));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountingTypesTable _accountingTypeIdTable(_$AppDatabase db) =>
      db.accountingTypes.createAlias($_aliasNameGenerator(
          db.chartAccounts.accountingTypeId, db.accountingTypes.id));

  $$AccountingTypesTableProcessedTableManager get accountingTypeId {
    final manager =
        $$AccountingTypesTableTableManager($_db, $_db.accountingTypes)
            .filter((f) => f.id($_item.accountingTypeId!));
    final item = $_typedResult.readTableOrNull(_accountingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CategoriesTable, List<Category>>
      _categoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.categories,
              aliasName: $_aliasNameGenerator(
                  db.chartAccounts.id, db.categories.chartAccountId));

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CreditCardsTable, List<CreditCard>>
      _creditCardsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.creditCards,
              aliasName: $_aliasNameGenerator(
                  db.chartAccounts.id, db.creditCards.chartAccountId));

  $$CreditCardsTableProcessedTableManager get creditCardsRefs {
    final manager = $$CreditCardsTableTableManager($_db, $_db.creditCards)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_creditCardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalDetailsTable, List<JournalDetail>>
      _journalDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetails,
              aliasName: $_aliasNameGenerator(
                  db.chartAccounts.id, db.journalDetails.chartAccountId));

  $$JournalDetailsTableProcessedTableManager get journalDetailsRefs {
    final manager = $$JournalDetailsTableTableManager($_db, $_db.journalDetails)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChartAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $ChartAccountsTable> {
  $$ChartAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ChartAccountsTableFilterComposer get parentId {
    final $$ChartAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableFilterComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypesTableFilterComposer get accountingTypeId {
    final $$AccountingTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypesTableFilterComposer(
              $db: $db,
              $table: $db.accountingTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> categoriesRefs(
      Expression<bool> Function($$CategoriesTableFilterComposer f) f) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> creditCardsRefs(
      Expression<bool> Function($$CreditCardsTableFilterComposer f) f) {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCards,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardsTableFilterComposer(
              $db: $db,
              $table: $db.creditCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalDetailsRefs(
      Expression<bool> Function($$JournalDetailsTableFilterComposer f) f) {
    final $$JournalDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableFilterComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChartAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChartAccountsTable> {
  $$ChartAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ChartAccountsTableOrderingComposer get parentId {
    final $$ChartAccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypesTableOrderingComposer get accountingTypeId {
    final $$AccountingTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypesTableOrderingComposer(
              $db: $db,
              $table: $db.accountingTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChartAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChartAccountsTable> {
  $$ChartAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ChartAccountsTableAnnotationComposer get parentId {
    final $$ChartAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypesTableAnnotationComposer get accountingTypeId {
    final $$AccountingTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.accountingTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> categoriesRefs<T extends Object>(
      Expression<T> Function($$CategoriesTableAnnotationComposer a) f) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> creditCardsRefs<T extends Object>(
      Expression<T> Function($$CreditCardsTableAnnotationComposer a) f) {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCards,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardsTableAnnotationComposer(
              $db: $db,
              $table: $db.creditCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalDetailsRefs<T extends Object>(
      Expression<T> Function($$JournalDetailsTableAnnotationComposer a) f) {
    final $$JournalDetailsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChartAccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChartAccountsTable,
    ChartAccount,
    $$ChartAccountsTableFilterComposer,
    $$ChartAccountsTableOrderingComposer,
    $$ChartAccountsTableAnnotationComposer,
    $$ChartAccountsTableCreateCompanionBuilder,
    $$ChartAccountsTableUpdateCompanionBuilder,
    (ChartAccount, $$ChartAccountsTableReferences),
    ChartAccount,
    PrefetchHooks Function(
        {bool parentId,
        bool accountingTypeId,
        bool categoriesRefs,
        bool creditCardsRefs,
        bool journalDetailsRefs})> {
  $$ChartAccountsTableTableManager(_$AppDatabase db, $ChartAccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChartAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChartAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChartAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String> accountingTypeId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChartAccountCompanion(
            id: id,
            parentId: parentId,
            accountingTypeId: accountingTypeId,
            code: code,
            level: level,
            name: name,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> parentId = const Value.absent(),
            required String accountingTypeId,
            required String code,
            required int level,
            required String name,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChartAccountCompanion.insert(
            id: id,
            parentId: parentId,
            accountingTypeId: accountingTypeId,
            code: code,
            level: level,
            name: name,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChartAccountsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {parentId = false,
              accountingTypeId = false,
              categoriesRefs = false,
              creditCardsRefs = false,
              journalDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoriesRefs) db.categories,
                if (creditCardsRefs) db.creditCards,
                if (journalDetailsRefs) db.journalDetails
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentId,
                    referencedTable:
                        $$ChartAccountsTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$ChartAccountsTableReferences._parentIdTable(db).id,
                  ) as T;
                }
                if (accountingTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.accountingTypeId,
                    referencedTable: $$ChartAccountsTableReferences
                        ._accountingTypeIdTable(db),
                    referencedColumn: $$ChartAccountsTableReferences
                        ._accountingTypeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountsTableReferences
                            ._categoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountsTableReferences(db, table, p0)
                                .categoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items),
                  if (creditCardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountsTableReferences
                            ._creditCardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountsTableReferences(db, table, p0)
                                .creditCardsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items),
                  if (journalDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountsTableReferences
                            ._journalDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountsTableReferences(db, table, p0)
                                .journalDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChartAccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChartAccountsTable,
    ChartAccount,
    $$ChartAccountsTableFilterComposer,
    $$ChartAccountsTableOrderingComposer,
    $$ChartAccountsTableAnnotationComposer,
    $$ChartAccountsTableCreateCompanionBuilder,
    $$ChartAccountsTableUpdateCompanionBuilder,
    (ChartAccount, $$ChartAccountsTableReferences),
    ChartAccount,
    PrefetchHooks Function(
        {bool parentId,
        bool accountingTypeId,
        bool categoriesRefs,
        bool creditCardsRefs,
        bool journalDetailsRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  required String documentTypeId,
  required String chartAccountId,
  required String name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  Value<String> documentTypeId,
  Value<String> chartAccountId,
  Value<String> name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _parentIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
          $_aliasNameGenerator(db.categories.parentId, db.categories.id));

  $$CategoriesTableProcessedTableManager? get parentId {
    if ($_item.parentId == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id($_item.parentId!));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DocumentTypesTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentTypes.createAlias($_aliasNameGenerator(
          db.categories.documentTypeId, db.documentTypes.id));

  $$DocumentTypesTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypesTableTableManager($_db, $_db.documentTypes)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountsTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccounts.createAlias($_aliasNameGenerator(
          db.categories.chartAccountId, db.chartAccounts.id));

  $$ChartAccountsTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountsTableTableManager($_db, $_db.chartAccounts)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionDetailsTable, List<TransactionDetail>>
      _transactionDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetails,
              aliasName: $_aliasNameGenerator(
                  db.categories.id, db.transactionDetails.categoryId));

  $$TransactionDetailsTableProcessedTableManager get transactionDetailsRefs {
    final manager =
        $$TransactionDetailsTableTableManager($_db, $_db.transactionDetails)
            .filter((f) => f.categoryId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get parentId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypesTableFilterComposer get documentTypeId {
    final $$DocumentTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableFilterComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableFilterComposer get chartAccountId {
    final $$ChartAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableFilterComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionDetailsRefs(
      Expression<bool> Function($$TransactionDetailsTableFilterComposer f) f) {
    final $$TransactionDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetails,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailsTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get parentId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypesTableOrderingComposer get documentTypeId {
    final $$DocumentTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableOrderingComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableOrderingComposer get chartAccountId {
    final $$ChartAccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get parentId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypesTableAnnotationComposer get documentTypeId {
    final $$DocumentTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableAnnotationComposer get chartAccountId {
    final $$ChartAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionDetailsRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailsTableAnnotationComposer a) f) {
    final $$TransactionDetailsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetails,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetails,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function(
        {bool parentId,
        bool documentTypeId,
        bool chartAccountId,
        bool transactionDetailsRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<String> chartAccountId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CategoryCompanion(
            id: id,
            parentId: parentId,
            documentTypeId: documentTypeId,
            chartAccountId: chartAccountId,
            name: name,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            required String documentTypeId,
            required String chartAccountId,
            required String name,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CategoryCompanion.insert(
            id: id,
            parentId: parentId,
            documentTypeId: documentTypeId,
            chartAccountId: chartAccountId,
            name: name,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {parentId = false,
              documentTypeId = false,
              chartAccountId = false,
              transactionDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailsRefs) db.transactionDetails
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentId,
                    referencedTable:
                        $$CategoriesTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$CategoriesTableReferences._parentIdTable(db).id,
                  ) as T;
                }
                if (documentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.documentTypeId,
                    referencedTable:
                        $$CategoriesTableReferences._documentTypeIdTable(db),
                    referencedColumn:
                        $$CategoriesTableReferences._documentTypeIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$CategoriesTableReferences._chartAccountIdTable(db),
                    referencedColumn:
                        $$CategoriesTableReferences._chartAccountIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoriesTableReferences
                            ._transactionDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .transactionDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function(
        {bool parentId,
        bool documentTypeId,
        bool chartAccountId,
        bool transactionDetailsRefs})>;
typedef $$ContactsTableCreateCompanionBuilder = ContactCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> note,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> note,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName:
              $_aliasNameGenerator(db.contacts.id, db.transactions.contactId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.contactId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function({bool transactionsRefs})> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ContactCompanion(
            id: id,
            name: name,
            email: email,
            phone: phone,
            note: note,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ContactCompanion.insert(
            id: id,
            name: name,
            email: email,
            phone: phone,
            note: note,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ContactsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function({bool transactionsRefs})>;
typedef $$CreditCardsTableCreateCompanionBuilder = CreditCardCompanion
    Function({
  Value<int> id,
  required String currencyId,
  required String chartAccountId,
  required String name,
  Value<String?> description,
  required double quota,
  required int closingDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$CreditCardsTableUpdateCompanionBuilder = CreditCardCompanion
    Function({
  Value<int> id,
  Value<String> currencyId,
  Value<String> chartAccountId,
  Value<String> name,
  Value<String?> description,
  Value<double> quota,
  Value<int> closingDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$CreditCardsTableReferences
    extends BaseReferences<_$AppDatabase, $CreditCardsTable, CreditCard> {
  $$CreditCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CurrenciesTable _currencyIdTable(_$AppDatabase db) =>
      db.currencies.createAlias(
          $_aliasNameGenerator(db.creditCards.currencyId, db.currencies.id));

  $$CurrenciesTableProcessedTableManager get currencyId {
    final manager = $$CurrenciesTableTableManager($_db, $_db.currencies)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountsTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccounts.createAlias($_aliasNameGenerator(
          db.creditCards.chartAccountId, db.chartAccounts.id));

  $$ChartAccountsTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountsTableTableManager($_db, $_db.chartAccounts)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CreditCardsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quota => $composableBuilder(
      column: $table.quota, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$CurrenciesTableFilterComposer get currencyId {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableFilterComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableFilterComposer get chartAccountId {
    final $$ChartAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableFilterComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quota => $composableBuilder(
      column: $table.quota, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$CurrenciesTableOrderingComposer get currencyId {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableOrderingComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableOrderingComposer get chartAccountId {
    final $$ChartAccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get quota =>
      $composableBuilder(column: $table.quota, builder: (column) => column);

  GeneratedColumn<int> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CurrenciesTableAnnotationComposer get currencyId {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableAnnotationComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableAnnotationComposer get chartAccountId {
    final $$ChartAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CreditCardsTable,
    CreditCard,
    $$CreditCardsTableFilterComposer,
    $$CreditCardsTableOrderingComposer,
    $$CreditCardsTableAnnotationComposer,
    $$CreditCardsTableCreateCompanionBuilder,
    $$CreditCardsTableUpdateCompanionBuilder,
    (CreditCard, $$CreditCardsTableReferences),
    CreditCard,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})> {
  $$CreditCardsTableTableManager(_$AppDatabase db, $CreditCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<String> chartAccountId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> quota = const Value.absent(),
            Value<int> closingDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CreditCardCompanion(
            id: id,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            name: name,
            description: description,
            quota: quota,
            closingDate: closingDate,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String currencyId,
            required String chartAccountId,
            required String name,
            Value<String?> description = const Value.absent(),
            required double quota,
            required int closingDate,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CreditCardCompanion.insert(
            id: id,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            name: name,
            description: description,
            quota: quota,
            closingDate: closingDate,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CreditCardsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {currencyId = false, chartAccountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$CreditCardsTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$CreditCardsTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$CreditCardsTableReferences._chartAccountIdTable(db),
                    referencedColumn: $$CreditCardsTableReferences
                        ._chartAccountIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CreditCardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CreditCardsTable,
    CreditCard,
    $$CreditCardsTableFilterComposer,
    $$CreditCardsTableOrderingComposer,
    $$CreditCardsTableAnnotationComposer,
    $$CreditCardsTableCreateCompanionBuilder,
    $$CreditCardsTableUpdateCompanionBuilder,
    (CreditCard, $$CreditCardsTableReferences),
    CreditCard,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})>;
typedef $$JournalTableCreateCompanionBuilder = JournalCompanion Function({
  Value<int> id,
  required String documentTypeId,
  required int secuencial,
  required DateTime date,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$JournalTableUpdateCompanionBuilder = JournalCompanion Function({
  Value<int> id,
  Value<String> documentTypeId,
  Value<int> secuencial,
  Value<DateTime> date,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$JournalTableReferences
    extends BaseReferences<_$AppDatabase, $JournalTable, Journal> {
  $$JournalTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypesTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentTypes.createAlias(
          $_aliasNameGenerator(db.journal.documentTypeId, db.documentTypes.id));

  $$DocumentTypesTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypesTableTableManager($_db, $_db.documentTypes)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$JournalDetailsTable, List<JournalDetail>>
      _journalDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetails,
              aliasName: $_aliasNameGenerator(
                  db.journal.id, db.journalDetails.journalId));

  $$JournalDetailsTableProcessedTableManager get journalDetailsRefs {
    final manager = $$JournalDetailsTableTableManager($_db, $_db.journalDetails)
        .filter((f) => f.journalId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName:
              $_aliasNameGenerator(db.journal.id, db.transactions.journalId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.journalId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$JournalTableFilterComposer
    extends Composer<_$AppDatabase, $JournalTable> {
  $$JournalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$DocumentTypesTableFilterComposer get documentTypeId {
    final $$DocumentTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableFilterComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> journalDetailsRefs(
      Expression<bool> Function($$JournalDetailsTableFilterComposer f) f) {
    final $$JournalDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableFilterComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JournalTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalTable> {
  $$JournalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$DocumentTypesTableOrderingComposer get documentTypeId {
    final $$DocumentTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableOrderingComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalTable> {
  $$JournalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$DocumentTypesTableAnnotationComposer get documentTypeId {
    final $$DocumentTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> journalDetailsRefs<T extends Object>(
      Expression<T> Function($$JournalDetailsTableAnnotationComposer a) f) {
    final $$JournalDetailsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetails,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailsTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JournalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JournalTable,
    Journal,
    $$JournalTableFilterComposer,
    $$JournalTableOrderingComposer,
    $$JournalTableAnnotationComposer,
    $$JournalTableCreateCompanionBuilder,
    $$JournalTableUpdateCompanionBuilder,
    (Journal, $$JournalTableReferences),
    Journal,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool journalDetailsRefs,
        bool transactionsRefs})> {
  $$JournalTableTableManager(_$AppDatabase db, $JournalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<int> secuencial = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              JournalCompanion(
            id: id,
            documentTypeId: documentTypeId,
            secuencial: secuencial,
            date: date,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String documentTypeId,
            required int secuencial,
            required DateTime date,
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              JournalCompanion.insert(
            id: id,
            documentTypeId: documentTypeId,
            secuencial: secuencial,
            date: date,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$JournalTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              journalDetailsRefs = false,
              transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (journalDetailsRefs) db.journalDetails,
                if (transactionsRefs) db.transactions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (documentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.documentTypeId,
                    referencedTable:
                        $$JournalTableReferences._documentTypeIdTable(db),
                    referencedColumn:
                        $$JournalTableReferences._documentTypeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (journalDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$JournalTableReferences
                            ._journalDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JournalTableReferences(db, table, p0)
                                .journalDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journalId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$JournalTableReferences._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JournalTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$JournalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JournalTable,
    Journal,
    $$JournalTableFilterComposer,
    $$JournalTableOrderingComposer,
    $$JournalTableAnnotationComposer,
    $$JournalTableCreateCompanionBuilder,
    $$JournalTableUpdateCompanionBuilder,
    (Journal, $$JournalTableReferences),
    Journal,
    PrefetchHooks Function(
        {bool documentTypeId, bool journalDetailsRefs, bool transactionsRefs})>;
typedef $$JournalDetailsTableCreateCompanionBuilder = JournalDetailCompanion
    Function({
  Value<int> id,
  required int journalId,
  required String currencyId,
  required String chartAccountId,
  required double credit,
  required double debit,
  required double rateExchange,
});
typedef $$JournalDetailsTableUpdateCompanionBuilder = JournalDetailCompanion
    Function({
  Value<int> id,
  Value<int> journalId,
  Value<String> currencyId,
  Value<String> chartAccountId,
  Value<double> credit,
  Value<double> debit,
  Value<double> rateExchange,
});

final class $$JournalDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $JournalDetailsTable, JournalDetail> {
  $$JournalDetailsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $JournalTable _journalIdTable(_$AppDatabase db) =>
      db.journal.createAlias(
          $_aliasNameGenerator(db.journalDetails.journalId, db.journal.id));

  $$JournalTableProcessedTableManager get journalId {
    final manager = $$JournalTableTableManager($_db, $_db.journal)
        .filter((f) => f.id($_item.journalId!));
    final item = $_typedResult.readTableOrNull(_journalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrenciesTable _currencyIdTable(_$AppDatabase db) =>
      db.currencies.createAlias(
          $_aliasNameGenerator(db.journalDetails.currencyId, db.currencies.id));

  $$CurrenciesTableProcessedTableManager get currencyId {
    final manager = $$CurrenciesTableTableManager($_db, $_db.currencies)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountsTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccounts.createAlias($_aliasNameGenerator(
          db.journalDetails.chartAccountId, db.chartAccounts.id));

  $$ChartAccountsTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountsTableTableManager($_db, $_db.chartAccounts)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$JournalDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $JournalDetailsTable> {
  $$JournalDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get credit => $composableBuilder(
      column: $table.credit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get debit => $composableBuilder(
      column: $table.debit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => ColumnFilters(column));

  $$JournalTableFilterComposer get journalId {
    final $$JournalTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableFilterComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableFilterComposer get currencyId {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableFilterComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableFilterComposer get chartAccountId {
    final $$ChartAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableFilterComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalDetailsTable> {
  $$JournalDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get credit => $composableBuilder(
      column: $table.credit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get debit => $composableBuilder(
      column: $table.debit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange,
      builder: (column) => ColumnOrderings(column));

  $$JournalTableOrderingComposer get journalId {
    final $$JournalTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableOrderingComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableOrderingComposer get currencyId {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableOrderingComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableOrderingComposer get chartAccountId {
    final $$ChartAccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalDetailsTable> {
  $$JournalDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get credit =>
      $composableBuilder(column: $table.credit, builder: (column) => column);

  GeneratedColumn<double> get debit =>
      $composableBuilder(column: $table.debit, builder: (column) => column);

  GeneratedColumn<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => column);

  $$JournalTableAnnotationComposer get journalId {
    final $$JournalTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableAnnotationComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableAnnotationComposer get currencyId {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableAnnotationComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountsTableAnnotationComposer get chartAccountId {
    final $$ChartAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JournalDetailsTable,
    JournalDetail,
    $$JournalDetailsTableFilterComposer,
    $$JournalDetailsTableOrderingComposer,
    $$JournalDetailsTableAnnotationComposer,
    $$JournalDetailsTableCreateCompanionBuilder,
    $$JournalDetailsTableUpdateCompanionBuilder,
    (JournalDetail, $$JournalDetailsTableReferences),
    JournalDetail,
    PrefetchHooks Function(
        {bool journalId, bool currencyId, bool chartAccountId})> {
  $$JournalDetailsTableTableManager(
      _$AppDatabase db, $JournalDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> journalId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<String> chartAccountId = const Value.absent(),
            Value<double> credit = const Value.absent(),
            Value<double> debit = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
          }) =>
              JournalDetailCompanion(
            id: id,
            journalId: journalId,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            credit: credit,
            debit: debit,
            rateExchange: rateExchange,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int journalId,
            required String currencyId,
            required String chartAccountId,
            required double credit,
            required double debit,
            required double rateExchange,
          }) =>
              JournalDetailCompanion.insert(
            id: id,
            journalId: journalId,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            credit: credit,
            debit: debit,
            rateExchange: rateExchange,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$JournalDetailsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {journalId = false, currencyId = false, chartAccountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (journalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journalId,
                    referencedTable:
                        $$JournalDetailsTableReferences._journalIdTable(db),
                    referencedColumn:
                        $$JournalDetailsTableReferences._journalIdTable(db).id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$JournalDetailsTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$JournalDetailsTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable: $$JournalDetailsTableReferences
                        ._chartAccountIdTable(db),
                    referencedColumn: $$JournalDetailsTableReferences
                        ._chartAccountIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$JournalDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JournalDetailsTable,
    JournalDetail,
    $$JournalDetailsTableFilterComposer,
    $$JournalDetailsTableOrderingComposer,
    $$JournalDetailsTableAnnotationComposer,
    $$JournalDetailsTableCreateCompanionBuilder,
    $$JournalDetailsTableUpdateCompanionBuilder,
    (JournalDetail, $$JournalDetailsTableReferences),
    JournalDetail,
    PrefetchHooks Function(
        {bool journalId, bool currencyId, bool chartAccountId})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionCompanion
    Function({
  Value<int> id,
  required String documentTypeId,
  required String currencyId,
  required int journalId,
  Value<int?> contactId,
  required int secuencial,
  required DateTime date,
  required double amount,
  required double rateExchange,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionCompanion
    Function({
  Value<int> id,
  Value<String> documentTypeId,
  Value<String> currencyId,
  Value<int> journalId,
  Value<int?> contactId,
  Value<int> secuencial,
  Value<DateTime> date,
  Value<double> amount,
  Value<double> rateExchange,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypesTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentTypes.createAlias($_aliasNameGenerator(
          db.transactions.documentTypeId, db.documentTypes.id));

  $$DocumentTypesTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypesTableTableManager($_db, $_db.documentTypes)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrenciesTable _currencyIdTable(_$AppDatabase db) =>
      db.currencies.createAlias(
          $_aliasNameGenerator(db.transactions.currencyId, db.currencies.id));

  $$CurrenciesTableProcessedTableManager get currencyId {
    final manager = $$CurrenciesTableTableManager($_db, $_db.currencies)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $JournalTable _journalIdTable(_$AppDatabase db) =>
      db.journal.createAlias(
          $_aliasNameGenerator(db.transactions.journalId, db.journal.id));

  $$JournalTableProcessedTableManager get journalId {
    final manager = $$JournalTableTableManager($_db, $_db.journal)
        .filter((f) => f.id($_item.journalId!));
    final item = $_typedResult.readTableOrNull(_journalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.transactions.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager? get contactId {
    if ($_item.contactId == null) return null;
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionDetailsTable, List<TransactionDetail>>
      _transactionDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetails,
              aliasName: $_aliasNameGenerator(
                  db.transactions.id, db.transactionDetails.transactionId));

  $$TransactionDetailsTableProcessedTableManager get transactionDetailsRefs {
    final manager =
        $$TransactionDetailsTableTableManager($_db, $_db.transactionDetails)
            .filter((f) => f.transactionId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$DocumentTypesTableFilterComposer get documentTypeId {
    final $$DocumentTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableFilterComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableFilterComposer get currencyId {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableFilterComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalTableFilterComposer get journalId {
    final $$JournalTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableFilterComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionDetailsRefs(
      Expression<bool> Function($$TransactionDetailsTableFilterComposer f) f) {
    final $$TransactionDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetails,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailsTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$DocumentTypesTableOrderingComposer get documentTypeId {
    final $$DocumentTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableOrderingComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableOrderingComposer get currencyId {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableOrderingComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalTableOrderingComposer get journalId {
    final $$JournalTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableOrderingComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get secuencial => $composableBuilder(
      column: $table.secuencial, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$DocumentTypesTableAnnotationComposer get documentTypeId {
    final $$DocumentTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.documentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableAnnotationComposer get currencyId {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableAnnotationComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalTableAnnotationComposer get journalId {
    final $$JournalTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journal,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalTableAnnotationComposer(
              $db: $db,
              $table: $db.journal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionDetailsRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailsTableAnnotationComposer a) f) {
    final $$TransactionDetailsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetails,
            getReferencedColumn: (t) => t.transactionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetails,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool journalId,
        bool contactId,
        bool transactionDetailsRefs})> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> journalId = const Value.absent(),
            Value<int?> contactId = const Value.absent(),
            Value<int> secuencial = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              TransactionCompanion(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            journalId: journalId,
            contactId: contactId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String documentTypeId,
            required String currencyId,
            required int journalId,
            Value<int?> contactId = const Value.absent(),
            required int secuencial,
            required DateTime date,
            required double amount,
            required double rateExchange,
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              TransactionCompanion.insert(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            journalId: journalId,
            contactId: contactId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              currencyId = false,
              journalId = false,
              contactId = false,
              transactionDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailsRefs) db.transactionDetails
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (documentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.documentTypeId,
                    referencedTable:
                        $$TransactionsTableReferences._documentTypeIdTable(db),
                    referencedColumn: $$TransactionsTableReferences
                        ._documentTypeIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$TransactionsTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (journalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journalId,
                    referencedTable:
                        $$TransactionsTableReferences._journalIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._journalIdTable(db).id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$TransactionsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._contactIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TransactionsTableReferences
                            ._transactionDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionsTableReferences(db, table, p0)
                                .transactionDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transactionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool journalId,
        bool contactId,
        bool transactionDetailsRefs})>;
typedef $$TransactionDetailsTableCreateCompanionBuilder
    = TransactionDetailCompanion Function({
  Value<int> id,
  required int transactionId,
  required String currencyId,
  required String flowId,
  required String paymentTypeId,
  required int paymentId,
  required int categoryId,
  required double amount,
  required double rateExchange,
});
typedef $$TransactionDetailsTableUpdateCompanionBuilder
    = TransactionDetailCompanion Function({
  Value<int> id,
  Value<int> transactionId,
  Value<String> currencyId,
  Value<String> flowId,
  Value<String> paymentTypeId,
  Value<int> paymentId,
  Value<int> categoryId,
  Value<double> amount,
  Value<double> rateExchange,
});

final class $$TransactionDetailsTableReferences extends BaseReferences<
    _$AppDatabase, $TransactionDetailsTable, TransactionDetail> {
  $$TransactionDetailsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TransactionsTable _transactionIdTable(_$AppDatabase db) =>
      db.transactions.createAlias($_aliasNameGenerator(
          db.transactionDetails.transactionId, db.transactions.id));

  $$TransactionsTableProcessedTableManager get transactionId {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.id($_item.transactionId!));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrenciesTable _currencyIdTable(_$AppDatabase db) =>
      db.currencies.createAlias($_aliasNameGenerator(
          db.transactionDetails.currencyId, db.currencies.id));

  $$CurrenciesTableProcessedTableManager get currencyId {
    final manager = $$CurrenciesTableTableManager($_db, $_db.currencies)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FlowTypesTable _flowIdTable(_$AppDatabase db) =>
      db.flowTypes.createAlias(
          $_aliasNameGenerator(db.transactionDetails.flowId, db.flowTypes.id));

  $$FlowTypesTableProcessedTableManager get flowId {
    final manager = $$FlowTypesTableTableManager($_db, $_db.flowTypes)
        .filter((f) => f.id($_item.flowId!));
    final item = $_typedResult.readTableOrNull(_flowIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PaymentTypesTable _paymentTypeIdTable(_$AppDatabase db) =>
      db.paymentTypes.createAlias($_aliasNameGenerator(
          db.transactionDetails.paymentTypeId, db.paymentTypes.id));

  $$PaymentTypesTableProcessedTableManager get paymentTypeId {
    final manager = $$PaymentTypesTableTableManager($_db, $_db.paymentTypes)
        .filter((f) => f.id($_item.paymentTypeId!));
    final item = $_typedResult.readTableOrNull(_paymentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias($_aliasNameGenerator(
          db.transactionDetails.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager get categoryId {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id($_item.categoryId!));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionDetailsTable> {
  $$TransactionDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => ColumnFilters(column));

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableFilterComposer get currencyId {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableFilterComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypesTableFilterComposer get flowId {
    final $$FlowTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypesTableFilterComposer(
              $db: $db,
              $table: $db.flowTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypesTableFilterComposer get paymentTypeId {
    final $$PaymentTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypesTableFilterComposer(
              $db: $db,
              $table: $db.paymentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionDetailsTable> {
  $$TransactionDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange,
      builder: (column) => ColumnOrderings(column));

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableOrderingComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableOrderingComposer get currencyId {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableOrderingComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypesTableOrderingComposer get flowId {
    final $$FlowTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypesTableOrderingComposer(
              $db: $db,
              $table: $db.flowTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypesTableOrderingComposer get paymentTypeId {
    final $$PaymentTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypesTableOrderingComposer(
              $db: $db,
              $table: $db.paymentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionDetailsTable> {
  $$TransactionDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrenciesTableAnnotationComposer get currencyId {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currencies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrenciesTableAnnotationComposer(
              $db: $db,
              $table: $db.currencies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypesTableAnnotationComposer get flowId {
    final $$FlowTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.flowTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypesTableAnnotationComposer get paymentTypeId {
    final $$PaymentTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.paymentTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionDetailsTable,
    TransactionDetail,
    $$TransactionDetailsTableFilterComposer,
    $$TransactionDetailsTableOrderingComposer,
    $$TransactionDetailsTableAnnotationComposer,
    $$TransactionDetailsTableCreateCompanionBuilder,
    $$TransactionDetailsTableUpdateCompanionBuilder,
    (TransactionDetail, $$TransactionDetailsTableReferences),
    TransactionDetail,
    PrefetchHooks Function(
        {bool transactionId,
        bool currencyId,
        bool flowId,
        bool paymentTypeId,
        bool categoryId})> {
  $$TransactionDetailsTableTableManager(
      _$AppDatabase db, $TransactionDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionDetailsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> transactionId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<String> flowId = const Value.absent(),
            Value<String> paymentTypeId = const Value.absent(),
            Value<int> paymentId = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
          }) =>
              TransactionDetailCompanion(
            id: id,
            transactionId: transactionId,
            currencyId: currencyId,
            flowId: flowId,
            paymentTypeId: paymentTypeId,
            paymentId: paymentId,
            categoryId: categoryId,
            amount: amount,
            rateExchange: rateExchange,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int transactionId,
            required String currencyId,
            required String flowId,
            required String paymentTypeId,
            required int paymentId,
            required int categoryId,
            required double amount,
            required double rateExchange,
          }) =>
              TransactionDetailCompanion.insert(
            id: id,
            transactionId: transactionId,
            currencyId: currencyId,
            flowId: flowId,
            paymentTypeId: paymentTypeId,
            paymentId: paymentId,
            categoryId: categoryId,
            amount: amount,
            rateExchange: rateExchange,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionDetailsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {transactionId = false,
              currencyId = false,
              flowId = false,
              paymentTypeId = false,
              categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (transactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transactionId,
                    referencedTable: $$TransactionDetailsTableReferences
                        ._transactionIdTable(db),
                    referencedColumn: $$TransactionDetailsTableReferences
                        ._transactionIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable: $$TransactionDetailsTableReferences
                        ._currencyIdTable(db),
                    referencedColumn: $$TransactionDetailsTableReferences
                        ._currencyIdTable(db)
                        .id,
                  ) as T;
                }
                if (flowId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.flowId,
                    referencedTable:
                        $$TransactionDetailsTableReferences._flowIdTable(db),
                    referencedColumn:
                        $$TransactionDetailsTableReferences._flowIdTable(db).id,
                  ) as T;
                }
                if (paymentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paymentTypeId,
                    referencedTable: $$TransactionDetailsTableReferences
                        ._paymentTypeIdTable(db),
                    referencedColumn: $$TransactionDetailsTableReferences
                        ._paymentTypeIdTable(db)
                        .id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$TransactionDetailsTableReferences
                        ._categoryIdTable(db),
                    referencedColumn: $$TransactionDetailsTableReferences
                        ._categoryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransactionDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionDetailsTable,
    TransactionDetail,
    $$TransactionDetailsTableFilterComposer,
    $$TransactionDetailsTableOrderingComposer,
    $$TransactionDetailsTableAnnotationComposer,
    $$TransactionDetailsTableCreateCompanionBuilder,
    $$TransactionDetailsTableUpdateCompanionBuilder,
    (TransactionDetail, $$TransactionDetailsTableReferences),
    TransactionDetail,
    PrefetchHooks Function(
        {bool transactionId,
        bool currencyId,
        bool flowId,
        bool paymentTypeId,
        bool categoryId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountingTypesTableTableManager get accountingTypes =>
      $$AccountingTypesTableTableManager(_db, _db.accountingTypes);
  $$DocumentTypesTableTableManager get documentTypes =>
      $$DocumentTypesTableTableManager(_db, _db.documentTypes);
  $$FlowTypesTableTableManager get flowTypes =>
      $$FlowTypesTableTableManager(_db, _db.flowTypes);
  $$PaymentTypesTableTableManager get paymentTypes =>
      $$PaymentTypesTableTableManager(_db, _db.paymentTypes);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db, _db.currencies);
  $$ChartAccountsTableTableManager get chartAccounts =>
      $$ChartAccountsTableTableManager(_db, _db.chartAccounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db, _db.creditCards);
  $$JournalTableTableManager get journal =>
      $$JournalTableTableManager(_db, _db.journal);
  $$JournalDetailsTableTableManager get journalDetails =>
      $$JournalDetailsTableTableManager(_db, _db.journalDetails);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$TransactionDetailsTableTableManager get transactionDetails =>
      $$TransactionDetailsTableTableManager(_db, _db.transactionDetails);
}
