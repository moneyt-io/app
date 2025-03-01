// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountingTypeTable extends AccountingType
    with TableInfo<$AccountingTypeTable, AccountingTypes> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountingTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'accounting_type';
  @override
  VerificationContext validateIntegrity(Insertable<AccountingTypes> instance,
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
  AccountingTypes map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountingTypes(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AccountingTypeTable createAlias(String alias) {
    return $AccountingTypeTable(attachedDatabase, alias);
  }
}

class AccountingTypes extends DataClass implements Insertable<AccountingTypes> {
  final String id;
  final String name;
  const AccountingTypes({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AccountingTypesCompanion toCompanion(bool nullToAbsent) {
    return AccountingTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory AccountingTypes.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountingTypes(
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

  AccountingTypes copyWith({String? id, String? name}) => AccountingTypes(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  AccountingTypes copyWithCompanion(AccountingTypesCompanion data) {
    return AccountingTypes(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountingTypes(')
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
      (other is AccountingTypes &&
          other.id == this.id &&
          other.name == this.name);
}

class AccountingTypesCompanion extends UpdateCompanion<AccountingTypes> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const AccountingTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountingTypesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<AccountingTypes> custom({
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

  AccountingTypesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return AccountingTypesCompanion(
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
    return (StringBuffer('AccountingTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentTypeTable extends DocumentType
    with TableInfo<$DocumentTypeTable, DocumentTypes> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'document_type';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentTypes> instance,
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
  DocumentTypes map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentTypes(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DocumentTypeTable createAlias(String alias) {
    return $DocumentTypeTable(attachedDatabase, alias);
  }
}

class DocumentTypes extends DataClass implements Insertable<DocumentTypes> {
  final String id;
  final String name;
  const DocumentTypes({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DocumentTypesCompanion toCompanion(bool nullToAbsent) {
    return DocumentTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory DocumentTypes.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentTypes(
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

  DocumentTypes copyWith({String? id, String? name}) => DocumentTypes(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  DocumentTypes copyWithCompanion(DocumentTypesCompanion data) {
    return DocumentTypes(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTypes(')
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
      (other is DocumentTypes &&
          other.id == this.id &&
          other.name == this.name);
}

class DocumentTypesCompanion extends UpdateCompanion<DocumentTypes> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const DocumentTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentTypesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<DocumentTypes> custom({
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

  DocumentTypesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return DocumentTypesCompanion(
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
    return (StringBuffer('DocumentTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlowTypeTable extends FlowType
    with TableInfo<$FlowTypeTable, FlowTypes> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlowTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'flow_type';
  @override
  VerificationContext validateIntegrity(Insertable<FlowTypes> instance,
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
  FlowTypes map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlowTypes(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $FlowTypeTable createAlias(String alias) {
    return $FlowTypeTable(attachedDatabase, alias);
  }
}

class FlowTypes extends DataClass implements Insertable<FlowTypes> {
  final String id;
  final String name;
  const FlowTypes({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  FlowTypesCompanion toCompanion(bool nullToAbsent) {
    return FlowTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory FlowTypes.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlowTypes(
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

  FlowTypes copyWith({String? id, String? name}) => FlowTypes(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  FlowTypes copyWithCompanion(FlowTypesCompanion data) {
    return FlowTypes(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlowTypes(')
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
      (other is FlowTypes && other.id == this.id && other.name == this.name);
}

class FlowTypesCompanion extends UpdateCompanion<FlowTypes> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const FlowTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlowTypesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<FlowTypes> custom({
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

  FlowTypesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return FlowTypesCompanion(
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
    return (StringBuffer('FlowTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentTypeTable extends PaymentType
    with TableInfo<$PaymentTypeTable, PaymentTypes> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'payment_type';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentTypes> instance,
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
  PaymentTypes map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentTypes(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $PaymentTypeTable createAlias(String alias) {
    return $PaymentTypeTable(attachedDatabase, alias);
  }
}

class PaymentTypes extends DataClass implements Insertable<PaymentTypes> {
  final String id;
  final String name;
  const PaymentTypes({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PaymentTypesCompanion toCompanion(bool nullToAbsent) {
    return PaymentTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory PaymentTypes.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentTypes(
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

  PaymentTypes copyWith({String? id, String? name}) => PaymentTypes(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  PaymentTypes copyWithCompanion(PaymentTypesCompanion data) {
    return PaymentTypes(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentTypes(')
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
      (other is PaymentTypes && other.id == this.id && other.name == this.name);
}

class PaymentTypesCompanion extends UpdateCompanion<PaymentTypes> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const PaymentTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentTypesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PaymentTypes> custom({
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

  PaymentTypesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return PaymentTypesCompanion(
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
    return (StringBuffer('PaymentTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurrencyTable extends Currency
    with TableInfo<$CurrencyTable, Currencies> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrencyTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name, symbol, rateExchange];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currency';
  @override
  VerificationContext validateIntegrity(Insertable<Currencies> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Currencies map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Currencies(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symbol'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
    );
  }

  @override
  $CurrencyTable createAlias(String alias) {
    return $CurrencyTable(attachedDatabase, alias);
  }
}

class Currencies extends DataClass implements Insertable<Currencies> {
  final String id;
  final String name;
  final String symbol;
  final double rateExchange;
  const Currencies(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.rateExchange});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['symbol'] = Variable<String>(symbol);
    map['rate_exchange'] = Variable<double>(rateExchange);
    return map;
  }

  CurrenciesCompanion toCompanion(bool nullToAbsent) {
    return CurrenciesCompanion(
      id: Value(id),
      name: Value(name),
      symbol: Value(symbol),
      rateExchange: Value(rateExchange),
    );
  }

  factory Currencies.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Currencies(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      symbol: serializer.fromJson<String>(json['symbol']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
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
    };
  }

  Currencies copyWith(
          {String? id, String? name, String? symbol, double? rateExchange}) =>
      Currencies(
        id: id ?? this.id,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        rateExchange: rateExchange ?? this.rateExchange,
      );
  Currencies copyWithCompanion(CurrenciesCompanion data) {
    return Currencies(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Currencies(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateExchange: $rateExchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, symbol, rateExchange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Currencies &&
          other.id == this.id &&
          other.name == this.name &&
          other.symbol == this.symbol &&
          other.rateExchange == this.rateExchange);
}

class CurrenciesCompanion extends UpdateCompanion<Currencies> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> symbol;
  final Value<double> rateExchange;
  final Value<int> rowid;
  const CurrenciesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrenciesCompanion.insert({
    required String id,
    required String name,
    required String symbol,
    required double rateExchange,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        symbol = Value(symbol),
        rateExchange = Value(rateExchange);
  static Insertable<Currencies> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? symbol,
    Expression<double>? rateExchange,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (symbol != null) 'symbol': symbol,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrenciesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? symbol,
      Value<double>? rateExchange,
      Value<int>? rowid}) {
    return CurrenciesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      rateExchange: rateExchange ?? this.rateExchange,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrenciesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChartAccountTable extends ChartAccount
    with TableInfo<$ChartAccountTable, ChartAccounts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChartAccountTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES chart_account (id)'));
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
          'REFERENCES accounting_type (id)'));
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
  static const String $name = 'chart_account';
  @override
  VerificationContext validateIntegrity(Insertable<ChartAccounts> instance,
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChartAccounts map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChartAccounts(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
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
  $ChartAccountTable createAlias(String alias) {
    return $ChartAccountTable(attachedDatabase, alias);
  }
}

class ChartAccounts extends DataClass implements Insertable<ChartAccounts> {
  final int id;
  final int? parentId;
  final String accountingTypeId;
  final String code;
  final int level;
  final String name;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const ChartAccounts(
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
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
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

  ChartAccountsCompanion toCompanion(bool nullToAbsent) {
    return ChartAccountsCompanion(
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

  factory ChartAccounts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChartAccounts(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
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
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
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

  ChartAccounts copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? accountingTypeId,
          String? code,
          int? level,
          String? name,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ChartAccounts(
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
  ChartAccounts copyWithCompanion(ChartAccountsCompanion data) {
    return ChartAccounts(
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
    return (StringBuffer('ChartAccounts(')
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
      (other is ChartAccounts &&
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

class ChartAccountsCompanion extends UpdateCompanion<ChartAccounts> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> accountingTypeId;
  final Value<String> code;
  final Value<int> level;
  final Value<String> name;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const ChartAccountsCompanion({
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
  });
  ChartAccountsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String accountingTypeId,
    required String code,
    required int level,
    required String name,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : accountingTypeId = Value(accountingTypeId),
        code = Value(code),
        level = Value(level),
        name = Value(name);
  static Insertable<ChartAccounts> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? accountingTypeId,
    Expression<String>? code,
    Expression<int>? level,
    Expression<String>? name,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
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
    });
  }

  ChartAccountsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? accountingTypeId,
      Value<String>? code,
      Value<int>? level,
      Value<String>? name,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return ChartAccountsCompanion(
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChartAccountsCompanion(')
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
}

class $CategoryTable extends Category
    with TableInfo<$CategoryTable, Categories> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES category (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES document_type (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<int> chartAccountId = GeneratedColumn<int>(
      'chart_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_account (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
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
        icon,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
  @override
  VerificationContext validateIntegrity(Insertable<Categories> instance,
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
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
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
  Categories map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categories(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      chartAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chart_account_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
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
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class Categories extends DataClass implements Insertable<Categories> {
  final int id;
  final int? parentId;
  final String documentTypeId;
  final int chartAccountId;
  final String name;
  final String icon;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Categories(
      {required this.id,
      this.parentId,
      required this.documentTypeId,
      required this.chartAccountId,
      required this.name,
      required this.icon,
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
    map['chart_account_id'] = Variable<int>(chartAccountId);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
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

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      documentTypeId: Value(documentTypeId),
      chartAccountId: Value(chartAccountId),
      name: Value(name),
      icon: Value(icon),
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

  factory Categories.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categories(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      chartAccountId: serializer.fromJson<int>(json['chartAccountId']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
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
      'chartAccountId': serializer.toJson<int>(chartAccountId),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Categories copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? documentTypeId,
          int? chartAccountId,
          String? name,
          String? icon,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Categories(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Categories copyWithCompanion(CategoriesCompanion data) {
    return Categories(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      chartAccountId: data.chartAccountId.present
          ? data.chartAccountId.value
          : this.chartAccountId,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categories(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, documentTypeId, chartAccountId,
      name, icon, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categories &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.documentTypeId == this.documentTypeId &&
          other.chartAccountId == this.chartAccountId &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CategoriesCompanion extends UpdateCompanion<Categories> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> documentTypeId;
  final Value<int> chartAccountId;
  final Value<String> name;
  final Value<String> icon;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String documentTypeId,
    required int chartAccountId,
    required String name,
    required String icon,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        chartAccountId = Value(chartAccountId),
        name = Value(name),
        icon = Value(icon);
  static Insertable<Categories> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? documentTypeId,
    Expression<int>? chartAccountId,
    Expression<String>? name,
    Expression<String>? icon,
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
      if (icon != null) 'icon': icon,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? documentTypeId,
      Value<int>? chartAccountId,
      Value<String>? name,
      Value<String>? icon,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
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
      map['chart_account_id'] = Variable<int>(chartAccountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
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
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactTable extends Contact with TableInfo<$ContactTable, Contacts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'contact';
  @override
  VerificationContext validateIntegrity(Insertable<Contacts> instance,
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
  Contacts map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contacts(
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
  $ContactTable createAlias(String alias) {
    return $ContactTable(attachedDatabase, alias);
  }
}

class Contacts extends DataClass implements Insertable<Contacts> {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? note;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Contacts(
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

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
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

  factory Contacts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contacts(
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

  Contacts copyWith(
          {int? id,
          String? name,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> note = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Contacts(
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
  Contacts copyWithCompanion(ContactsCompanion data) {
    return Contacts(
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
    return (StringBuffer('Contacts(')
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
      (other is Contacts &&
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

class ContactsCompanion extends UpdateCompanion<Contacts> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> note;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const ContactsCompanion({
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
  ContactsCompanion.insert({
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
  static Insertable<Contacts> custom({
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

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? note,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return ContactsCompanion(
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
    return (StringBuffer('ContactsCompanion(')
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

class $WalletTable extends Wallet with TableInfo<$WalletTable, Wallets> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<int> chartAccountId = GeneratedColumn<int>(
      'chart_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_account (id)'));
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
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet';
  @override
  VerificationContext validateIntegrity(Insertable<Wallets> instance,
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
  Wallets map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wallets(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      chartAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chart_account_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
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
  $WalletTable createAlias(String alias) {
    return $WalletTable(attachedDatabase, alias);
  }
}

class Wallets extends DataClass implements Insertable<Wallets> {
  final int id;
  final String currencyId;
  final int chartAccountId;
  final String name;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Wallets(
      {required this.id,
      required this.currencyId,
      required this.chartAccountId,
      required this.name,
      this.description,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_id'] = Variable<String>(currencyId);
    map['chart_account_id'] = Variable<int>(chartAccountId);
    map['name'] = Variable<String>(name);
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

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      id: Value(id),
      currencyId: Value(currencyId),
      chartAccountId: Value(chartAccountId),
      name: Value(name),
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

  factory Wallets.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallets(
      id: serializer.fromJson<int>(json['id']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      chartAccountId: serializer.fromJson<int>(json['chartAccountId']),
      name: serializer.fromJson<String>(json['name']),
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
      'currencyId': serializer.toJson<String>(currencyId),
      'chartAccountId': serializer.toJson<int>(chartAccountId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Wallets copyWith(
          {int? id,
          String? currencyId,
          int? chartAccountId,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Wallets(
        id: id ?? this.id,
        currencyId: currencyId ?? this.currencyId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Wallets copyWithCompanion(WalletsCompanion data) {
    return Wallets(
      id: data.id.present ? data.id.value : this.id,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      chartAccountId: data.chartAccountId.present
          ? data.chartAccountId.value
          : this.chartAccountId,
      name: data.name.present ? data.name.value : this.name,
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
    return (StringBuffer('Wallets(')
          ..write('id: $id, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currencyId, chartAccountId, name,
      description, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallets &&
          other.id == this.id &&
          other.currencyId == this.currencyId &&
          other.chartAccountId == this.chartAccountId &&
          other.name == this.name &&
          other.description == this.description &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class WalletsCompanion extends UpdateCompanion<Wallets> {
  final Value<int> id;
  final Value<String> currencyId;
  final Value<int> chartAccountId;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const WalletsCompanion({
    this.id = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  WalletsCompanion.insert({
    this.id = const Value.absent(),
    required String currencyId,
    required int chartAccountId,
    required String name,
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : currencyId = Value(currencyId),
        chartAccountId = Value(chartAccountId),
        name = Value(name);
  static Insertable<Wallets> custom({
    Expression<int>? id,
    Expression<String>? currencyId,
    Expression<int>? chartAccountId,
    Expression<String>? name,
    Expression<String>? description,
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
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  WalletsCompanion copyWith(
      {Value<int>? id,
      Value<String>? currencyId,
      Value<int>? chartAccountId,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return WalletsCompanion(
      id: id ?? this.id,
      currencyId: currencyId ?? this.currencyId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
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
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (chartAccountId.present) {
      map['chart_account_id'] = Variable<int>(chartAccountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('WalletsCompanion(')
          ..write('id: $id, ')
          ..write('currencyId: $currencyId, ')
          ..write('chartAccountId: $chartAccountId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardTable extends CreditCard
    with TableInfo<$CreditCardTable, CreditCards> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<int> chartAccountId = GeneratedColumn<int>(
      'chart_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_account (id)'));
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
  static const String $name = 'credit_card';
  @override
  VerificationContext validateIntegrity(Insertable<CreditCards> instance,
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
  CreditCards map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCards(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      chartAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chart_account_id'])!,
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
  $CreditCardTable createAlias(String alias) {
    return $CreditCardTable(attachedDatabase, alias);
  }
}

class CreditCards extends DataClass implements Insertable<CreditCards> {
  final int id;
  final String currencyId;
  final int chartAccountId;
  final String name;
  final String? description;
  final double quota;
  final int closingDate;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const CreditCards(
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
    map['chart_account_id'] = Variable<int>(chartAccountId);
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

  CreditCardsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCompanion(
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

  factory CreditCards.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCards(
      id: serializer.fromJson<int>(json['id']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      chartAccountId: serializer.fromJson<int>(json['chartAccountId']),
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
      'chartAccountId': serializer.toJson<int>(chartAccountId),
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

  CreditCards copyWith(
          {int? id,
          String? currencyId,
          int? chartAccountId,
          String? name,
          Value<String?> description = const Value.absent(),
          double? quota,
          int? closingDate,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      CreditCards(
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
  CreditCards copyWithCompanion(CreditCardsCompanion data) {
    return CreditCards(
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
    return (StringBuffer('CreditCards(')
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
      (other is CreditCards &&
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

class CreditCardsCompanion extends UpdateCompanion<CreditCards> {
  final Value<int> id;
  final Value<String> currencyId;
  final Value<int> chartAccountId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> quota;
  final Value<int> closingDate;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const CreditCardsCompanion({
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
  CreditCardsCompanion.insert({
    this.id = const Value.absent(),
    required String currencyId,
    required int chartAccountId,
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
  static Insertable<CreditCards> custom({
    Expression<int>? id,
    Expression<String>? currencyId,
    Expression<int>? chartAccountId,
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

  CreditCardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? currencyId,
      Value<int>? chartAccountId,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? quota,
      Value<int>? closingDate,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return CreditCardsCompanion(
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
      map['chart_account_id'] = Variable<int>(chartAccountId.value);
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
    return (StringBuffer('CreditCardsCompanion(')
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

class $JournalEntryTable extends JournalEntry
    with TableInfo<$JournalEntryTable, JournalEntries> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntryTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES document_type (id)'));
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
  static const String $name = 'journal_entry';
  @override
  VerificationContext validateIntegrity(Insertable<JournalEntries> instance,
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
  JournalEntries map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntries(
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
  $JournalEntryTable createAlias(String alias) {
    return $JournalEntryTable(attachedDatabase, alias);
  }
}

class JournalEntries extends DataClass implements Insertable<JournalEntries> {
  final int id;
  final String documentTypeId;
  final int secuencial;
  final DateTime date;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const JournalEntries(
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

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
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

  factory JournalEntries.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntries(
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

  JournalEntries copyWith(
          {int? id,
          String? documentTypeId,
          int? secuencial,
          DateTime? date,
          Value<String?> description = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      JournalEntries(
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
  JournalEntries copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntries(
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
    return (StringBuffer('JournalEntries(')
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
      (other is JournalEntries &&
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

class JournalEntriesCompanion extends UpdateCompanion<JournalEntries> {
  final Value<int> id;
  final Value<String> documentTypeId;
  final Value<int> secuencial;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const JournalEntriesCompanion({
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
  JournalEntriesCompanion.insert({
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
  static Insertable<JournalEntries> custom({
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

  JournalEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentTypeId,
      Value<int>? secuencial,
      Value<DateTime>? date,
      Value<String?>? description,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return JournalEntriesCompanion(
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
    return (StringBuffer('JournalEntriesCompanion(')
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

class $JournalDetailTable extends JournalDetail
    with TableInfo<$JournalDetailTable, JournalDetails> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalDetailTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES journal_entry (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _chartAccountIdMeta =
      const VerificationMeta('chartAccountId');
  @override
  late final GeneratedColumn<int> chartAccountId = GeneratedColumn<int>(
      'chart_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chart_account (id)'));
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
  static const String $name = 'journal_detail';
  @override
  VerificationContext validateIntegrity(Insertable<JournalDetails> instance,
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
  JournalDetails map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalDetails(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      journalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journal_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      chartAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chart_account_id'])!,
      credit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit'])!,
      debit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}debit'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
    );
  }

  @override
  $JournalDetailTable createAlias(String alias) {
    return $JournalDetailTable(attachedDatabase, alias);
  }
}

class JournalDetails extends DataClass implements Insertable<JournalDetails> {
  final int id;
  final int journalId;
  final String currencyId;
  final int chartAccountId;
  final double credit;
  final double debit;
  final double rateExchange;
  const JournalDetails(
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
    map['chart_account_id'] = Variable<int>(chartAccountId);
    map['credit'] = Variable<double>(credit);
    map['debit'] = Variable<double>(debit);
    map['rate_exchange'] = Variable<double>(rateExchange);
    return map;
  }

  JournalDetailsCompanion toCompanion(bool nullToAbsent) {
    return JournalDetailsCompanion(
      id: Value(id),
      journalId: Value(journalId),
      currencyId: Value(currencyId),
      chartAccountId: Value(chartAccountId),
      credit: Value(credit),
      debit: Value(debit),
      rateExchange: Value(rateExchange),
    );
  }

  factory JournalDetails.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalDetails(
      id: serializer.fromJson<int>(json['id']),
      journalId: serializer.fromJson<int>(json['journalId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      chartAccountId: serializer.fromJson<int>(json['chartAccountId']),
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
      'chartAccountId': serializer.toJson<int>(chartAccountId),
      'credit': serializer.toJson<double>(credit),
      'debit': serializer.toJson<double>(debit),
      'rateExchange': serializer.toJson<double>(rateExchange),
    };
  }

  JournalDetails copyWith(
          {int? id,
          int? journalId,
          String? currencyId,
          int? chartAccountId,
          double? credit,
          double? debit,
          double? rateExchange}) =>
      JournalDetails(
        id: id ?? this.id,
        journalId: journalId ?? this.journalId,
        currencyId: currencyId ?? this.currencyId,
        chartAccountId: chartAccountId ?? this.chartAccountId,
        credit: credit ?? this.credit,
        debit: debit ?? this.debit,
        rateExchange: rateExchange ?? this.rateExchange,
      );
  JournalDetails copyWithCompanion(JournalDetailsCompanion data) {
    return JournalDetails(
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
    return (StringBuffer('JournalDetails(')
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
      (other is JournalDetails &&
          other.id == this.id &&
          other.journalId == this.journalId &&
          other.currencyId == this.currencyId &&
          other.chartAccountId == this.chartAccountId &&
          other.credit == this.credit &&
          other.debit == this.debit &&
          other.rateExchange == this.rateExchange);
}

class JournalDetailsCompanion extends UpdateCompanion<JournalDetails> {
  final Value<int> id;
  final Value<int> journalId;
  final Value<String> currencyId;
  final Value<int> chartAccountId;
  final Value<double> credit;
  final Value<double> debit;
  final Value<double> rateExchange;
  const JournalDetailsCompanion({
    this.id = const Value.absent(),
    this.journalId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.chartAccountId = const Value.absent(),
    this.credit = const Value.absent(),
    this.debit = const Value.absent(),
    this.rateExchange = const Value.absent(),
  });
  JournalDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int journalId,
    required String currencyId,
    required int chartAccountId,
    required double credit,
    required double debit,
    required double rateExchange,
  })  : journalId = Value(journalId),
        currencyId = Value(currencyId),
        chartAccountId = Value(chartAccountId),
        credit = Value(credit),
        debit = Value(debit),
        rateExchange = Value(rateExchange);
  static Insertable<JournalDetails> custom({
    Expression<int>? id,
    Expression<int>? journalId,
    Expression<String>? currencyId,
    Expression<int>? chartAccountId,
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

  JournalDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? journalId,
      Value<String>? currencyId,
      Value<int>? chartAccountId,
      Value<double>? credit,
      Value<double>? debit,
      Value<double>? rateExchange}) {
    return JournalDetailsCompanion(
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
      map['chart_account_id'] = Variable<int>(chartAccountId.value);
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
    return (StringBuffer('JournalDetailsCompanion(')
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

class $TransactionEntryTable extends TransactionEntry
    with TableInfo<$TransactionEntryTable, TransactionEntries> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionEntryTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES document_type (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _journalIdMeta =
      const VerificationMeta('journalId');
  @override
  late final GeneratedColumn<int> journalId = GeneratedColumn<int>(
      'journal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journal_entry (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contact (id)'));
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
  static const String $name = 'transaction_entry';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionEntries> instance,
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
  TransactionEntries map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntries(
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
  $TransactionEntryTable createAlias(String alias) {
    return $TransactionEntryTable(attachedDatabase, alias);
  }
}

class TransactionEntries extends DataClass
    implements Insertable<TransactionEntries> {
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
  const TransactionEntries(
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

  TransactionEntriesCompanion toCompanion(bool nullToAbsent) {
    return TransactionEntriesCompanion(
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

  factory TransactionEntries.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntries(
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

  TransactionEntries copyWith(
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
      TransactionEntries(
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
  TransactionEntries copyWithCompanion(TransactionEntriesCompanion data) {
    return TransactionEntries(
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
    return (StringBuffer('TransactionEntries(')
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
      (other is TransactionEntries &&
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

class TransactionEntriesCompanion extends UpdateCompanion<TransactionEntries> {
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
  const TransactionEntriesCompanion({
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
  TransactionEntriesCompanion.insert({
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
  static Insertable<TransactionEntries> custom({
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

  TransactionEntriesCompanion copyWith(
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
    return TransactionEntriesCompanion(
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
    return (StringBuffer('TransactionEntriesCompanion(')
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

class $TransactionDetailTable extends TransactionDetail
    with TableInfo<$TransactionDetailTable, TransactionDetails> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionDetailTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transaction_entry (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _flowIdMeta = const VerificationMeta('flowId');
  @override
  late final GeneratedColumn<String> flowId = GeneratedColumn<String>(
      'flow_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES flow_type (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES payment_type (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES category (id)'));
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
  static const String $name = 'transaction_detail';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDetails> instance,
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
  TransactionDetails map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDetails(
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
  $TransactionDetailTable createAlias(String alias) {
    return $TransactionDetailTable(attachedDatabase, alias);
  }
}

class TransactionDetails extends DataClass
    implements Insertable<TransactionDetails> {
  final int id;
  final int transactionId;
  final String currencyId;
  final String flowId;
  final String paymentTypeId;
  final int paymentId;
  final int categoryId;
  final double amount;
  final double rateExchange;
  const TransactionDetails(
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

  TransactionDetailsCompanion toCompanion(bool nullToAbsent) {
    return TransactionDetailsCompanion(
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

  factory TransactionDetails.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDetails(
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

  TransactionDetails copyWith(
          {int? id,
          int? transactionId,
          String? currencyId,
          String? flowId,
          String? paymentTypeId,
          int? paymentId,
          int? categoryId,
          double? amount,
          double? rateExchange}) =>
      TransactionDetails(
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
  TransactionDetails copyWithCompanion(TransactionDetailsCompanion data) {
    return TransactionDetails(
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
    return (StringBuffer('TransactionDetails(')
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
      (other is TransactionDetails &&
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

class TransactionDetailsCompanion extends UpdateCompanion<TransactionDetails> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<String> currencyId;
  final Value<String> flowId;
  final Value<String> paymentTypeId;
  final Value<int> paymentId;
  final Value<int> categoryId;
  final Value<double> amount;
  final Value<double> rateExchange;
  const TransactionDetailsCompanion({
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
  TransactionDetailsCompanion.insert({
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
  static Insertable<TransactionDetails> custom({
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

  TransactionDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? transactionId,
      Value<String>? currencyId,
      Value<String>? flowId,
      Value<String>? paymentTypeId,
      Value<int>? paymentId,
      Value<int>? categoryId,
      Value<double>? amount,
      Value<double>? rateExchange}) {
    return TransactionDetailsCompanion(
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
    return (StringBuffer('TransactionDetailsCompanion(')
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

class $LoanEntryTable extends LoanEntry
    with TableInfo<$LoanEntryTable, LoanEntries> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanEntryTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES document_type (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contact (id)'));
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
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
        documentTypeId,
        currencyId,
        contactId,
        secuencial,
        date,
        amount,
        rateExchange,
        description,
        status,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_entry';
  @override
  VerificationContext validateIntegrity(Insertable<LoanEntries> instance,
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
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
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
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
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
  LoanEntries map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanEntries(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
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
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
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
  $LoanEntryTable createAlias(String alias) {
    return $LoanEntryTable(attachedDatabase, alias);
  }
}

class LoanEntries extends DataClass implements Insertable<LoanEntries> {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final String status;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const LoanEntries(
      {required this.id,
      required this.documentTypeId,
      required this.currencyId,
      required this.contactId,
      required this.secuencial,
      required this.date,
      required this.amount,
      required this.rateExchange,
      this.description,
      required this.status,
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
    map['contact_id'] = Variable<int>(contactId);
    map['secuencial'] = Variable<int>(secuencial);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['rate_exchange'] = Variable<double>(rateExchange);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
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

  LoanEntriesCompanion toCompanion(bool nullToAbsent) {
    return LoanEntriesCompanion(
      id: Value(id),
      documentTypeId: Value(documentTypeId),
      currencyId: Value(currencyId),
      contactId: Value(contactId),
      secuencial: Value(secuencial),
      date: Value(date),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
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

  factory LoanEntries.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanEntries(
      id: serializer.fromJson<int>(json['id']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      contactId: serializer.fromJson<int>(json['contactId']),
      secuencial: serializer.fromJson<int>(json['secuencial']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
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
      'contactId': serializer.toJson<int>(contactId),
      'secuencial': serializer.toJson<int>(secuencial),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LoanEntries copyWith(
          {int? id,
          String? documentTypeId,
          String? currencyId,
          int? contactId,
          int? secuencial,
          DateTime? date,
          double? amount,
          double? rateExchange,
          Value<String?> description = const Value.absent(),
          String? status,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      LoanEntries(
        id: id ?? this.id,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        currencyId: currencyId ?? this.currencyId,
        contactId: contactId ?? this.contactId,
        secuencial: secuencial ?? this.secuencial,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LoanEntries copyWithCompanion(LoanEntriesCompanion data) {
    return LoanEntries(
      id: data.id.present ? data.id.value : this.id,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
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
      status: data.status.present ? data.status.value : this.status,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanEntries(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('contactId: $contactId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
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
      contactId,
      secuencial,
      date,
      amount,
      rateExchange,
      description,
      status,
      active,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanEntries &&
          other.id == this.id &&
          other.documentTypeId == this.documentTypeId &&
          other.currencyId == this.currencyId &&
          other.contactId == this.contactId &&
          other.secuencial == this.secuencial &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange &&
          other.description == this.description &&
          other.status == this.status &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LoanEntriesCompanion extends UpdateCompanion<LoanEntries> {
  final Value<int> id;
  final Value<String> documentTypeId;
  final Value<String> currencyId;
  final Value<int> contactId;
  final Value<int> secuencial;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<double> rateExchange;
  final Value<String?> description;
  final Value<String> status;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const LoanEntriesCompanion({
    this.id = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.secuencial = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  LoanEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String documentTypeId,
    required String currencyId,
    required int contactId,
    required int secuencial,
    required DateTime date,
    required double amount,
    required double rateExchange,
    this.description = const Value.absent(),
    required String status,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        currencyId = Value(currencyId),
        contactId = Value(contactId),
        secuencial = Value(secuencial),
        date = Value(date),
        amount = Value(amount),
        rateExchange = Value(rateExchange),
        status = Value(status);
  static Insertable<LoanEntries> custom({
    Expression<int>? id,
    Expression<String>? documentTypeId,
    Expression<String>? currencyId,
    Expression<int>? contactId,
    Expression<int>? secuencial,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<double>? rateExchange,
    Expression<String>? description,
    Expression<String>? status,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentTypeId != null) 'document_type_id': documentTypeId,
      if (currencyId != null) 'currency_id': currencyId,
      if (contactId != null) 'contact_id': contactId,
      if (secuencial != null) 'secuencial': secuencial,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  LoanEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentTypeId,
      Value<String>? currencyId,
      Value<int>? contactId,
      Value<int>? secuencial,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<double>? rateExchange,
      Value<String?>? description,
      Value<String>? status,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return LoanEntriesCompanion(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      currencyId: currencyId ?? this.currencyId,
      contactId: contactId ?? this.contactId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      description: description ?? this.description,
      status: status ?? this.status,
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    return (StringBuffer('LoanEntriesCompanion(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('contactId: $contactId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $LoanDetailTable extends LoanDetail
    with TableInfo<$LoanDetailTable, LoanDetails> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<int> loanId = GeneratedColumn<int>(
      'loan_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES loan_entry (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES payment_type (id)'));
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<int> paymentId = GeneratedColumn<int>(
      'payment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _journalIdMeta =
      const VerificationMeta('journalId');
  @override
  late final GeneratedColumn<int> journalId = GeneratedColumn<int>(
      'journal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journal_entry (id)'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transaction_entry (id)'));
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
        loanId,
        currencyId,
        paymentTypeId,
        paymentId,
        journalId,
        transactionId,
        amount,
        rateExchange,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_detail';
  @override
  VerificationContext validateIntegrity(Insertable<LoanDetails> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('loan_id')) {
      context.handle(_loanIdMeta,
          loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta));
    } else if (isInserting) {
      context.missing(_loanIdMeta);
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
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
    if (data.containsKey('journal_id')) {
      context.handle(_journalIdMeta,
          journalId.isAcceptableOrUnknown(data['journal_id']!, _journalIdMeta));
    } else if (isInserting) {
      context.missing(_journalIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
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
  LoanDetails map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanDetails(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      loanId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}loan_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      paymentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_type_id'])!,
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_id'])!,
      journalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journal_id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
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
  $LoanDetailTable createAlias(String alias) {
    return $LoanDetailTable(attachedDatabase, alias);
  }
}

class LoanDetails extends DataClass implements Insertable<LoanDetails> {
  final int id;
  final int loanId;
  final String currencyId;
  final String paymentTypeId;
  final int paymentId;
  final int journalId;
  final int transactionId;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const LoanDetails(
      {required this.id,
      required this.loanId,
      required this.currencyId,
      required this.paymentTypeId,
      required this.paymentId,
      required this.journalId,
      required this.transactionId,
      required this.amount,
      required this.rateExchange,
      required this.active,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['loan_id'] = Variable<int>(loanId);
    map['currency_id'] = Variable<String>(currencyId);
    map['payment_type_id'] = Variable<String>(paymentTypeId);
    map['payment_id'] = Variable<int>(paymentId);
    map['journal_id'] = Variable<int>(journalId);
    map['transaction_id'] = Variable<int>(transactionId);
    map['amount'] = Variable<double>(amount);
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

  LoanDetailsCompanion toCompanion(bool nullToAbsent) {
    return LoanDetailsCompanion(
      id: Value(id),
      loanId: Value(loanId),
      currencyId: Value(currencyId),
      paymentTypeId: Value(paymentTypeId),
      paymentId: Value(paymentId),
      journalId: Value(journalId),
      transactionId: Value(transactionId),
      amount: Value(amount),
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

  factory LoanDetails.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanDetails(
      id: serializer.fromJson<int>(json['id']),
      loanId: serializer.fromJson<int>(json['loanId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      paymentTypeId: serializer.fromJson<String>(json['paymentTypeId']),
      paymentId: serializer.fromJson<int>(json['paymentId']),
      journalId: serializer.fromJson<int>(json['journalId']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      amount: serializer.fromJson<double>(json['amount']),
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
      'id': serializer.toJson<int>(id),
      'loanId': serializer.toJson<int>(loanId),
      'currencyId': serializer.toJson<String>(currencyId),
      'paymentTypeId': serializer.toJson<String>(paymentTypeId),
      'paymentId': serializer.toJson<int>(paymentId),
      'journalId': serializer.toJson<int>(journalId),
      'transactionId': serializer.toJson<int>(transactionId),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LoanDetails copyWith(
          {int? id,
          int? loanId,
          String? currencyId,
          String? paymentTypeId,
          int? paymentId,
          int? journalId,
          int? transactionId,
          double? amount,
          double? rateExchange,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      LoanDetails(
        id: id ?? this.id,
        loanId: loanId ?? this.loanId,
        currencyId: currencyId ?? this.currencyId,
        paymentTypeId: paymentTypeId ?? this.paymentTypeId,
        paymentId: paymentId ?? this.paymentId,
        journalId: journalId ?? this.journalId,
        transactionId: transactionId ?? this.transactionId,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LoanDetails copyWithCompanion(LoanDetailsCompanion data) {
    return LoanDetails(
      id: data.id.present ? data.id.value : this.id,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      paymentTypeId: data.paymentTypeId.present
          ? data.paymentTypeId.value
          : this.paymentTypeId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      journalId: data.journalId.present ? data.journalId.value : this.journalId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      amount: data.amount.present ? data.amount.value : this.amount,
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
    return (StringBuffer('LoanDetails(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('currencyId: $currencyId, ')
          ..write('paymentTypeId: $paymentTypeId, ')
          ..write('paymentId: $paymentId, ')
          ..write('journalId: $journalId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
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
      id,
      loanId,
      currencyId,
      paymentTypeId,
      paymentId,
      journalId,
      transactionId,
      amount,
      rateExchange,
      active,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanDetails &&
          other.id == this.id &&
          other.loanId == this.loanId &&
          other.currencyId == this.currencyId &&
          other.paymentTypeId == this.paymentTypeId &&
          other.paymentId == this.paymentId &&
          other.journalId == this.journalId &&
          other.transactionId == this.transactionId &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LoanDetailsCompanion extends UpdateCompanion<LoanDetails> {
  final Value<int> id;
  final Value<int> loanId;
  final Value<String> currencyId;
  final Value<String> paymentTypeId;
  final Value<int> paymentId;
  final Value<int> journalId;
  final Value<int> transactionId;
  final Value<double> amount;
  final Value<double> rateExchange;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const LoanDetailsCompanion({
    this.id = const Value.absent(),
    this.loanId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.paymentTypeId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.journalId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  LoanDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int loanId,
    required String currencyId,
    required String paymentTypeId,
    required int paymentId,
    required int journalId,
    required int transactionId,
    required double amount,
    required double rateExchange,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : loanId = Value(loanId),
        currencyId = Value(currencyId),
        paymentTypeId = Value(paymentTypeId),
        paymentId = Value(paymentId),
        journalId = Value(journalId),
        transactionId = Value(transactionId),
        amount = Value(amount),
        rateExchange = Value(rateExchange);
  static Insertable<LoanDetails> custom({
    Expression<int>? id,
    Expression<int>? loanId,
    Expression<String>? currencyId,
    Expression<String>? paymentTypeId,
    Expression<int>? paymentId,
    Expression<int>? journalId,
    Expression<int>? transactionId,
    Expression<double>? amount,
    Expression<double>? rateExchange,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loanId != null) 'loan_id': loanId,
      if (currencyId != null) 'currency_id': currencyId,
      if (paymentTypeId != null) 'payment_type_id': paymentTypeId,
      if (paymentId != null) 'payment_id': paymentId,
      if (journalId != null) 'journal_id': journalId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  LoanDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? loanId,
      Value<String>? currencyId,
      Value<String>? paymentTypeId,
      Value<int>? paymentId,
      Value<int>? journalId,
      Value<int>? transactionId,
      Value<double>? amount,
      Value<double>? rateExchange,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return LoanDetailsCompanion(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      currencyId: currencyId ?? this.currencyId,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      paymentId: paymentId ?? this.paymentId,
      journalId: journalId ?? this.journalId,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
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
    if (loanId.present) {
      map['loan_id'] = Variable<int>(loanId.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (paymentTypeId.present) {
      map['payment_type_id'] = Variable<String>(paymentTypeId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<int>(paymentId.value);
    }
    if (journalId.present) {
      map['journal_id'] = Variable<int>(journalId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoanDetailsCompanion(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('currencyId: $currencyId, ')
          ..write('paymentTypeId: $paymentTypeId, ')
          ..write('paymentId: $paymentId, ')
          ..write('journalId: $journalId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SharedExpenseEntryTable extends SharedExpenseEntry
    with TableInfo<$SharedExpenseEntryTable, SharedExpenseEntries> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedExpenseEntryTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.constraintIsAlways('REFERENCES document_type (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
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
        secuencial,
        date,
        amount,
        rateExchange,
        active,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_expense_entry';
  @override
  VerificationContext validateIntegrity(
      Insertable<SharedExpenseEntries> instance,
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
  SharedExpenseEntries map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedExpenseEntries(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      documentTypeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}document_type_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      secuencial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}secuencial'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
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
  $SharedExpenseEntryTable createAlias(String alias) {
    return $SharedExpenseEntryTable(attachedDatabase, alias);
  }
}

class SharedExpenseEntries extends DataClass
    implements Insertable<SharedExpenseEntries> {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const SharedExpenseEntries(
      {required this.id,
      required this.documentTypeId,
      required this.currencyId,
      required this.secuencial,
      required this.date,
      required this.amount,
      required this.rateExchange,
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
    map['secuencial'] = Variable<int>(secuencial);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
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

  SharedExpenseEntriesCompanion toCompanion(bool nullToAbsent) {
    return SharedExpenseEntriesCompanion(
      id: Value(id),
      documentTypeId: Value(documentTypeId),
      currencyId: Value(currencyId),
      secuencial: Value(secuencial),
      date: Value(date),
      amount: Value(amount),
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

  factory SharedExpenseEntries.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedExpenseEntries(
      id: serializer.fromJson<int>(json['id']),
      documentTypeId: serializer.fromJson<String>(json['documentTypeId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      secuencial: serializer.fromJson<int>(json['secuencial']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
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
      'id': serializer.toJson<int>(id),
      'documentTypeId': serializer.toJson<String>(documentTypeId),
      'currencyId': serializer.toJson<String>(currencyId),
      'secuencial': serializer.toJson<int>(secuencial),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SharedExpenseEntries copyWith(
          {int? id,
          String? documentTypeId,
          String? currencyId,
          int? secuencial,
          DateTime? date,
          double? amount,
          double? rateExchange,
          bool? active,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      SharedExpenseEntries(
        id: id ?? this.id,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        currencyId: currencyId ?? this.currencyId,
        secuencial: secuencial ?? this.secuencial,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  SharedExpenseEntries copyWithCompanion(SharedExpenseEntriesCompanion data) {
    return SharedExpenseEntries(
      id: data.id.present ? data.id.value : this.id,
      documentTypeId: data.documentTypeId.present
          ? data.documentTypeId.value
          : this.documentTypeId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      secuencial:
          data.secuencial.present ? data.secuencial.value : this.secuencial,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
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
    return (StringBuffer('SharedExpenseEntries(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, documentTypeId, currencyId, secuencial,
      date, amount, rateExchange, active, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedExpenseEntries &&
          other.id == this.id &&
          other.documentTypeId == this.documentTypeId &&
          other.currencyId == this.currencyId &&
          other.secuencial == this.secuencial &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SharedExpenseEntriesCompanion
    extends UpdateCompanion<SharedExpenseEntries> {
  final Value<int> id;
  final Value<String> documentTypeId;
  final Value<String> currencyId;
  final Value<int> secuencial;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<double> rateExchange;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  const SharedExpenseEntriesCompanion({
    this.id = const Value.absent(),
    this.documentTypeId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.secuencial = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  SharedExpenseEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String documentTypeId,
    required String currencyId,
    required int secuencial,
    required DateTime date,
    required double amount,
    required double rateExchange,
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : documentTypeId = Value(documentTypeId),
        currencyId = Value(currencyId),
        secuencial = Value(secuencial),
        date = Value(date),
        amount = Value(amount),
        rateExchange = Value(rateExchange);
  static Insertable<SharedExpenseEntries> custom({
    Expression<int>? id,
    Expression<String>? documentTypeId,
    Expression<String>? currencyId,
    Expression<int>? secuencial,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<double>? rateExchange,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentTypeId != null) 'document_type_id': documentTypeId,
      if (currencyId != null) 'currency_id': currencyId,
      if (secuencial != null) 'secuencial': secuencial,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  SharedExpenseEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentTypeId,
      Value<String>? currencyId,
      Value<int>? secuencial,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<double>? rateExchange,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return SharedExpenseEntriesCompanion(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      currencyId: currencyId ?? this.currencyId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
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
    return (StringBuffer('SharedExpenseEntriesCompanion(')
          ..write('id: $id, ')
          ..write('documentTypeId: $documentTypeId, ')
          ..write('currencyId: $currencyId, ')
          ..write('secuencial: $secuencial, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SharedExpenseDetailTable extends SharedExpenseDetail
    with TableInfo<$SharedExpenseDetailTable, SharedExpenseDetails> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedExpenseDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sharedExpenseIdMeta =
      const VerificationMeta('sharedExpenseId');
  @override
  late final GeneratedColumn<int> sharedExpenseId = GeneratedColumn<int>(
      'shared_expense_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES shared_expense_entry (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES currency (id)'));
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<int> loanId = GeneratedColumn<int>(
      'loan_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES loan_entry (id)'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transaction_entry (id)'));
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sharedExpenseId,
        currencyId,
        loanId,
        transactionId,
        percentage,
        amount,
        rateExchange,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_expense_detail';
  @override
  VerificationContext validateIntegrity(
      Insertable<SharedExpenseDetails> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shared_expense_id')) {
      context.handle(
          _sharedExpenseIdMeta,
          sharedExpenseId.isAcceptableOrUnknown(
              data['shared_expense_id']!, _sharedExpenseIdMeta));
    } else if (isInserting) {
      context.missing(_sharedExpenseIdMeta);
    }
    if (data.containsKey('currency_id')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currency_id']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('loan_id')) {
      context.handle(_loanIdMeta,
          loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta));
    } else if (isInserting) {
      context.missing(_loanIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
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
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SharedExpenseDetails map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedExpenseDetails(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sharedExpenseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shared_expense_id'])!,
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_id'])!,
      loanId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}loan_id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction_id'])!,
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      rateExchange: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_exchange'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $SharedExpenseDetailTable createAlias(String alias) {
    return $SharedExpenseDetailTable(attachedDatabase, alias);
  }
}

class SharedExpenseDetails extends DataClass
    implements Insertable<SharedExpenseDetails> {
  final int id;
  final int sharedExpenseId;
  final String currencyId;
  final int loanId;
  final int transactionId;
  final double percentage;
  final double amount;
  final double rateExchange;
  final String status;
  const SharedExpenseDetails(
      {required this.id,
      required this.sharedExpenseId,
      required this.currencyId,
      required this.loanId,
      required this.transactionId,
      required this.percentage,
      required this.amount,
      required this.rateExchange,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shared_expense_id'] = Variable<int>(sharedExpenseId);
    map['currency_id'] = Variable<String>(currencyId);
    map['loan_id'] = Variable<int>(loanId);
    map['transaction_id'] = Variable<int>(transactionId);
    map['percentage'] = Variable<double>(percentage);
    map['amount'] = Variable<double>(amount);
    map['rate_exchange'] = Variable<double>(rateExchange);
    map['status'] = Variable<String>(status);
    return map;
  }

  SharedExpenseDetailsCompanion toCompanion(bool nullToAbsent) {
    return SharedExpenseDetailsCompanion(
      id: Value(id),
      sharedExpenseId: Value(sharedExpenseId),
      currencyId: Value(currencyId),
      loanId: Value(loanId),
      transactionId: Value(transactionId),
      percentage: Value(percentage),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
      status: Value(status),
    );
  }

  factory SharedExpenseDetails.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedExpenseDetails(
      id: serializer.fromJson<int>(json['id']),
      sharedExpenseId: serializer.fromJson<int>(json['sharedExpenseId']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      loanId: serializer.fromJson<int>(json['loanId']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      percentage: serializer.fromJson<double>(json['percentage']),
      amount: serializer.fromJson<double>(json['amount']),
      rateExchange: serializer.fromJson<double>(json['rateExchange']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sharedExpenseId': serializer.toJson<int>(sharedExpenseId),
      'currencyId': serializer.toJson<String>(currencyId),
      'loanId': serializer.toJson<int>(loanId),
      'transactionId': serializer.toJson<int>(transactionId),
      'percentage': serializer.toJson<double>(percentage),
      'amount': serializer.toJson<double>(amount),
      'rateExchange': serializer.toJson<double>(rateExchange),
      'status': serializer.toJson<String>(status),
    };
  }

  SharedExpenseDetails copyWith(
          {int? id,
          int? sharedExpenseId,
          String? currencyId,
          int? loanId,
          int? transactionId,
          double? percentage,
          double? amount,
          double? rateExchange,
          String? status}) =>
      SharedExpenseDetails(
        id: id ?? this.id,
        sharedExpenseId: sharedExpenseId ?? this.sharedExpenseId,
        currencyId: currencyId ?? this.currencyId,
        loanId: loanId ?? this.loanId,
        transactionId: transactionId ?? this.transactionId,
        percentage: percentage ?? this.percentage,
        amount: amount ?? this.amount,
        rateExchange: rateExchange ?? this.rateExchange,
        status: status ?? this.status,
      );
  SharedExpenseDetails copyWithCompanion(SharedExpenseDetailsCompanion data) {
    return SharedExpenseDetails(
      id: data.id.present ? data.id.value : this.id,
      sharedExpenseId: data.sharedExpenseId.present
          ? data.sharedExpenseId.value
          : this.sharedExpenseId,
      currencyId:
          data.currencyId.present ? data.currencyId.value : this.currencyId,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
      amount: data.amount.present ? data.amount.value : this.amount,
      rateExchange: data.rateExchange.present
          ? data.rateExchange.value
          : this.rateExchange,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedExpenseDetails(')
          ..write('id: $id, ')
          ..write('sharedExpenseId: $sharedExpenseId, ')
          ..write('currencyId: $currencyId, ')
          ..write('loanId: $loanId, ')
          ..write('transactionId: $transactionId, ')
          ..write('percentage: $percentage, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sharedExpenseId, currencyId, loanId,
      transactionId, percentage, amount, rateExchange, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedExpenseDetails &&
          other.id == this.id &&
          other.sharedExpenseId == this.sharedExpenseId &&
          other.currencyId == this.currencyId &&
          other.loanId == this.loanId &&
          other.transactionId == this.transactionId &&
          other.percentage == this.percentage &&
          other.amount == this.amount &&
          other.rateExchange == this.rateExchange &&
          other.status == this.status);
}

class SharedExpenseDetailsCompanion
    extends UpdateCompanion<SharedExpenseDetails> {
  final Value<int> id;
  final Value<int> sharedExpenseId;
  final Value<String> currencyId;
  final Value<int> loanId;
  final Value<int> transactionId;
  final Value<double> percentage;
  final Value<double> amount;
  final Value<double> rateExchange;
  final Value<String> status;
  const SharedExpenseDetailsCompanion({
    this.id = const Value.absent(),
    this.sharedExpenseId = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.amount = const Value.absent(),
    this.rateExchange = const Value.absent(),
    this.status = const Value.absent(),
  });
  SharedExpenseDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int sharedExpenseId,
    required String currencyId,
    required int loanId,
    required int transactionId,
    required double percentage,
    required double amount,
    required double rateExchange,
    required String status,
  })  : sharedExpenseId = Value(sharedExpenseId),
        currencyId = Value(currencyId),
        loanId = Value(loanId),
        transactionId = Value(transactionId),
        percentage = Value(percentage),
        amount = Value(amount),
        rateExchange = Value(rateExchange),
        status = Value(status);
  static Insertable<SharedExpenseDetails> custom({
    Expression<int>? id,
    Expression<int>? sharedExpenseId,
    Expression<String>? currencyId,
    Expression<int>? loanId,
    Expression<int>? transactionId,
    Expression<double>? percentage,
    Expression<double>? amount,
    Expression<double>? rateExchange,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sharedExpenseId != null) 'shared_expense_id': sharedExpenseId,
      if (currencyId != null) 'currency_id': currencyId,
      if (loanId != null) 'loan_id': loanId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (percentage != null) 'percentage': percentage,
      if (amount != null) 'amount': amount,
      if (rateExchange != null) 'rate_exchange': rateExchange,
      if (status != null) 'status': status,
    });
  }

  SharedExpenseDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sharedExpenseId,
      Value<String>? currencyId,
      Value<int>? loanId,
      Value<int>? transactionId,
      Value<double>? percentage,
      Value<double>? amount,
      Value<double>? rateExchange,
      Value<String>? status}) {
    return SharedExpenseDetailsCompanion(
      id: id ?? this.id,
      sharedExpenseId: sharedExpenseId ?? this.sharedExpenseId,
      currencyId: currencyId ?? this.currencyId,
      loanId: loanId ?? this.loanId,
      transactionId: transactionId ?? this.transactionId,
      percentage: percentage ?? this.percentage,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sharedExpenseId.present) {
      map['shared_expense_id'] = Variable<int>(sharedExpenseId.value);
    }
    if (currencyId.present) {
      map['currency_id'] = Variable<String>(currencyId.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<int>(loanId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rateExchange.present) {
      map['rate_exchange'] = Variable<double>(rateExchange.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedExpenseDetailsCompanion(')
          ..write('id: $id, ')
          ..write('sharedExpenseId: $sharedExpenseId, ')
          ..write('currencyId: $currencyId, ')
          ..write('loanId: $loanId, ')
          ..write('transactionId: $transactionId, ')
          ..write('percentage: $percentage, ')
          ..write('amount: $amount, ')
          ..write('rateExchange: $rateExchange, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountingTypeTable accountingType = $AccountingTypeTable(this);
  late final $DocumentTypeTable documentType = $DocumentTypeTable(this);
  late final $FlowTypeTable flowType = $FlowTypeTable(this);
  late final $PaymentTypeTable paymentType = $PaymentTypeTable(this);
  late final $CurrencyTable currency = $CurrencyTable(this);
  late final $ChartAccountTable chartAccount = $ChartAccountTable(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final $ContactTable contact = $ContactTable(this);
  late final $WalletTable wallet = $WalletTable(this);
  late final $CreditCardTable creditCard = $CreditCardTable(this);
  late final $JournalEntryTable journalEntry = $JournalEntryTable(this);
  late final $JournalDetailTable journalDetail = $JournalDetailTable(this);
  late final $TransactionEntryTable transactionEntry =
      $TransactionEntryTable(this);
  late final $TransactionDetailTable transactionDetail =
      $TransactionDetailTable(this);
  late final $LoanEntryTable loanEntry = $LoanEntryTable(this);
  late final $LoanDetailTable loanDetail = $LoanDetailTable(this);
  late final $SharedExpenseEntryTable sharedExpenseEntry =
      $SharedExpenseEntryTable(this);
  late final $SharedExpenseDetailTable sharedExpenseDetail =
      $SharedExpenseDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountingType,
        documentType,
        flowType,
        paymentType,
        currency,
        chartAccount,
        category,
        contact,
        wallet,
        creditCard,
        journalEntry,
        journalDetail,
        transactionEntry,
        transactionDetail,
        loanEntry,
        loanDetail,
        sharedExpenseEntry,
        sharedExpenseDetail
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$AccountingTypeTableCreateCompanionBuilder = AccountingTypesCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$AccountingTypeTableUpdateCompanionBuilder = AccountingTypesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$AccountingTypeTableReferences extends BaseReferences<
    _$AppDatabase, $AccountingTypeTable, AccountingTypes> {
  $$AccountingTypeTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChartAccountTable, List<ChartAccounts>>
      _chartAccountRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.chartAccount,
              aliasName: $_aliasNameGenerator(
                  db.accountingType.id, db.chartAccount.accountingTypeId));

  $$ChartAccountTableProcessedTableManager get chartAccountRefs {
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.accountingTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_chartAccountRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountingTypeTableFilterComposer
    extends Composer<_$AppDatabase, $AccountingTypeTable> {
  $$AccountingTypeTableFilterComposer({
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

  Expression<bool> chartAccountRefs(
      Expression<bool> Function($$ChartAccountTableFilterComposer f) f) {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.accountingTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountingTypeTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountingTypeTable> {
  $$AccountingTypeTableOrderingComposer({
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

class $$AccountingTypeTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountingTypeTable> {
  $$AccountingTypeTableAnnotationComposer({
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

  Expression<T> chartAccountRefs<T extends Object>(
      Expression<T> Function($$ChartAccountTableAnnotationComposer a) f) {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.accountingTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountingTypeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountingTypeTable,
    AccountingTypes,
    $$AccountingTypeTableFilterComposer,
    $$AccountingTypeTableOrderingComposer,
    $$AccountingTypeTableAnnotationComposer,
    $$AccountingTypeTableCreateCompanionBuilder,
    $$AccountingTypeTableUpdateCompanionBuilder,
    (AccountingTypes, $$AccountingTypeTableReferences),
    AccountingTypes,
    PrefetchHooks Function({bool chartAccountRefs})> {
  $$AccountingTypeTableTableManager(
      _$AppDatabase db, $AccountingTypeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountingTypeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountingTypeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountingTypeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountingTypesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountingTypesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AccountingTypeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({chartAccountRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chartAccountRefs) db.chartAccount],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chartAccountRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AccountingTypeTableReferences
                            ._chartAccountRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountingTypeTableReferences(db, table, p0)
                                .chartAccountRefs,
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

typedef $$AccountingTypeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountingTypeTable,
    AccountingTypes,
    $$AccountingTypeTableFilterComposer,
    $$AccountingTypeTableOrderingComposer,
    $$AccountingTypeTableAnnotationComposer,
    $$AccountingTypeTableCreateCompanionBuilder,
    $$AccountingTypeTableUpdateCompanionBuilder,
    (AccountingTypes, $$AccountingTypeTableReferences),
    AccountingTypes,
    PrefetchHooks Function({bool chartAccountRefs})>;
typedef $$DocumentTypeTableCreateCompanionBuilder = DocumentTypesCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$DocumentTypeTableUpdateCompanionBuilder = DocumentTypesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$DocumentTypeTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentTypeTable, DocumentTypes> {
  $$DocumentTypeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoryTable, List<Categories>>
      _categoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.category,
              aliasName: $_aliasNameGenerator(
                  db.documentType.id, db.category.documentTypeId));

  $$CategoryTableProcessedTableManager get categoryRefs {
    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalEntryTable, List<JournalEntries>>
      _journalEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalEntry,
              aliasName: $_aliasNameGenerator(
                  db.documentType.id, db.journalEntry.documentTypeId));

  $$JournalEntryTableProcessedTableManager get journalEntryRefs {
    final manager = $$JournalEntryTableTableManager($_db, $_db.journalEntry)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionEntryTable, List<TransactionEntries>>
      _transactionEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionEntry,
              aliasName: $_aliasNameGenerator(
                  db.documentType.id, db.transactionEntry.documentTypeId));

  $$TransactionEntryTableProcessedTableManager get transactionEntryRefs {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.documentTypeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanEntryTable, List<LoanEntries>>
      _loanEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanEntry,
              aliasName: $_aliasNameGenerator(
                  db.documentType.id, db.loanEntry.documentTypeId));

  $$LoanEntryTableProcessedTableManager get loanEntryRefs {
    final manager = $$LoanEntryTableTableManager($_db, $_db.loanEntry)
        .filter((f) => f.documentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SharedExpenseEntryTable,
      List<SharedExpenseEntries>> _sharedExpenseEntryRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseEntry,
          aliasName: $_aliasNameGenerator(
              db.documentType.id, db.sharedExpenseEntry.documentTypeId));

  $$SharedExpenseEntryTableProcessedTableManager get sharedExpenseEntryRefs {
    final manager =
        $$SharedExpenseEntryTableTableManager($_db, $_db.sharedExpenseEntry)
            .filter((f) => f.documentTypeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DocumentTypeTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentTypeTable> {
  $$DocumentTypeTableFilterComposer({
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

  Expression<bool> categoryRefs(
      Expression<bool> Function($$CategoryTableFilterComposer f) f) {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalEntryRefs(
      Expression<bool> Function($$JournalEntryTableFilterComposer f) f) {
    final $$JournalEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableFilterComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionEntryRefs(
      Expression<bool> Function($$TransactionEntryTableFilterComposer f) f) {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanEntryRefs(
      Expression<bool> Function($$LoanEntryTableFilterComposer f) f) {
    final $$LoanEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableFilterComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sharedExpenseEntryRefs(
      Expression<bool> Function($$SharedExpenseEntryTableFilterComposer f) f) {
    final $$SharedExpenseEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseEntryTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DocumentTypeTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentTypeTable> {
  $$DocumentTypeTableOrderingComposer({
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

class $$DocumentTypeTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentTypeTable> {
  $$DocumentTypeTableAnnotationComposer({
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

  Expression<T> categoryRefs<T extends Object>(
      Expression<T> Function($$CategoryTableAnnotationComposer a) f) {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalEntryRefs<T extends Object>(
      Expression<T> Function($$JournalEntryTableAnnotationComposer a) f) {
    final $$JournalEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionEntryRefs<T extends Object>(
      Expression<T> Function($$TransactionEntryTableAnnotationComposer a) f) {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> loanEntryRefs<T extends Object>(
      Expression<T> Function($$LoanEntryTableAnnotationComposer a) f) {
    final $$LoanEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.documentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sharedExpenseEntryRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseEntryTableAnnotationComposer a) f) {
    final $$SharedExpenseEntryTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseEntry,
            getReferencedColumn: (t) => t.documentTypeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseEntryTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseEntry,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$DocumentTypeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentTypeTable,
    DocumentTypes,
    $$DocumentTypeTableFilterComposer,
    $$DocumentTypeTableOrderingComposer,
    $$DocumentTypeTableAnnotationComposer,
    $$DocumentTypeTableCreateCompanionBuilder,
    $$DocumentTypeTableUpdateCompanionBuilder,
    (DocumentTypes, $$DocumentTypeTableReferences),
    DocumentTypes,
    PrefetchHooks Function(
        {bool categoryRefs,
        bool journalEntryRefs,
        bool transactionEntryRefs,
        bool loanEntryRefs,
        bool sharedExpenseEntryRefs})> {
  $$DocumentTypeTableTableManager(_$AppDatabase db, $DocumentTypeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentTypeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentTypeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentTypeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentTypesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              DocumentTypesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DocumentTypeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {categoryRefs = false,
              journalEntryRefs = false,
              transactionEntryRefs = false,
              loanEntryRefs = false,
              sharedExpenseEntryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoryRefs) db.category,
                if (journalEntryRefs) db.journalEntry,
                if (transactionEntryRefs) db.transactionEntry,
                if (loanEntryRefs) db.loanEntry,
                if (sharedExpenseEntryRefs) db.sharedExpenseEntry
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypeTableReferences
                            ._categoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypeTableReferences(db, table, p0)
                                .categoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (journalEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypeTableReferences
                            ._journalEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypeTableReferences(db, table, p0)
                                .journalEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (transactionEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypeTableReferences
                            ._transactionEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypeTableReferences(db, table, p0)
                                .transactionEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (loanEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypeTableReferences
                            ._loanEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypeTableReferences(db, table, p0)
                                .loanEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentTypeId == item.id),
                        typedResults: items),
                  if (sharedExpenseEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DocumentTypeTableReferences
                            ._sharedExpenseEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DocumentTypeTableReferences(db, table, p0)
                                .sharedExpenseEntryRefs,
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

typedef $$DocumentTypeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentTypeTable,
    DocumentTypes,
    $$DocumentTypeTableFilterComposer,
    $$DocumentTypeTableOrderingComposer,
    $$DocumentTypeTableAnnotationComposer,
    $$DocumentTypeTableCreateCompanionBuilder,
    $$DocumentTypeTableUpdateCompanionBuilder,
    (DocumentTypes, $$DocumentTypeTableReferences),
    DocumentTypes,
    PrefetchHooks Function(
        {bool categoryRefs,
        bool journalEntryRefs,
        bool transactionEntryRefs,
        bool loanEntryRefs,
        bool sharedExpenseEntryRefs})>;
typedef $$FlowTypeTableCreateCompanionBuilder = FlowTypesCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$FlowTypeTableUpdateCompanionBuilder = FlowTypesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$FlowTypeTableReferences
    extends BaseReferences<_$AppDatabase, $FlowTypeTable, FlowTypes> {
  $$FlowTypeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionDetailTable, List<TransactionDetails>>
      _transactionDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetail,
              aliasName: $_aliasNameGenerator(
                  db.flowType.id, db.transactionDetail.flowId));

  $$TransactionDetailTableProcessedTableManager get transactionDetailRefs {
    final manager =
        $$TransactionDetailTableTableManager($_db, $_db.transactionDetail)
            .filter((f) => f.flowId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FlowTypeTableFilterComposer
    extends Composer<_$AppDatabase, $FlowTypeTable> {
  $$FlowTypeTableFilterComposer({
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

  Expression<bool> transactionDetailRefs(
      Expression<bool> Function($$TransactionDetailTableFilterComposer f) f) {
    final $$TransactionDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetail,
        getReferencedColumn: (t) => t.flowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FlowTypeTableOrderingComposer
    extends Composer<_$AppDatabase, $FlowTypeTable> {
  $$FlowTypeTableOrderingComposer({
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

class $$FlowTypeTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlowTypeTable> {
  $$FlowTypeTableAnnotationComposer({
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

  Expression<T> transactionDetailRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailTableAnnotationComposer a) f) {
    final $$TransactionDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetail,
            getReferencedColumn: (t) => t.flowId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FlowTypeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FlowTypeTable,
    FlowTypes,
    $$FlowTypeTableFilterComposer,
    $$FlowTypeTableOrderingComposer,
    $$FlowTypeTableAnnotationComposer,
    $$FlowTypeTableCreateCompanionBuilder,
    $$FlowTypeTableUpdateCompanionBuilder,
    (FlowTypes, $$FlowTypeTableReferences),
    FlowTypes,
    PrefetchHooks Function({bool transactionDetailRefs})> {
  $$FlowTypeTableTableManager(_$AppDatabase db, $FlowTypeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlowTypeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlowTypeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlowTypeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FlowTypesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              FlowTypesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FlowTypeTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({transactionDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailRefs) db.transactionDetail
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$FlowTypeTableReferences
                            ._transactionDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FlowTypeTableReferences(db, table, p0)
                                .transactionDetailRefs,
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

typedef $$FlowTypeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FlowTypeTable,
    FlowTypes,
    $$FlowTypeTableFilterComposer,
    $$FlowTypeTableOrderingComposer,
    $$FlowTypeTableAnnotationComposer,
    $$FlowTypeTableCreateCompanionBuilder,
    $$FlowTypeTableUpdateCompanionBuilder,
    (FlowTypes, $$FlowTypeTableReferences),
    FlowTypes,
    PrefetchHooks Function({bool transactionDetailRefs})>;
typedef $$PaymentTypeTableCreateCompanionBuilder = PaymentTypesCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$PaymentTypeTableUpdateCompanionBuilder = PaymentTypesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$PaymentTypeTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentTypeTable, PaymentTypes> {
  $$PaymentTypeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionDetailTable, List<TransactionDetails>>
      _transactionDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetail,
              aliasName: $_aliasNameGenerator(
                  db.paymentType.id, db.transactionDetail.paymentTypeId));

  $$TransactionDetailTableProcessedTableManager get transactionDetailRefs {
    final manager =
        $$TransactionDetailTableTableManager($_db, $_db.transactionDetail)
            .filter((f) => f.paymentTypeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanDetailTable, List<LoanDetails>>
      _loanDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanDetail,
              aliasName: $_aliasNameGenerator(
                  db.paymentType.id, db.loanDetail.paymentTypeId));

  $$LoanDetailTableProcessedTableManager get loanDetailRefs {
    final manager = $$LoanDetailTableTableManager($_db, $_db.loanDetail)
        .filter((f) => f.paymentTypeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PaymentTypeTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentTypeTable> {
  $$PaymentTypeTableFilterComposer({
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

  Expression<bool> transactionDetailRefs(
      Expression<bool> Function($$TransactionDetailTableFilterComposer f) f) {
    final $$TransactionDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetail,
        getReferencedColumn: (t) => t.paymentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanDetailRefs(
      Expression<bool> Function($$LoanDetailTableFilterComposer f) f) {
    final $$LoanDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.paymentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableFilterComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PaymentTypeTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentTypeTable> {
  $$PaymentTypeTableOrderingComposer({
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

class $$PaymentTypeTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentTypeTable> {
  $$PaymentTypeTableAnnotationComposer({
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

  Expression<T> transactionDetailRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailTableAnnotationComposer a) f) {
    final $$TransactionDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetail,
            getReferencedColumn: (t) => t.paymentTypeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> loanDetailRefs<T extends Object>(
      Expression<T> Function($$LoanDetailTableAnnotationComposer a) f) {
    final $$LoanDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.paymentTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PaymentTypeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentTypeTable,
    PaymentTypes,
    $$PaymentTypeTableFilterComposer,
    $$PaymentTypeTableOrderingComposer,
    $$PaymentTypeTableAnnotationComposer,
    $$PaymentTypeTableCreateCompanionBuilder,
    $$PaymentTypeTableUpdateCompanionBuilder,
    (PaymentTypes, $$PaymentTypeTableReferences),
    PaymentTypes,
    PrefetchHooks Function({bool transactionDetailRefs, bool loanDetailRefs})> {
  $$PaymentTypeTableTableManager(_$AppDatabase db, $PaymentTypeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentTypeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentTypeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentTypeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentTypesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentTypesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PaymentTypeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {transactionDetailRefs = false, loanDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailRefs) db.transactionDetail,
                if (loanDetailRefs) db.loanDetail
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PaymentTypeTableReferences
                            ._transactionDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PaymentTypeTableReferences(db, table, p0)
                                .transactionDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.paymentTypeId == item.id),
                        typedResults: items),
                  if (loanDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PaymentTypeTableReferences
                            ._loanDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PaymentTypeTableReferences(db, table, p0)
                                .loanDetailRefs,
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

typedef $$PaymentTypeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentTypeTable,
    PaymentTypes,
    $$PaymentTypeTableFilterComposer,
    $$PaymentTypeTableOrderingComposer,
    $$PaymentTypeTableAnnotationComposer,
    $$PaymentTypeTableCreateCompanionBuilder,
    $$PaymentTypeTableUpdateCompanionBuilder,
    (PaymentTypes, $$PaymentTypeTableReferences),
    PaymentTypes,
    PrefetchHooks Function({bool transactionDetailRefs, bool loanDetailRefs})>;
typedef $$CurrencyTableCreateCompanionBuilder = CurrenciesCompanion Function({
  required String id,
  required String name,
  required String symbol,
  required double rateExchange,
  Value<int> rowid,
});
typedef $$CurrencyTableUpdateCompanionBuilder = CurrenciesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> symbol,
  Value<double> rateExchange,
  Value<int> rowid,
});

final class $$CurrencyTableReferences
    extends BaseReferences<_$AppDatabase, $CurrencyTable, Currencies> {
  $$CurrencyTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WalletTable, List<Wallets>> _walletRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.wallet,
          aliasName:
              $_aliasNameGenerator(db.currency.id, db.wallet.currencyId));

  $$WalletTableProcessedTableManager get walletRefs {
    final manager = $$WalletTableTableManager($_db, $_db.wallet)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_walletRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CreditCardTable, List<CreditCards>>
      _creditCardRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.creditCard,
          aliasName:
              $_aliasNameGenerator(db.currency.id, db.creditCard.currencyId));

  $$CreditCardTableProcessedTableManager get creditCardRefs {
    final manager = $$CreditCardTableTableManager($_db, $_db.creditCard)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_creditCardRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalDetailTable, List<JournalDetails>>
      _journalDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetail,
              aliasName: $_aliasNameGenerator(
                  db.currency.id, db.journalDetail.currencyId));

  $$JournalDetailTableProcessedTableManager get journalDetailRefs {
    final manager = $$JournalDetailTableTableManager($_db, $_db.journalDetail)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionEntryTable, List<TransactionEntries>>
      _transactionEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionEntry,
              aliasName: $_aliasNameGenerator(
                  db.currency.id, db.transactionEntry.currencyId));

  $$TransactionEntryTableProcessedTableManager get transactionEntryRefs {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.currencyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionDetailTable, List<TransactionDetails>>
      _transactionDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetail,
              aliasName: $_aliasNameGenerator(
                  db.currency.id, db.transactionDetail.currencyId));

  $$TransactionDetailTableProcessedTableManager get transactionDetailRefs {
    final manager =
        $$TransactionDetailTableTableManager($_db, $_db.transactionDetail)
            .filter((f) => f.currencyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanEntryTable, List<LoanEntries>>
      _loanEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.loanEntry,
          aliasName:
              $_aliasNameGenerator(db.currency.id, db.loanEntry.currencyId));

  $$LoanEntryTableProcessedTableManager get loanEntryRefs {
    final manager = $$LoanEntryTableTableManager($_db, $_db.loanEntry)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanDetailTable, List<LoanDetails>>
      _loanDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.loanDetail,
          aliasName:
              $_aliasNameGenerator(db.currency.id, db.loanDetail.currencyId));

  $$LoanDetailTableProcessedTableManager get loanDetailRefs {
    final manager = $$LoanDetailTableTableManager($_db, $_db.loanDetail)
        .filter((f) => f.currencyId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SharedExpenseEntryTable,
      List<SharedExpenseEntries>> _sharedExpenseEntryRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseEntry,
          aliasName: $_aliasNameGenerator(
              db.currency.id, db.sharedExpenseEntry.currencyId));

  $$SharedExpenseEntryTableProcessedTableManager get sharedExpenseEntryRefs {
    final manager =
        $$SharedExpenseEntryTableTableManager($_db, $_db.sharedExpenseEntry)
            .filter((f) => f.currencyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SharedExpenseDetailTable,
      List<SharedExpenseDetails>> _sharedExpenseDetailRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseDetail,
          aliasName: $_aliasNameGenerator(
              db.currency.id, db.sharedExpenseDetail.currencyId));

  $$SharedExpenseDetailTableProcessedTableManager get sharedExpenseDetailRefs {
    final manager =
        $$SharedExpenseDetailTableTableManager($_db, $_db.sharedExpenseDetail)
            .filter((f) => f.currencyId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CurrencyTableFilterComposer
    extends Composer<_$AppDatabase, $CurrencyTable> {
  $$CurrencyTableFilterComposer({
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

  Expression<bool> walletRefs(
      Expression<bool> Function($$WalletTableFilterComposer f) f) {
    final $$WalletTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallet,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletTableFilterComposer(
              $db: $db,
              $table: $db.wallet,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> creditCardRefs(
      Expression<bool> Function($$CreditCardTableFilterComposer f) f) {
    final $$CreditCardTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCard,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardTableFilterComposer(
              $db: $db,
              $table: $db.creditCard,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalDetailRefs(
      Expression<bool> Function($$JournalDetailTableFilterComposer f) f) {
    final $$JournalDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableFilterComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionEntryRefs(
      Expression<bool> Function($$TransactionEntryTableFilterComposer f) f) {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionDetailRefs(
      Expression<bool> Function($$TransactionDetailTableFilterComposer f) f) {
    final $$TransactionDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanEntryRefs(
      Expression<bool> Function($$LoanEntryTableFilterComposer f) f) {
    final $$LoanEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableFilterComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanDetailRefs(
      Expression<bool> Function($$LoanDetailTableFilterComposer f) f) {
    final $$LoanDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableFilterComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sharedExpenseEntryRefs(
      Expression<bool> Function($$SharedExpenseEntryTableFilterComposer f) f) {
    final $$SharedExpenseEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseEntry,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseEntryTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sharedExpenseDetailRefs(
      Expression<bool> Function($$SharedExpenseDetailTableFilterComposer f) f) {
    final $$SharedExpenseDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseDetailTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CurrencyTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrencyTable> {
  $$CurrencyTableOrderingComposer({
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
}

class $$CurrencyTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrencyTable> {
  $$CurrencyTableAnnotationComposer({
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

  Expression<T> walletRefs<T extends Object>(
      Expression<T> Function($$WalletTableAnnotationComposer a) f) {
    final $$WalletTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallet,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletTableAnnotationComposer(
              $db: $db,
              $table: $db.wallet,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> creditCardRefs<T extends Object>(
      Expression<T> Function($$CreditCardTableAnnotationComposer a) f) {
    final $$CreditCardTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCard,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardTableAnnotationComposer(
              $db: $db,
              $table: $db.creditCard,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalDetailRefs<T extends Object>(
      Expression<T> Function($$JournalDetailTableAnnotationComposer a) f) {
    final $$JournalDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionEntryRefs<T extends Object>(
      Expression<T> Function($$TransactionEntryTableAnnotationComposer a) f) {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionDetailRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailTableAnnotationComposer a) f) {
    final $$TransactionDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetail,
            getReferencedColumn: (t) => t.currencyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> loanEntryRefs<T extends Object>(
      Expression<T> Function($$LoanEntryTableAnnotationComposer a) f) {
    final $$LoanEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> loanDetailRefs<T extends Object>(
      Expression<T> Function($$LoanDetailTableAnnotationComposer a) f) {
    final $$LoanDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.currencyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sharedExpenseEntryRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseEntryTableAnnotationComposer a) f) {
    final $$SharedExpenseEntryTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseEntry,
            getReferencedColumn: (t) => t.currencyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseEntryTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseEntry,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> sharedExpenseDetailRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseDetailTableAnnotationComposer a)
          f) {
    final $$SharedExpenseDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseDetail,
            getReferencedColumn: (t) => t.currencyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CurrencyTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CurrencyTable,
    Currencies,
    $$CurrencyTableFilterComposer,
    $$CurrencyTableOrderingComposer,
    $$CurrencyTableAnnotationComposer,
    $$CurrencyTableCreateCompanionBuilder,
    $$CurrencyTableUpdateCompanionBuilder,
    (Currencies, $$CurrencyTableReferences),
    Currencies,
    PrefetchHooks Function(
        {bool walletRefs,
        bool creditCardRefs,
        bool journalDetailRefs,
        bool transactionEntryRefs,
        bool transactionDetailRefs,
        bool loanEntryRefs,
        bool loanDetailRefs,
        bool sharedExpenseEntryRefs,
        bool sharedExpenseDetailRefs})> {
  $$CurrencyTableTableManager(_$AppDatabase db, $CurrencyTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrencyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrencyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrencyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> symbol = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CurrenciesCompanion(
            id: id,
            name: name,
            symbol: symbol,
            rateExchange: rateExchange,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String symbol,
            required double rateExchange,
            Value<int> rowid = const Value.absent(),
          }) =>
              CurrenciesCompanion.insert(
            id: id,
            name: name,
            symbol: symbol,
            rateExchange: rateExchange,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CurrencyTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {walletRefs = false,
              creditCardRefs = false,
              journalDetailRefs = false,
              transactionEntryRefs = false,
              transactionDetailRefs = false,
              loanEntryRefs = false,
              loanDetailRefs = false,
              sharedExpenseEntryRefs = false,
              sharedExpenseDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (walletRefs) db.wallet,
                if (creditCardRefs) db.creditCard,
                if (journalDetailRefs) db.journalDetail,
                if (transactionEntryRefs) db.transactionEntry,
                if (transactionDetailRefs) db.transactionDetail,
                if (loanEntryRefs) db.loanEntry,
                if (loanDetailRefs) db.loanDetail,
                if (sharedExpenseEntryRefs) db.sharedExpenseEntry,
                if (sharedExpenseDetailRefs) db.sharedExpenseDetail
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (walletRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CurrencyTableReferences._walletRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0).walletRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (creditCardRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CurrencyTableReferences._creditCardRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .creditCardRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (journalDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrencyTableReferences
                            ._journalDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .journalDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (transactionEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrencyTableReferences
                            ._transactionEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .transactionEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (transactionDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrencyTableReferences
                            ._transactionDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .transactionDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (loanEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CurrencyTableReferences._loanEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .loanEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (loanDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CurrencyTableReferences._loanDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .loanDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (sharedExpenseEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrencyTableReferences
                            ._sharedExpenseEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .sharedExpenseEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.currencyId == item.id),
                        typedResults: items),
                  if (sharedExpenseDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CurrencyTableReferences
                            ._sharedExpenseDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CurrencyTableReferences(db, table, p0)
                                .sharedExpenseDetailRefs,
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

typedef $$CurrencyTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CurrencyTable,
    Currencies,
    $$CurrencyTableFilterComposer,
    $$CurrencyTableOrderingComposer,
    $$CurrencyTableAnnotationComposer,
    $$CurrencyTableCreateCompanionBuilder,
    $$CurrencyTableUpdateCompanionBuilder,
    (Currencies, $$CurrencyTableReferences),
    Currencies,
    PrefetchHooks Function(
        {bool walletRefs,
        bool creditCardRefs,
        bool journalDetailRefs,
        bool transactionEntryRefs,
        bool transactionDetailRefs,
        bool loanEntryRefs,
        bool loanDetailRefs,
        bool sharedExpenseEntryRefs,
        bool sharedExpenseDetailRefs})>;
typedef $$ChartAccountTableCreateCompanionBuilder = ChartAccountsCompanion
    Function({
  Value<int> id,
  Value<int?> parentId,
  required String accountingTypeId,
  required String code,
  required int level,
  required String name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$ChartAccountTableUpdateCompanionBuilder = ChartAccountsCompanion
    Function({
  Value<int> id,
  Value<int?> parentId,
  Value<String> accountingTypeId,
  Value<String> code,
  Value<int> level,
  Value<String> name,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$ChartAccountTableReferences
    extends BaseReferences<_$AppDatabase, $ChartAccountTable, ChartAccounts> {
  $$ChartAccountTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChartAccountTable _parentIdTable(_$AppDatabase db) =>
      db.chartAccount.createAlias(
          $_aliasNameGenerator(db.chartAccount.parentId, db.chartAccount.id));

  $$ChartAccountTableProcessedTableManager? get parentId {
    if ($_item.parentId == null) return null;
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.id($_item.parentId!));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountingTypeTable _accountingTypeIdTable(_$AppDatabase db) =>
      db.accountingType.createAlias($_aliasNameGenerator(
          db.chartAccount.accountingTypeId, db.accountingType.id));

  $$AccountingTypeTableProcessedTableManager get accountingTypeId {
    final manager = $$AccountingTypeTableTableManager($_db, $_db.accountingType)
        .filter((f) => f.id($_item.accountingTypeId!));
    final item = $_typedResult.readTableOrNull(_accountingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CategoryTable, List<Categories>>
      _categoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.category,
              aliasName: $_aliasNameGenerator(
                  db.chartAccount.id, db.category.chartAccountId));

  $$CategoryTableProcessedTableManager get categoryRefs {
    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WalletTable, List<Wallets>> _walletRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.wallet,
          aliasName: $_aliasNameGenerator(
              db.chartAccount.id, db.wallet.chartAccountId));

  $$WalletTableProcessedTableManager get walletRefs {
    final manager = $$WalletTableTableManager($_db, $_db.wallet)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_walletRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CreditCardTable, List<CreditCards>>
      _creditCardRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.creditCard,
              aliasName: $_aliasNameGenerator(
                  db.chartAccount.id, db.creditCard.chartAccountId));

  $$CreditCardTableProcessedTableManager get creditCardRefs {
    final manager = $$CreditCardTableTableManager($_db, $_db.creditCard)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_creditCardRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JournalDetailTable, List<JournalDetails>>
      _journalDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetail,
              aliasName: $_aliasNameGenerator(
                  db.chartAccount.id, db.journalDetail.chartAccountId));

  $$JournalDetailTableProcessedTableManager get journalDetailRefs {
    final manager = $$JournalDetailTableTableManager($_db, $_db.journalDetail)
        .filter((f) => f.chartAccountId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChartAccountTableFilterComposer
    extends Composer<_$AppDatabase, $ChartAccountTable> {
  $$ChartAccountTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
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

  $$ChartAccountTableFilterComposer get parentId {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypeTableFilterComposer get accountingTypeId {
    final $$AccountingTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypeTableFilterComposer(
              $db: $db,
              $table: $db.accountingType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> categoryRefs(
      Expression<bool> Function($$CategoryTableFilterComposer f) f) {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> walletRefs(
      Expression<bool> Function($$WalletTableFilterComposer f) f) {
    final $$WalletTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallet,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletTableFilterComposer(
              $db: $db,
              $table: $db.wallet,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> creditCardRefs(
      Expression<bool> Function($$CreditCardTableFilterComposer f) f) {
    final $$CreditCardTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCard,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardTableFilterComposer(
              $db: $db,
              $table: $db.creditCard,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journalDetailRefs(
      Expression<bool> Function($$JournalDetailTableFilterComposer f) f) {
    final $$JournalDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableFilterComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChartAccountTableOrderingComposer
    extends Composer<_$AppDatabase, $ChartAccountTable> {
  $$ChartAccountTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
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

  $$ChartAccountTableOrderingComposer get parentId {
    final $$ChartAccountTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypeTableOrderingComposer get accountingTypeId {
    final $$AccountingTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypeTableOrderingComposer(
              $db: $db,
              $table: $db.accountingType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChartAccountTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChartAccountTable> {
  $$ChartAccountTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
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

  $$ChartAccountTableAnnotationComposer get parentId {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountingTypeTableAnnotationComposer get accountingTypeId {
    final $$AccountingTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountingTypeId,
        referencedTable: $db.accountingType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountingTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.accountingType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> categoryRefs<T extends Object>(
      Expression<T> Function($$CategoryTableAnnotationComposer a) f) {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> walletRefs<T extends Object>(
      Expression<T> Function($$WalletTableAnnotationComposer a) f) {
    final $$WalletTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallet,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletTableAnnotationComposer(
              $db: $db,
              $table: $db.wallet,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> creditCardRefs<T extends Object>(
      Expression<T> Function($$CreditCardTableAnnotationComposer a) f) {
    final $$CreditCardTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditCard,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditCardTableAnnotationComposer(
              $db: $db,
              $table: $db.creditCard,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journalDetailRefs<T extends Object>(
      Expression<T> Function($$JournalDetailTableAnnotationComposer a) f) {
    final $$JournalDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.chartAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChartAccountTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChartAccountTable,
    ChartAccounts,
    $$ChartAccountTableFilterComposer,
    $$ChartAccountTableOrderingComposer,
    $$ChartAccountTableAnnotationComposer,
    $$ChartAccountTableCreateCompanionBuilder,
    $$ChartAccountTableUpdateCompanionBuilder,
    (ChartAccounts, $$ChartAccountTableReferences),
    ChartAccounts,
    PrefetchHooks Function(
        {bool parentId,
        bool accountingTypeId,
        bool categoryRefs,
        bool walletRefs,
        bool creditCardRefs,
        bool journalDetailRefs})> {
  $$ChartAccountTableTableManager(_$AppDatabase db, $ChartAccountTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChartAccountTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChartAccountTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChartAccountTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<String> accountingTypeId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ChartAccountsCompanion(
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
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            required String accountingTypeId,
            required String code,
            required int level,
            required String name,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ChartAccountsCompanion.insert(
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
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChartAccountTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {parentId = false,
              accountingTypeId = false,
              categoryRefs = false,
              walletRefs = false,
              creditCardRefs = false,
              journalDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoryRefs) db.category,
                if (walletRefs) db.wallet,
                if (creditCardRefs) db.creditCard,
                if (journalDetailRefs) db.journalDetail
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
                        $$ChartAccountTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$ChartAccountTableReferences._parentIdTable(db).id,
                  ) as T;
                }
                if (accountingTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.accountingTypeId,
                    referencedTable: $$ChartAccountTableReferences
                        ._accountingTypeIdTable(db),
                    referencedColumn: $$ChartAccountTableReferences
                        ._accountingTypeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountTableReferences
                            ._categoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountTableReferences(db, table, p0)
                                .categoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items),
                  if (walletRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ChartAccountTableReferences._walletRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountTableReferences(db, table, p0)
                                .walletRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items),
                  if (creditCardRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountTableReferences
                            ._creditCardRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountTableReferences(db, table, p0)
                                .creditCardRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.chartAccountId == item.id),
                        typedResults: items),
                  if (journalDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChartAccountTableReferences
                            ._journalDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChartAccountTableReferences(db, table, p0)
                                .journalDetailRefs,
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

typedef $$ChartAccountTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChartAccountTable,
    ChartAccounts,
    $$ChartAccountTableFilterComposer,
    $$ChartAccountTableOrderingComposer,
    $$ChartAccountTableAnnotationComposer,
    $$ChartAccountTableCreateCompanionBuilder,
    $$ChartAccountTableUpdateCompanionBuilder,
    (ChartAccounts, $$ChartAccountTableReferences),
    ChartAccounts,
    PrefetchHooks Function(
        {bool parentId,
        bool accountingTypeId,
        bool categoryRefs,
        bool walletRefs,
        bool creditCardRefs,
        bool journalDetailRefs})>;
typedef $$CategoryTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  required String documentTypeId,
  required int chartAccountId,
  required String name,
  required String icon,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$CategoryTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<int?> parentId,
  Value<String> documentTypeId,
  Value<int> chartAccountId,
  Value<String> name,
  Value<String> icon,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$CategoryTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryTable, Categories> {
  $$CategoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTable _parentIdTable(_$AppDatabase db) => db.category
      .createAlias($_aliasNameGenerator(db.category.parentId, db.category.id));

  $$CategoryTableProcessedTableManager? get parentId {
    if ($_item.parentId == null) return null;
    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.id($_item.parentId!));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DocumentTypeTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentType.createAlias(
          $_aliasNameGenerator(db.category.documentTypeId, db.documentType.id));

  $$DocumentTypeTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypeTableTableManager($_db, $_db.documentType)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccount.createAlias(
          $_aliasNameGenerator(db.category.chartAccountId, db.chartAccount.id));

  $$ChartAccountTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionDetailTable, List<TransactionDetails>>
      _transactionDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetail,
              aliasName: $_aliasNameGenerator(
                  db.category.id, db.transactionDetail.categoryId));

  $$TransactionDetailTableProcessedTableManager get transactionDetailRefs {
    final manager =
        $$TransactionDetailTableTableManager($_db, $_db.transactionDetail)
            .filter((f) => f.categoryId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoryTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$CategoryTableFilterComposer get parentId {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypeTableFilterComposer get documentTypeId {
    final $$DocumentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableFilterComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableFilterComposer get chartAccountId {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionDetailRefs(
      Expression<bool> Function($$TransactionDetailTableFilterComposer f) f) {
    final $$TransactionDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetail,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$CategoryTableOrderingComposer get parentId {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableOrderingComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypeTableOrderingComposer get documentTypeId {
    final $$DocumentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableOrderingComposer get chartAccountId {
    final $$ChartAccountTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CategoryTableAnnotationComposer get parentId {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DocumentTypeTableAnnotationComposer get documentTypeId {
    final $$DocumentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableAnnotationComposer get chartAccountId {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionDetailRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailTableAnnotationComposer a) f) {
    final $$TransactionDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetail,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryTable,
    Categories,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (Categories, $$CategoryTableReferences),
    Categories,
    PrefetchHooks Function(
        {bool parentId,
        bool documentTypeId,
        bool chartAccountId,
        bool transactionDetailRefs})> {
  $$CategoryTableTableManager(_$AppDatabase db, $CategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<int> chartAccountId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            parentId: parentId,
            documentTypeId: documentTypeId,
            chartAccountId: chartAccountId,
            name: name,
            icon: icon,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            required String documentTypeId,
            required int chartAccountId,
            required String name,
            required String icon,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            parentId: parentId,
            documentTypeId: documentTypeId,
            chartAccountId: chartAccountId,
            name: name,
            icon: icon,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CategoryTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {parentId = false,
              documentTypeId = false,
              chartAccountId = false,
              transactionDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailRefs) db.transactionDetail
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
                        $$CategoryTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$CategoryTableReferences._parentIdTable(db).id,
                  ) as T;
                }
                if (documentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.documentTypeId,
                    referencedTable:
                        $$CategoryTableReferences._documentTypeIdTable(db),
                    referencedColumn:
                        $$CategoryTableReferences._documentTypeIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$CategoryTableReferences._chartAccountIdTable(db),
                    referencedColumn:
                        $$CategoryTableReferences._chartAccountIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoryTableReferences
                            ._transactionDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryTableReferences(db, table, p0)
                                .transactionDetailRefs,
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

typedef $$CategoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryTable,
    Categories,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (Categories, $$CategoryTableReferences),
    Categories,
    PrefetchHooks Function(
        {bool parentId,
        bool documentTypeId,
        bool chartAccountId,
        bool transactionDetailRefs})>;
typedef $$ContactTableCreateCompanionBuilder = ContactsCompanion Function({
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
typedef $$ContactTableUpdateCompanionBuilder = ContactsCompanion Function({
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

final class $$ContactTableReferences
    extends BaseReferences<_$AppDatabase, $ContactTable, Contacts> {
  $$ContactTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionEntryTable, List<TransactionEntries>>
      _transactionEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionEntry,
              aliasName: $_aliasNameGenerator(
                  db.contact.id, db.transactionEntry.contactId));

  $$TransactionEntryTableProcessedTableManager get transactionEntryRefs {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.contactId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanEntryTable, List<LoanEntries>>
      _loanEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanEntry,
              aliasName:
                  $_aliasNameGenerator(db.contact.id, db.loanEntry.contactId));

  $$LoanEntryTableProcessedTableManager get loanEntryRefs {
    final manager = $$LoanEntryTableTableManager($_db, $_db.loanEntry)
        .filter((f) => f.contactId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContactTableFilterComposer
    extends Composer<_$AppDatabase, $ContactTable> {
  $$ContactTableFilterComposer({
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

  Expression<bool> transactionEntryRefs(
      Expression<bool> Function($$TransactionEntryTableFilterComposer f) f) {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanEntryRefs(
      Expression<bool> Function($$LoanEntryTableFilterComposer f) f) {
    final $$LoanEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableFilterComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactTable> {
  $$ContactTableOrderingComposer({
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

class $$ContactTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactTable> {
  $$ContactTableAnnotationComposer({
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

  Expression<T> transactionEntryRefs<T extends Object>(
      Expression<T> Function($$TransactionEntryTableAnnotationComposer a) f) {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> loanEntryRefs<T extends Object>(
      Expression<T> Function($$LoanEntryTableAnnotationComposer a) f) {
    final $$LoanEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactTable,
    Contacts,
    $$ContactTableFilterComposer,
    $$ContactTableOrderingComposer,
    $$ContactTableAnnotationComposer,
    $$ContactTableCreateCompanionBuilder,
    $$ContactTableUpdateCompanionBuilder,
    (Contacts, $$ContactTableReferences),
    Contacts,
    PrefetchHooks Function({bool transactionEntryRefs, bool loanEntryRefs})> {
  $$ContactTableTableManager(_$AppDatabase db, $ContactTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactTableAnnotationComposer($db: db, $table: table),
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
              ContactsCompanion(
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
              ContactsCompanion.insert(
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
                  (e.readTable(table), $$ContactTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {transactionEntryRefs = false, loanEntryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionEntryRefs) db.transactionEntry,
                if (loanEntryRefs) db.loanEntry
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ContactTableReferences
                            ._transactionEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactTableReferences(db, table, p0)
                                .transactionEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items),
                  if (loanEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ContactTableReferences._loanEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactTableReferences(db, table, p0)
                                .loanEntryRefs,
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

typedef $$ContactTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactTable,
    Contacts,
    $$ContactTableFilterComposer,
    $$ContactTableOrderingComposer,
    $$ContactTableAnnotationComposer,
    $$ContactTableCreateCompanionBuilder,
    $$ContactTableUpdateCompanionBuilder,
    (Contacts, $$ContactTableReferences),
    Contacts,
    PrefetchHooks Function({bool transactionEntryRefs, bool loanEntryRefs})>;
typedef $$WalletTableCreateCompanionBuilder = WalletsCompanion Function({
  Value<int> id,
  required String currencyId,
  required int chartAccountId,
  required String name,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$WalletTableUpdateCompanionBuilder = WalletsCompanion Function({
  Value<int> id,
  Value<String> currencyId,
  Value<int> chartAccountId,
  Value<String> name,
  Value<String?> description,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$WalletTableReferences
    extends BaseReferences<_$AppDatabase, $WalletTable, Wallets> {
  $$WalletTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) => db.currency
      .createAlias($_aliasNameGenerator(db.wallet.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccount.createAlias(
          $_aliasNameGenerator(db.wallet.chartAccountId, db.chartAccount.id));

  $$ChartAccountTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WalletTableFilterComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableFilterComposer({
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

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableFilterComposer get chartAccountId {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableOrderingComposer({
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

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableOrderingComposer get chartAccountId {
    final $$ChartAccountTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableAnnotationComposer({
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

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableAnnotationComposer get chartAccountId {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WalletTable,
    Wallets,
    $$WalletTableFilterComposer,
    $$WalletTableOrderingComposer,
    $$WalletTableAnnotationComposer,
    $$WalletTableCreateCompanionBuilder,
    $$WalletTableUpdateCompanionBuilder,
    (Wallets, $$WalletTableReferences),
    Wallets,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})> {
  $$WalletTableTableManager(_$AppDatabase db, $WalletTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> chartAccountId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              WalletsCompanion(
            id: id,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            name: name,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String currencyId,
            required int chartAccountId,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              WalletsCompanion.insert(
            id: id,
            currencyId: currencyId,
            chartAccountId: chartAccountId,
            name: name,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WalletTableReferences(db, table, e)))
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
                        $$WalletTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$WalletTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$WalletTableReferences._chartAccountIdTable(db),
                    referencedColumn:
                        $$WalletTableReferences._chartAccountIdTable(db).id,
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

typedef $$WalletTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WalletTable,
    Wallets,
    $$WalletTableFilterComposer,
    $$WalletTableOrderingComposer,
    $$WalletTableAnnotationComposer,
    $$WalletTableCreateCompanionBuilder,
    $$WalletTableUpdateCompanionBuilder,
    (Wallets, $$WalletTableReferences),
    Wallets,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})>;
typedef $$CreditCardTableCreateCompanionBuilder = CreditCardsCompanion
    Function({
  Value<int> id,
  required String currencyId,
  required int chartAccountId,
  required String name,
  Value<String?> description,
  required double quota,
  required int closingDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$CreditCardTableUpdateCompanionBuilder = CreditCardsCompanion
    Function({
  Value<int> id,
  Value<String> currencyId,
  Value<int> chartAccountId,
  Value<String> name,
  Value<String?> description,
  Value<double> quota,
  Value<int> closingDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$CreditCardTableReferences
    extends BaseReferences<_$AppDatabase, $CreditCardTable, CreditCards> {
  $$CreditCardTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias(
          $_aliasNameGenerator(db.creditCard.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccount.createAlias($_aliasNameGenerator(
          db.creditCard.chartAccountId, db.chartAccount.id));

  $$ChartAccountTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CreditCardTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardTable> {
  $$CreditCardTableFilterComposer({
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

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableFilterComposer get chartAccountId {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardTable> {
  $$CreditCardTableOrderingComposer({
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

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableOrderingComposer get chartAccountId {
    final $$ChartAccountTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardTable> {
  $$CreditCardTableAnnotationComposer({
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

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableAnnotationComposer get chartAccountId {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditCardTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CreditCardTable,
    CreditCards,
    $$CreditCardTableFilterComposer,
    $$CreditCardTableOrderingComposer,
    $$CreditCardTableAnnotationComposer,
    $$CreditCardTableCreateCompanionBuilder,
    $$CreditCardTableUpdateCompanionBuilder,
    (CreditCards, $$CreditCardTableReferences),
    CreditCards,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})> {
  $$CreditCardTableTableManager(_$AppDatabase db, $CreditCardTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> chartAccountId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> quota = const Value.absent(),
            Value<int> closingDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CreditCardsCompanion(
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
            required int chartAccountId,
            required String name,
            Value<String?> description = const Value.absent(),
            required double quota,
            required int closingDate,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CreditCardsCompanion.insert(
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
                    $$CreditCardTableReferences(db, table, e)
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
                        $$CreditCardTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$CreditCardTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$CreditCardTableReferences._chartAccountIdTable(db),
                    referencedColumn:
                        $$CreditCardTableReferences._chartAccountIdTable(db).id,
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

typedef $$CreditCardTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CreditCardTable,
    CreditCards,
    $$CreditCardTableFilterComposer,
    $$CreditCardTableOrderingComposer,
    $$CreditCardTableAnnotationComposer,
    $$CreditCardTableCreateCompanionBuilder,
    $$CreditCardTableUpdateCompanionBuilder,
    (CreditCards, $$CreditCardTableReferences),
    CreditCards,
    PrefetchHooks Function({bool currencyId, bool chartAccountId})>;
typedef $$JournalEntryTableCreateCompanionBuilder = JournalEntriesCompanion
    Function({
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
typedef $$JournalEntryTableUpdateCompanionBuilder = JournalEntriesCompanion
    Function({
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

final class $$JournalEntryTableReferences
    extends BaseReferences<_$AppDatabase, $JournalEntryTable, JournalEntries> {
  $$JournalEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypeTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentType.createAlias($_aliasNameGenerator(
          db.journalEntry.documentTypeId, db.documentType.id));

  $$DocumentTypeTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypeTableTableManager($_db, $_db.documentType)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$JournalDetailTable, List<JournalDetails>>
      _journalDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.journalDetail,
              aliasName: $_aliasNameGenerator(
                  db.journalEntry.id, db.journalDetail.journalId));

  $$JournalDetailTableProcessedTableManager get journalDetailRefs {
    final manager = $$JournalDetailTableTableManager($_db, $_db.journalDetail)
        .filter((f) => f.journalId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_journalDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionEntryTable, List<TransactionEntries>>
      _transactionEntryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionEntry,
              aliasName: $_aliasNameGenerator(
                  db.journalEntry.id, db.transactionEntry.journalId));

  $$TransactionEntryTableProcessedTableManager get transactionEntryRefs {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.journalId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanDetailTable, List<LoanDetails>>
      _loanDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanDetail,
              aliasName: $_aliasNameGenerator(
                  db.journalEntry.id, db.loanDetail.journalId));

  $$LoanDetailTableProcessedTableManager get loanDetailRefs {
    final manager = $$LoanDetailTableTableManager($_db, $_db.loanDetail)
        .filter((f) => f.journalId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$JournalEntryTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntryTable> {
  $$JournalEntryTableFilterComposer({
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

  $$DocumentTypeTableFilterComposer get documentTypeId {
    final $$DocumentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableFilterComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> journalDetailRefs(
      Expression<bool> Function($$JournalDetailTableFilterComposer f) f) {
    final $$JournalDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableFilterComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionEntryRefs(
      Expression<bool> Function($$TransactionEntryTableFilterComposer f) f) {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanDetailRefs(
      Expression<bool> Function($$LoanDetailTableFilterComposer f) f) {
    final $$LoanDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableFilterComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JournalEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntryTable> {
  $$JournalEntryTableOrderingComposer({
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

  $$DocumentTypeTableOrderingComposer get documentTypeId {
    final $$DocumentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntryTable> {
  $$JournalEntryTableAnnotationComposer({
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

  $$DocumentTypeTableAnnotationComposer get documentTypeId {
    final $$DocumentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> journalDetailRefs<T extends Object>(
      Expression<T> Function($$JournalDetailTableAnnotationComposer a) f) {
    final $$JournalDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journalDetail,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.journalDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionEntryRefs<T extends Object>(
      Expression<T> Function($$TransactionEntryTableAnnotationComposer a) f) {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> loanDetailRefs<T extends Object>(
      Expression<T> Function($$LoanDetailTableAnnotationComposer a) f) {
    final $$LoanDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.journalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JournalEntryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JournalEntryTable,
    JournalEntries,
    $$JournalEntryTableFilterComposer,
    $$JournalEntryTableOrderingComposer,
    $$JournalEntryTableAnnotationComposer,
    $$JournalEntryTableCreateCompanionBuilder,
    $$JournalEntryTableUpdateCompanionBuilder,
    (JournalEntries, $$JournalEntryTableReferences),
    JournalEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool journalDetailRefs,
        bool transactionEntryRefs,
        bool loanDetailRefs})> {
  $$JournalEntryTableTableManager(_$AppDatabase db, $JournalEntryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntryTableAnnotationComposer($db: db, $table: table),
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
              JournalEntriesCompanion(
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
              JournalEntriesCompanion.insert(
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
              .map((e) => (
                    e.readTable(table),
                    $$JournalEntryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              journalDetailRefs = false,
              transactionEntryRefs = false,
              loanDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (journalDetailRefs) db.journalDetail,
                if (transactionEntryRefs) db.transactionEntry,
                if (loanDetailRefs) db.loanDetail
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
                        $$JournalEntryTableReferences._documentTypeIdTable(db),
                    referencedColumn: $$JournalEntryTableReferences
                        ._documentTypeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (journalDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$JournalEntryTableReferences
                            ._journalDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JournalEntryTableReferences(db, table, p0)
                                .journalDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journalId == item.id),
                        typedResults: items),
                  if (transactionEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$JournalEntryTableReferences
                            ._transactionEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JournalEntryTableReferences(db, table, p0)
                                .transactionEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journalId == item.id),
                        typedResults: items),
                  if (loanDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$JournalEntryTableReferences
                            ._loanDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JournalEntryTableReferences(db, table, p0)
                                .loanDetailRefs,
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

typedef $$JournalEntryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JournalEntryTable,
    JournalEntries,
    $$JournalEntryTableFilterComposer,
    $$JournalEntryTableOrderingComposer,
    $$JournalEntryTableAnnotationComposer,
    $$JournalEntryTableCreateCompanionBuilder,
    $$JournalEntryTableUpdateCompanionBuilder,
    (JournalEntries, $$JournalEntryTableReferences),
    JournalEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool journalDetailRefs,
        bool transactionEntryRefs,
        bool loanDetailRefs})>;
typedef $$JournalDetailTableCreateCompanionBuilder = JournalDetailsCompanion
    Function({
  Value<int> id,
  required int journalId,
  required String currencyId,
  required int chartAccountId,
  required double credit,
  required double debit,
  required double rateExchange,
});
typedef $$JournalDetailTableUpdateCompanionBuilder = JournalDetailsCompanion
    Function({
  Value<int> id,
  Value<int> journalId,
  Value<String> currencyId,
  Value<int> chartAccountId,
  Value<double> credit,
  Value<double> debit,
  Value<double> rateExchange,
});

final class $$JournalDetailTableReferences
    extends BaseReferences<_$AppDatabase, $JournalDetailTable, JournalDetails> {
  $$JournalDetailTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $JournalEntryTable _journalIdTable(_$AppDatabase db) =>
      db.journalEntry.createAlias(
          $_aliasNameGenerator(db.journalDetail.journalId, db.journalEntry.id));

  $$JournalEntryTableProcessedTableManager get journalId {
    final manager = $$JournalEntryTableTableManager($_db, $_db.journalEntry)
        .filter((f) => f.id($_item.journalId!));
    final item = $_typedResult.readTableOrNull(_journalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias(
          $_aliasNameGenerator(db.journalDetail.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChartAccountTable _chartAccountIdTable(_$AppDatabase db) =>
      db.chartAccount.createAlias($_aliasNameGenerator(
          db.journalDetail.chartAccountId, db.chartAccount.id));

  $$ChartAccountTableProcessedTableManager get chartAccountId {
    final manager = $$ChartAccountTableTableManager($_db, $_db.chartAccount)
        .filter((f) => f.id($_item.chartAccountId!));
    final item = $_typedResult.readTableOrNull(_chartAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$JournalDetailTableFilterComposer
    extends Composer<_$AppDatabase, $JournalDetailTable> {
  $$JournalDetailTableFilterComposer({
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

  $$JournalEntryTableFilterComposer get journalId {
    final $$JournalEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableFilterComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableFilterComposer get chartAccountId {
    final $$ChartAccountTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableFilterComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalDetailTable> {
  $$JournalDetailTableOrderingComposer({
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

  $$JournalEntryTableOrderingComposer get journalId {
    final $$JournalEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableOrderingComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableOrderingComposer get chartAccountId {
    final $$ChartAccountTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableOrderingComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalDetailTable> {
  $$JournalDetailTableAnnotationComposer({
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

  $$JournalEntryTableAnnotationComposer get journalId {
    final $$JournalEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChartAccountTableAnnotationComposer get chartAccountId {
    final $$ChartAccountTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chartAccountId,
        referencedTable: $db.chartAccount,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartAccountTableAnnotationComposer(
              $db: $db,
              $table: $db.chartAccount,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JournalDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JournalDetailTable,
    JournalDetails,
    $$JournalDetailTableFilterComposer,
    $$JournalDetailTableOrderingComposer,
    $$JournalDetailTableAnnotationComposer,
    $$JournalDetailTableCreateCompanionBuilder,
    $$JournalDetailTableUpdateCompanionBuilder,
    (JournalDetails, $$JournalDetailTableReferences),
    JournalDetails,
    PrefetchHooks Function(
        {bool journalId, bool currencyId, bool chartAccountId})> {
  $$JournalDetailTableTableManager(_$AppDatabase db, $JournalDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> journalId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> chartAccountId = const Value.absent(),
            Value<double> credit = const Value.absent(),
            Value<double> debit = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
          }) =>
              JournalDetailsCompanion(
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
            required int chartAccountId,
            required double credit,
            required double debit,
            required double rateExchange,
          }) =>
              JournalDetailsCompanion.insert(
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
                    $$JournalDetailTableReferences(db, table, e)
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
                        $$JournalDetailTableReferences._journalIdTable(db),
                    referencedColumn:
                        $$JournalDetailTableReferences._journalIdTable(db).id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$JournalDetailTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$JournalDetailTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (chartAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chartAccountId,
                    referencedTable:
                        $$JournalDetailTableReferences._chartAccountIdTable(db),
                    referencedColumn: $$JournalDetailTableReferences
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

typedef $$JournalDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JournalDetailTable,
    JournalDetails,
    $$JournalDetailTableFilterComposer,
    $$JournalDetailTableOrderingComposer,
    $$JournalDetailTableAnnotationComposer,
    $$JournalDetailTableCreateCompanionBuilder,
    $$JournalDetailTableUpdateCompanionBuilder,
    (JournalDetails, $$JournalDetailTableReferences),
    JournalDetails,
    PrefetchHooks Function(
        {bool journalId, bool currencyId, bool chartAccountId})>;
typedef $$TransactionEntryTableCreateCompanionBuilder
    = TransactionEntriesCompanion Function({
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
typedef $$TransactionEntryTableUpdateCompanionBuilder
    = TransactionEntriesCompanion Function({
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

final class $$TransactionEntryTableReferences extends BaseReferences<
    _$AppDatabase, $TransactionEntryTable, TransactionEntries> {
  $$TransactionEntryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypeTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentType.createAlias($_aliasNameGenerator(
          db.transactionEntry.documentTypeId, db.documentType.id));

  $$DocumentTypeTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypeTableTableManager($_db, $_db.documentType)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias(
          $_aliasNameGenerator(db.transactionEntry.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $JournalEntryTable _journalIdTable(_$AppDatabase db) =>
      db.journalEntry.createAlias($_aliasNameGenerator(
          db.transactionEntry.journalId, db.journalEntry.id));

  $$JournalEntryTableProcessedTableManager get journalId {
    final manager = $$JournalEntryTableTableManager($_db, $_db.journalEntry)
        .filter((f) => f.id($_item.journalId!));
    final item = $_typedResult.readTableOrNull(_journalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactTable _contactIdTable(_$AppDatabase db) =>
      db.contact.createAlias(
          $_aliasNameGenerator(db.transactionEntry.contactId, db.contact.id));

  $$ContactTableProcessedTableManager? get contactId {
    if ($_item.contactId == null) return null;
    final manager = $$ContactTableTableManager($_db, $_db.contact)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionDetailTable, List<TransactionDetails>>
      _transactionDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionDetail,
              aliasName: $_aliasNameGenerator(
                  db.transactionEntry.id, db.transactionDetail.transactionId));

  $$TransactionDetailTableProcessedTableManager get transactionDetailRefs {
    final manager =
        $$TransactionDetailTableTableManager($_db, $_db.transactionDetail)
            .filter((f) => f.transactionId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_transactionDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoanDetailTable, List<LoanDetails>>
      _loanDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanDetail,
              aliasName: $_aliasNameGenerator(
                  db.transactionEntry.id, db.loanDetail.transactionId));

  $$LoanDetailTableProcessedTableManager get loanDetailRefs {
    final manager = $$LoanDetailTableTableManager($_db, $_db.loanDetail)
        .filter((f) => f.transactionId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SharedExpenseDetailTable,
      List<SharedExpenseDetails>> _sharedExpenseDetailRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseDetail,
          aliasName: $_aliasNameGenerator(
              db.transactionEntry.id, db.sharedExpenseDetail.transactionId));

  $$SharedExpenseDetailTableProcessedTableManager get sharedExpenseDetailRefs {
    final manager =
        $$SharedExpenseDetailTableTableManager($_db, $_db.sharedExpenseDetail)
            .filter((f) => f.transactionId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TransactionEntryTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionEntryTable> {
  $$TransactionEntryTableFilterComposer({
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

  $$DocumentTypeTableFilterComposer get documentTypeId {
    final $$DocumentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableFilterComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableFilterComposer get journalId {
    final $$JournalEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableFilterComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableFilterComposer get contactId {
    final $$ContactTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableFilterComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transactionDetailRefs(
      Expression<bool> Function($$TransactionDetailTableFilterComposer f) f) {
    final $$TransactionDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionDetail,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionDetailTableFilterComposer(
              $db: $db,
              $table: $db.transactionDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loanDetailRefs(
      Expression<bool> Function($$LoanDetailTableFilterComposer f) f) {
    final $$LoanDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableFilterComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sharedExpenseDetailRefs(
      Expression<bool> Function($$SharedExpenseDetailTableFilterComposer f) f) {
    final $$SharedExpenseDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseDetail,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseDetailTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionEntryTable> {
  $$TransactionEntryTableOrderingComposer({
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

  $$DocumentTypeTableOrderingComposer get documentTypeId {
    final $$DocumentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableOrderingComposer get journalId {
    final $$JournalEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableOrderingComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableOrderingComposer get contactId {
    final $$ContactTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableOrderingComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionEntryTable> {
  $$TransactionEntryTableAnnotationComposer({
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

  $$DocumentTypeTableAnnotationComposer get documentTypeId {
    final $$DocumentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableAnnotationComposer get journalId {
    final $$JournalEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableAnnotationComposer get contactId {
    final $$ContactTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableAnnotationComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transactionDetailRefs<T extends Object>(
      Expression<T> Function($$TransactionDetailTableAnnotationComposer a) f) {
    final $$TransactionDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionDetail,
            getReferencedColumn: (t) => t.transactionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> loanDetailRefs<T extends Object>(
      Expression<T> Function($$LoanDetailTableAnnotationComposer a) f) {
    final $$LoanDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.transactionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sharedExpenseDetailRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseDetailTableAnnotationComposer a)
          f) {
    final $$SharedExpenseDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseDetail,
            getReferencedColumn: (t) => t.transactionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TransactionEntryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionEntryTable,
    TransactionEntries,
    $$TransactionEntryTableFilterComposer,
    $$TransactionEntryTableOrderingComposer,
    $$TransactionEntryTableAnnotationComposer,
    $$TransactionEntryTableCreateCompanionBuilder,
    $$TransactionEntryTableUpdateCompanionBuilder,
    (TransactionEntries, $$TransactionEntryTableReferences),
    TransactionEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool journalId,
        bool contactId,
        bool transactionDetailRefs,
        bool loanDetailRefs,
        bool sharedExpenseDetailRefs})> {
  $$TransactionEntryTableTableManager(
      _$AppDatabase db, $TransactionEntryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionEntryTableAnnotationComposer($db: db, $table: table),
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
              TransactionEntriesCompanion(
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
              TransactionEntriesCompanion.insert(
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
                    $$TransactionEntryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              currencyId = false,
              journalId = false,
              contactId = false,
              transactionDetailRefs = false,
              loanDetailRefs = false,
              sharedExpenseDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionDetailRefs) db.transactionDetail,
                if (loanDetailRefs) db.loanDetail,
                if (sharedExpenseDetailRefs) db.sharedExpenseDetail
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
                    referencedTable: $$TransactionEntryTableReferences
                        ._documentTypeIdTable(db),
                    referencedColumn: $$TransactionEntryTableReferences
                        ._documentTypeIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$TransactionEntryTableReferences._currencyIdTable(db),
                    referencedColumn: $$TransactionEntryTableReferences
                        ._currencyIdTable(db)
                        .id,
                  ) as T;
                }
                if (journalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journalId,
                    referencedTable:
                        $$TransactionEntryTableReferences._journalIdTable(db),
                    referencedColumn: $$TransactionEntryTableReferences
                        ._journalIdTable(db)
                        .id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$TransactionEntryTableReferences._contactIdTable(db),
                    referencedColumn: $$TransactionEntryTableReferences
                        ._contactIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TransactionEntryTableReferences
                            ._transactionDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionEntryTableReferences(db, table, p0)
                                .transactionDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transactionId == item.id),
                        typedResults: items),
                  if (loanDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TransactionEntryTableReferences
                            ._loanDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionEntryTableReferences(db, table, p0)
                                .loanDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transactionId == item.id),
                        typedResults: items),
                  if (sharedExpenseDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TransactionEntryTableReferences
                            ._sharedExpenseDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionEntryTableReferences(db, table, p0)
                                .sharedExpenseDetailRefs,
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

typedef $$TransactionEntryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionEntryTable,
    TransactionEntries,
    $$TransactionEntryTableFilterComposer,
    $$TransactionEntryTableOrderingComposer,
    $$TransactionEntryTableAnnotationComposer,
    $$TransactionEntryTableCreateCompanionBuilder,
    $$TransactionEntryTableUpdateCompanionBuilder,
    (TransactionEntries, $$TransactionEntryTableReferences),
    TransactionEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool journalId,
        bool contactId,
        bool transactionDetailRefs,
        bool loanDetailRefs,
        bool sharedExpenseDetailRefs})>;
typedef $$TransactionDetailTableCreateCompanionBuilder
    = TransactionDetailsCompanion Function({
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
typedef $$TransactionDetailTableUpdateCompanionBuilder
    = TransactionDetailsCompanion Function({
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

final class $$TransactionDetailTableReferences extends BaseReferences<
    _$AppDatabase, $TransactionDetailTable, TransactionDetails> {
  $$TransactionDetailTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TransactionEntryTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionEntry.createAlias($_aliasNameGenerator(
          db.transactionDetail.transactionId, db.transactionEntry.id));

  $$TransactionEntryTableProcessedTableManager get transactionId {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.id($_item.transactionId!));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias($_aliasNameGenerator(
          db.transactionDetail.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FlowTypeTable _flowIdTable(_$AppDatabase db) =>
      db.flowType.createAlias(
          $_aliasNameGenerator(db.transactionDetail.flowId, db.flowType.id));

  $$FlowTypeTableProcessedTableManager get flowId {
    final manager = $$FlowTypeTableTableManager($_db, $_db.flowType)
        .filter((f) => f.id($_item.flowId!));
    final item = $_typedResult.readTableOrNull(_flowIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PaymentTypeTable _paymentTypeIdTable(_$AppDatabase db) =>
      db.paymentType.createAlias($_aliasNameGenerator(
          db.transactionDetail.paymentTypeId, db.paymentType.id));

  $$PaymentTypeTableProcessedTableManager get paymentTypeId {
    final manager = $$PaymentTypeTableTableManager($_db, $_db.paymentType)
        .filter((f) => f.id($_item.paymentTypeId!));
    final item = $_typedResult.readTableOrNull(_paymentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoryTable _categoryIdTable(_$AppDatabase db) =>
      db.category.createAlias($_aliasNameGenerator(
          db.transactionDetail.categoryId, db.category.id));

  $$CategoryTableProcessedTableManager get categoryId {
    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.id($_item.categoryId!));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionDetailTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionDetailTable> {
  $$TransactionDetailTableFilterComposer({
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

  $$TransactionEntryTableFilterComposer get transactionId {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypeTableFilterComposer get flowId {
    final $$FlowTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypeTableFilterComposer(
              $db: $db,
              $table: $db.flowType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableFilterComposer get paymentTypeId {
    final $$PaymentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableFilterComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoryTableFilterComposer get categoryId {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionDetailTable> {
  $$TransactionDetailTableOrderingComposer({
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

  $$TransactionEntryTableOrderingComposer get transactionId {
    final $$TransactionEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableOrderingComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypeTableOrderingComposer get flowId {
    final $$FlowTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypeTableOrderingComposer(
              $db: $db,
              $table: $db.flowType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableOrderingComposer get paymentTypeId {
    final $$PaymentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoryTableOrderingComposer get categoryId {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableOrderingComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionDetailTable> {
  $$TransactionDetailTableAnnotationComposer({
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

  $$TransactionEntryTableAnnotationComposer get transactionId {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FlowTypeTableAnnotationComposer get flowId {
    final $$FlowTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.flowId,
        referencedTable: $db.flowType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FlowTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.flowType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableAnnotationComposer get paymentTypeId {
    final $$PaymentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoryTableAnnotationComposer get categoryId {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionDetailTable,
    TransactionDetails,
    $$TransactionDetailTableFilterComposer,
    $$TransactionDetailTableOrderingComposer,
    $$TransactionDetailTableAnnotationComposer,
    $$TransactionDetailTableCreateCompanionBuilder,
    $$TransactionDetailTableUpdateCompanionBuilder,
    (TransactionDetails, $$TransactionDetailTableReferences),
    TransactionDetails,
    PrefetchHooks Function(
        {bool transactionId,
        bool currencyId,
        bool flowId,
        bool paymentTypeId,
        bool categoryId})> {
  $$TransactionDetailTableTableManager(
      _$AppDatabase db, $TransactionDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionDetailTableAnnotationComposer(
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
              TransactionDetailsCompanion(
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
              TransactionDetailsCompanion.insert(
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
                    $$TransactionDetailTableReferences(db, table, e)
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
                    referencedTable: $$TransactionDetailTableReferences
                        ._transactionIdTable(db),
                    referencedColumn: $$TransactionDetailTableReferences
                        ._transactionIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$TransactionDetailTableReferences._currencyIdTable(db),
                    referencedColumn: $$TransactionDetailTableReferences
                        ._currencyIdTable(db)
                        .id,
                  ) as T;
                }
                if (flowId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.flowId,
                    referencedTable:
                        $$TransactionDetailTableReferences._flowIdTable(db),
                    referencedColumn:
                        $$TransactionDetailTableReferences._flowIdTable(db).id,
                  ) as T;
                }
                if (paymentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paymentTypeId,
                    referencedTable: $$TransactionDetailTableReferences
                        ._paymentTypeIdTable(db),
                    referencedColumn: $$TransactionDetailTableReferences
                        ._paymentTypeIdTable(db)
                        .id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$TransactionDetailTableReferences._categoryIdTable(db),
                    referencedColumn: $$TransactionDetailTableReferences
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

typedef $$TransactionDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionDetailTable,
    TransactionDetails,
    $$TransactionDetailTableFilterComposer,
    $$TransactionDetailTableOrderingComposer,
    $$TransactionDetailTableAnnotationComposer,
    $$TransactionDetailTableCreateCompanionBuilder,
    $$TransactionDetailTableUpdateCompanionBuilder,
    (TransactionDetails, $$TransactionDetailTableReferences),
    TransactionDetails,
    PrefetchHooks Function(
        {bool transactionId,
        bool currencyId,
        bool flowId,
        bool paymentTypeId,
        bool categoryId})>;
typedef $$LoanEntryTableCreateCompanionBuilder = LoanEntriesCompanion Function({
  Value<int> id,
  required String documentTypeId,
  required String currencyId,
  required int contactId,
  required int secuencial,
  required DateTime date,
  required double amount,
  required double rateExchange,
  Value<String?> description,
  required String status,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$LoanEntryTableUpdateCompanionBuilder = LoanEntriesCompanion Function({
  Value<int> id,
  Value<String> documentTypeId,
  Value<String> currencyId,
  Value<int> contactId,
  Value<int> secuencial,
  Value<DateTime> date,
  Value<double> amount,
  Value<double> rateExchange,
  Value<String?> description,
  Value<String> status,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$LoanEntryTableReferences
    extends BaseReferences<_$AppDatabase, $LoanEntryTable, LoanEntries> {
  $$LoanEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypeTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentType.createAlias($_aliasNameGenerator(
          db.loanEntry.documentTypeId, db.documentType.id));

  $$DocumentTypeTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypeTableTableManager($_db, $_db.documentType)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias(
          $_aliasNameGenerator(db.loanEntry.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactTable _contactIdTable(_$AppDatabase db) => db.contact
      .createAlias($_aliasNameGenerator(db.loanEntry.contactId, db.contact.id));

  $$ContactTableProcessedTableManager get contactId {
    final manager = $$ContactTableTableManager($_db, $_db.contact)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LoanDetailTable, List<LoanDetails>>
      _loanDetailRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.loanDetail,
              aliasName:
                  $_aliasNameGenerator(db.loanEntry.id, db.loanDetail.loanId));

  $$LoanDetailTableProcessedTableManager get loanDetailRefs {
    final manager = $$LoanDetailTableTableManager($_db, $_db.loanDetail)
        .filter((f) => f.loanId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_loanDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SharedExpenseDetailTable,
      List<SharedExpenseDetails>> _sharedExpenseDetailRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseDetail,
          aliasName: $_aliasNameGenerator(
              db.loanEntry.id, db.sharedExpenseDetail.loanId));

  $$SharedExpenseDetailTableProcessedTableManager get sharedExpenseDetailRefs {
    final manager =
        $$SharedExpenseDetailTableTableManager($_db, $_db.sharedExpenseDetail)
            .filter((f) => f.loanId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LoanEntryTableFilterComposer
    extends Composer<_$AppDatabase, $LoanEntryTable> {
  $$LoanEntryTableFilterComposer({
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

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$DocumentTypeTableFilterComposer get documentTypeId {
    final $$DocumentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableFilterComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableFilterComposer get contactId {
    final $$ContactTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableFilterComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> loanDetailRefs(
      Expression<bool> Function($$LoanDetailTableFilterComposer f) f) {
    final $$LoanDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.loanId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableFilterComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sharedExpenseDetailRefs(
      Expression<bool> Function($$SharedExpenseDetailTableFilterComposer f) f) {
    final $$SharedExpenseDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseDetail,
        getReferencedColumn: (t) => t.loanId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseDetailTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LoanEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanEntryTable> {
  $$LoanEntryTableOrderingComposer({
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

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$DocumentTypeTableOrderingComposer get documentTypeId {
    final $$DocumentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableOrderingComposer get contactId {
    final $$ContactTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableOrderingComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoanEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanEntryTable> {
  $$LoanEntryTableAnnotationComposer({
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

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$DocumentTypeTableAnnotationComposer get documentTypeId {
    final $$DocumentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactTableAnnotationComposer get contactId {
    final $$ContactTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contact,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactTableAnnotationComposer(
              $db: $db,
              $table: $db.contact,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> loanDetailRefs<T extends Object>(
      Expression<T> Function($$LoanDetailTableAnnotationComposer a) f) {
    final $$LoanDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loanDetail,
        getReferencedColumn: (t) => t.loanId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.loanDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sharedExpenseDetailRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseDetailTableAnnotationComposer a)
          f) {
    final $$SharedExpenseDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseDetail,
            getReferencedColumn: (t) => t.loanId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LoanEntryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LoanEntryTable,
    LoanEntries,
    $$LoanEntryTableFilterComposer,
    $$LoanEntryTableOrderingComposer,
    $$LoanEntryTableAnnotationComposer,
    $$LoanEntryTableCreateCompanionBuilder,
    $$LoanEntryTableUpdateCompanionBuilder,
    (LoanEntries, $$LoanEntryTableReferences),
    LoanEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool contactId,
        bool loanDetailRefs,
        bool sharedExpenseDetailRefs})> {
  $$LoanEntryTableTableManager(_$AppDatabase db, $LoanEntryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> contactId = const Value.absent(),
            Value<int> secuencial = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              LoanEntriesCompanion(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            contactId: contactId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            description: description,
            status: status,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String documentTypeId,
            required String currencyId,
            required int contactId,
            required int secuencial,
            required DateTime date,
            required double amount,
            required double rateExchange,
            Value<String?> description = const Value.absent(),
            required String status,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              LoanEntriesCompanion.insert(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            contactId: contactId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            description: description,
            status: status,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LoanEntryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              currencyId = false,
              contactId = false,
              loanDetailRefs = false,
              sharedExpenseDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (loanDetailRefs) db.loanDetail,
                if (sharedExpenseDetailRefs) db.sharedExpenseDetail
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
                        $$LoanEntryTableReferences._documentTypeIdTable(db),
                    referencedColumn:
                        $$LoanEntryTableReferences._documentTypeIdTable(db).id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$LoanEntryTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$LoanEntryTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$LoanEntryTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$LoanEntryTableReferences._contactIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (loanDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LoanEntryTableReferences._loanDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LoanEntryTableReferences(db, table, p0)
                                .loanDetailRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.loanId == item.id),
                        typedResults: items),
                  if (sharedExpenseDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$LoanEntryTableReferences
                            ._sharedExpenseDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LoanEntryTableReferences(db, table, p0)
                                .sharedExpenseDetailRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.loanId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LoanEntryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LoanEntryTable,
    LoanEntries,
    $$LoanEntryTableFilterComposer,
    $$LoanEntryTableOrderingComposer,
    $$LoanEntryTableAnnotationComposer,
    $$LoanEntryTableCreateCompanionBuilder,
    $$LoanEntryTableUpdateCompanionBuilder,
    (LoanEntries, $$LoanEntryTableReferences),
    LoanEntries,
    PrefetchHooks Function(
        {bool documentTypeId,
        bool currencyId,
        bool contactId,
        bool loanDetailRefs,
        bool sharedExpenseDetailRefs})>;
typedef $$LoanDetailTableCreateCompanionBuilder = LoanDetailsCompanion
    Function({
  Value<int> id,
  required int loanId,
  required String currencyId,
  required String paymentTypeId,
  required int paymentId,
  required int journalId,
  required int transactionId,
  required double amount,
  required double rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$LoanDetailTableUpdateCompanionBuilder = LoanDetailsCompanion
    Function({
  Value<int> id,
  Value<int> loanId,
  Value<String> currencyId,
  Value<String> paymentTypeId,
  Value<int> paymentId,
  Value<int> journalId,
  Value<int> transactionId,
  Value<double> amount,
  Value<double> rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$LoanDetailTableReferences
    extends BaseReferences<_$AppDatabase, $LoanDetailTable, LoanDetails> {
  $$LoanDetailTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LoanEntryTable _loanIdTable(_$AppDatabase db) => db.loanEntry
      .createAlias($_aliasNameGenerator(db.loanDetail.loanId, db.loanEntry.id));

  $$LoanEntryTableProcessedTableManager get loanId {
    final manager = $$LoanEntryTableTableManager($_db, $_db.loanEntry)
        .filter((f) => f.id($_item.loanId!));
    final item = $_typedResult.readTableOrNull(_loanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias(
          $_aliasNameGenerator(db.loanDetail.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PaymentTypeTable _paymentTypeIdTable(_$AppDatabase db) =>
      db.paymentType.createAlias(
          $_aliasNameGenerator(db.loanDetail.paymentTypeId, db.paymentType.id));

  $$PaymentTypeTableProcessedTableManager get paymentTypeId {
    final manager = $$PaymentTypeTableTableManager($_db, $_db.paymentType)
        .filter((f) => f.id($_item.paymentTypeId!));
    final item = $_typedResult.readTableOrNull(_paymentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $JournalEntryTable _journalIdTable(_$AppDatabase db) =>
      db.journalEntry.createAlias(
          $_aliasNameGenerator(db.loanDetail.journalId, db.journalEntry.id));

  $$JournalEntryTableProcessedTableManager get journalId {
    final manager = $$JournalEntryTableTableManager($_db, $_db.journalEntry)
        .filter((f) => f.id($_item.journalId!));
    final item = $_typedResult.readTableOrNull(_journalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TransactionEntryTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionEntry.createAlias($_aliasNameGenerator(
          db.loanDetail.transactionId, db.transactionEntry.id));

  $$TransactionEntryTableProcessedTableManager get transactionId {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.id($_item.transactionId!));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LoanDetailTableFilterComposer
    extends Composer<_$AppDatabase, $LoanDetailTable> {
  $$LoanDetailTableFilterComposer({
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

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$LoanEntryTableFilterComposer get loanId {
    final $$LoanEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableFilterComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableFilterComposer get paymentTypeId {
    final $$PaymentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableFilterComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableFilterComposer get journalId {
    final $$JournalEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableFilterComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableFilterComposer get transactionId {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoanDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanDetailTable> {
  $$LoanDetailTableOrderingComposer({
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

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$LoanEntryTableOrderingComposer get loanId {
    final $$LoanEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableOrderingComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableOrderingComposer get paymentTypeId {
    final $$PaymentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableOrderingComposer get journalId {
    final $$JournalEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableOrderingComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableOrderingComposer get transactionId {
    final $$TransactionEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableOrderingComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoanDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanDetailTable> {
  $$LoanDetailTableAnnotationComposer({
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

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$LoanEntryTableAnnotationComposer get loanId {
    final $$LoanEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PaymentTypeTableAnnotationComposer get paymentTypeId {
    final $$PaymentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentTypeId,
        referencedTable: $db.paymentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.paymentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$JournalEntryTableAnnotationComposer get journalId {
    final $$JournalEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journalId,
        referencedTable: $db.journalEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JournalEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.journalEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableAnnotationComposer get transactionId {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoanDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LoanDetailTable,
    LoanDetails,
    $$LoanDetailTableFilterComposer,
    $$LoanDetailTableOrderingComposer,
    $$LoanDetailTableAnnotationComposer,
    $$LoanDetailTableCreateCompanionBuilder,
    $$LoanDetailTableUpdateCompanionBuilder,
    (LoanDetails, $$LoanDetailTableReferences),
    LoanDetails,
    PrefetchHooks Function(
        {bool loanId,
        bool currencyId,
        bool paymentTypeId,
        bool journalId,
        bool transactionId})> {
  $$LoanDetailTableTableManager(_$AppDatabase db, $LoanDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> loanId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<String> paymentTypeId = const Value.absent(),
            Value<int> paymentId = const Value.absent(),
            Value<int> journalId = const Value.absent(),
            Value<int> transactionId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              LoanDetailsCompanion(
            id: id,
            loanId: loanId,
            currencyId: currencyId,
            paymentTypeId: paymentTypeId,
            paymentId: paymentId,
            journalId: journalId,
            transactionId: transactionId,
            amount: amount,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int loanId,
            required String currencyId,
            required String paymentTypeId,
            required int paymentId,
            required int journalId,
            required int transactionId,
            required double amount,
            required double rateExchange,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              LoanDetailsCompanion.insert(
            id: id,
            loanId: loanId,
            currencyId: currencyId,
            paymentTypeId: paymentTypeId,
            paymentId: paymentId,
            journalId: journalId,
            transactionId: transactionId,
            amount: amount,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LoanDetailTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {loanId = false,
              currencyId = false,
              paymentTypeId = false,
              journalId = false,
              transactionId = false}) {
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
                if (loanId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.loanId,
                    referencedTable:
                        $$LoanDetailTableReferences._loanIdTable(db),
                    referencedColumn:
                        $$LoanDetailTableReferences._loanIdTable(db).id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable:
                        $$LoanDetailTableReferences._currencyIdTable(db),
                    referencedColumn:
                        $$LoanDetailTableReferences._currencyIdTable(db).id,
                  ) as T;
                }
                if (paymentTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paymentTypeId,
                    referencedTable:
                        $$LoanDetailTableReferences._paymentTypeIdTable(db),
                    referencedColumn:
                        $$LoanDetailTableReferences._paymentTypeIdTable(db).id,
                  ) as T;
                }
                if (journalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journalId,
                    referencedTable:
                        $$LoanDetailTableReferences._journalIdTable(db),
                    referencedColumn:
                        $$LoanDetailTableReferences._journalIdTable(db).id,
                  ) as T;
                }
                if (transactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transactionId,
                    referencedTable:
                        $$LoanDetailTableReferences._transactionIdTable(db),
                    referencedColumn:
                        $$LoanDetailTableReferences._transactionIdTable(db).id,
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

typedef $$LoanDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LoanDetailTable,
    LoanDetails,
    $$LoanDetailTableFilterComposer,
    $$LoanDetailTableOrderingComposer,
    $$LoanDetailTableAnnotationComposer,
    $$LoanDetailTableCreateCompanionBuilder,
    $$LoanDetailTableUpdateCompanionBuilder,
    (LoanDetails, $$LoanDetailTableReferences),
    LoanDetails,
    PrefetchHooks Function(
        {bool loanId,
        bool currencyId,
        bool paymentTypeId,
        bool journalId,
        bool transactionId})>;
typedef $$SharedExpenseEntryTableCreateCompanionBuilder
    = SharedExpenseEntriesCompanion Function({
  Value<int> id,
  required String documentTypeId,
  required String currencyId,
  required int secuencial,
  required DateTime date,
  required double amount,
  required double rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$SharedExpenseEntryTableUpdateCompanionBuilder
    = SharedExpenseEntriesCompanion Function({
  Value<int> id,
  Value<String> documentTypeId,
  Value<String> currencyId,
  Value<int> secuencial,
  Value<DateTime> date,
  Value<double> amount,
  Value<double> rateExchange,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$SharedExpenseEntryTableReferences extends BaseReferences<
    _$AppDatabase, $SharedExpenseEntryTable, SharedExpenseEntries> {
  $$SharedExpenseEntryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DocumentTypeTable _documentTypeIdTable(_$AppDatabase db) =>
      db.documentType.createAlias($_aliasNameGenerator(
          db.sharedExpenseEntry.documentTypeId, db.documentType.id));

  $$DocumentTypeTableProcessedTableManager get documentTypeId {
    final manager = $$DocumentTypeTableTableManager($_db, $_db.documentType)
        .filter((f) => f.id($_item.documentTypeId!));
    final item = $_typedResult.readTableOrNull(_documentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias($_aliasNameGenerator(
          db.sharedExpenseEntry.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SharedExpenseDetailTable,
      List<SharedExpenseDetails>> _sharedExpenseDetailRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sharedExpenseDetail,
          aliasName: $_aliasNameGenerator(db.sharedExpenseEntry.id,
              db.sharedExpenseDetail.sharedExpenseId));

  $$SharedExpenseDetailTableProcessedTableManager get sharedExpenseDetailRefs {
    final manager =
        $$SharedExpenseDetailTableTableManager($_db, $_db.sharedExpenseDetail)
            .filter((f) => f.sharedExpenseId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_sharedExpenseDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SharedExpenseEntryTableFilterComposer
    extends Composer<_$AppDatabase, $SharedExpenseEntryTable> {
  $$SharedExpenseEntryTableFilterComposer({
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

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$DocumentTypeTableFilterComposer get documentTypeId {
    final $$DocumentTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableFilterComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> sharedExpenseDetailRefs(
      Expression<bool> Function($$SharedExpenseDetailTableFilterComposer f) f) {
    final $$SharedExpenseDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sharedExpenseDetail,
        getReferencedColumn: (t) => t.sharedExpenseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseDetailTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SharedExpenseEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $SharedExpenseEntryTable> {
  $$SharedExpenseEntryTableOrderingComposer({
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

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$DocumentTypeTableOrderingComposer get documentTypeId {
    final $$DocumentTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableOrderingComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SharedExpenseEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $SharedExpenseEntryTable> {
  $$SharedExpenseEntryTableAnnotationComposer({
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

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$DocumentTypeTableAnnotationComposer get documentTypeId {
    final $$DocumentTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentTypeId,
        referencedTable: $db.documentType,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DocumentTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.documentType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> sharedExpenseDetailRefs<T extends Object>(
      Expression<T> Function($$SharedExpenseDetailTableAnnotationComposer a)
          f) {
    final $$SharedExpenseDetailTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sharedExpenseDetail,
            getReferencedColumn: (t) => t.sharedExpenseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseDetailTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseDetail,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SharedExpenseEntryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedExpenseEntryTable,
    SharedExpenseEntries,
    $$SharedExpenseEntryTableFilterComposer,
    $$SharedExpenseEntryTableOrderingComposer,
    $$SharedExpenseEntryTableAnnotationComposer,
    $$SharedExpenseEntryTableCreateCompanionBuilder,
    $$SharedExpenseEntryTableUpdateCompanionBuilder,
    (SharedExpenseEntries, $$SharedExpenseEntryTableReferences),
    SharedExpenseEntries,
    PrefetchHooks Function(
        {bool documentTypeId, bool currencyId, bool sharedExpenseDetailRefs})> {
  $$SharedExpenseEntryTableTableManager(
      _$AppDatabase db, $SharedExpenseEntryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SharedExpenseEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SharedExpenseEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SharedExpenseEntryTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> documentTypeId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> secuencial = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              SharedExpenseEntriesCompanion(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String documentTypeId,
            required String currencyId,
            required int secuencial,
            required DateTime date,
            required double amount,
            required double rateExchange,
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              SharedExpenseEntriesCompanion.insert(
            id: id,
            documentTypeId: documentTypeId,
            currencyId: currencyId,
            secuencial: secuencial,
            date: date,
            amount: amount,
            rateExchange: rateExchange,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SharedExpenseEntryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {documentTypeId = false,
              currencyId = false,
              sharedExpenseDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sharedExpenseDetailRefs) db.sharedExpenseDetail
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
                    referencedTable: $$SharedExpenseEntryTableReferences
                        ._documentTypeIdTable(db),
                    referencedColumn: $$SharedExpenseEntryTableReferences
                        ._documentTypeIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable: $$SharedExpenseEntryTableReferences
                        ._currencyIdTable(db),
                    referencedColumn: $$SharedExpenseEntryTableReferences
                        ._currencyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sharedExpenseDetailRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$SharedExpenseEntryTableReferences
                            ._sharedExpenseDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SharedExpenseEntryTableReferences(db, table, p0)
                                .sharedExpenseDetailRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sharedExpenseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SharedExpenseEntryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SharedExpenseEntryTable,
    SharedExpenseEntries,
    $$SharedExpenseEntryTableFilterComposer,
    $$SharedExpenseEntryTableOrderingComposer,
    $$SharedExpenseEntryTableAnnotationComposer,
    $$SharedExpenseEntryTableCreateCompanionBuilder,
    $$SharedExpenseEntryTableUpdateCompanionBuilder,
    (SharedExpenseEntries, $$SharedExpenseEntryTableReferences),
    SharedExpenseEntries,
    PrefetchHooks Function(
        {bool documentTypeId, bool currencyId, bool sharedExpenseDetailRefs})>;
typedef $$SharedExpenseDetailTableCreateCompanionBuilder
    = SharedExpenseDetailsCompanion Function({
  Value<int> id,
  required int sharedExpenseId,
  required String currencyId,
  required int loanId,
  required int transactionId,
  required double percentage,
  required double amount,
  required double rateExchange,
  required String status,
});
typedef $$SharedExpenseDetailTableUpdateCompanionBuilder
    = SharedExpenseDetailsCompanion Function({
  Value<int> id,
  Value<int> sharedExpenseId,
  Value<String> currencyId,
  Value<int> loanId,
  Value<int> transactionId,
  Value<double> percentage,
  Value<double> amount,
  Value<double> rateExchange,
  Value<String> status,
});

final class $$SharedExpenseDetailTableReferences extends BaseReferences<
    _$AppDatabase, $SharedExpenseDetailTable, SharedExpenseDetails> {
  $$SharedExpenseDetailTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SharedExpenseEntryTable _sharedExpenseIdTable(_$AppDatabase db) =>
      db.sharedExpenseEntry.createAlias($_aliasNameGenerator(
          db.sharedExpenseDetail.sharedExpenseId, db.sharedExpenseEntry.id));

  $$SharedExpenseEntryTableProcessedTableManager get sharedExpenseId {
    final manager =
        $$SharedExpenseEntryTableTableManager($_db, $_db.sharedExpenseEntry)
            .filter((f) => f.id($_item.sharedExpenseId!));
    final item = $_typedResult.readTableOrNull(_sharedExpenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CurrencyTable _currencyIdTable(_$AppDatabase db) =>
      db.currency.createAlias($_aliasNameGenerator(
          db.sharedExpenseDetail.currencyId, db.currency.id));

  $$CurrencyTableProcessedTableManager get currencyId {
    final manager = $$CurrencyTableTableManager($_db, $_db.currency)
        .filter((f) => f.id($_item.currencyId!));
    final item = $_typedResult.readTableOrNull(_currencyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LoanEntryTable _loanIdTable(_$AppDatabase db) =>
      db.loanEntry.createAlias(
          $_aliasNameGenerator(db.sharedExpenseDetail.loanId, db.loanEntry.id));

  $$LoanEntryTableProcessedTableManager get loanId {
    final manager = $$LoanEntryTableTableManager($_db, $_db.loanEntry)
        .filter((f) => f.id($_item.loanId!));
    final item = $_typedResult.readTableOrNull(_loanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TransactionEntryTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionEntry.createAlias($_aliasNameGenerator(
          db.sharedExpenseDetail.transactionId, db.transactionEntry.id));

  $$TransactionEntryTableProcessedTableManager get transactionId {
    final manager =
        $$TransactionEntryTableTableManager($_db, $_db.transactionEntry)
            .filter((f) => f.id($_item.transactionId!));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SharedExpenseDetailTableFilterComposer
    extends Composer<_$AppDatabase, $SharedExpenseDetailTable> {
  $$SharedExpenseDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$SharedExpenseEntryTableFilterComposer get sharedExpenseId {
    final $$SharedExpenseEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sharedExpenseId,
        referencedTable: $db.sharedExpenseEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseEntryTableFilterComposer(
              $db: $db,
              $table: $db.sharedExpenseEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableFilterComposer get currencyId {
    final $$CurrencyTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableFilterComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LoanEntryTableFilterComposer get loanId {
    final $$LoanEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableFilterComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableFilterComposer get transactionId {
    final $$TransactionEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableFilterComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SharedExpenseDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $SharedExpenseDetailTable> {
  $$SharedExpenseDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$SharedExpenseEntryTableOrderingComposer get sharedExpenseId {
    final $$SharedExpenseEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sharedExpenseId,
        referencedTable: $db.sharedExpenseEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SharedExpenseEntryTableOrderingComposer(
              $db: $db,
              $table: $db.sharedExpenseEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CurrencyTableOrderingComposer get currencyId {
    final $$CurrencyTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableOrderingComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LoanEntryTableOrderingComposer get loanId {
    final $$LoanEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableOrderingComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableOrderingComposer get transactionId {
    final $$TransactionEntryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableOrderingComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SharedExpenseDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $SharedExpenseDetailTable> {
  $$SharedExpenseDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get rateExchange => $composableBuilder(
      column: $table.rateExchange, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$SharedExpenseEntryTableAnnotationComposer get sharedExpenseId {
    final $$SharedExpenseEntryTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.sharedExpenseId,
            referencedTable: $db.sharedExpenseEntry,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SharedExpenseEntryTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sharedExpenseEntry,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$CurrencyTableAnnotationComposer get currencyId {
    final $$CurrencyTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.currencyId,
        referencedTable: $db.currency,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CurrencyTableAnnotationComposer(
              $db: $db,
              $table: $db.currency,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LoanEntryTableAnnotationComposer get loanId {
    final $$LoanEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loanId,
        referencedTable: $db.loanEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoanEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.loanEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TransactionEntryTableAnnotationComposer get transactionId {
    final $$TransactionEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transactionId,
        referencedTable: $db.transactionEntry,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SharedExpenseDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedExpenseDetailTable,
    SharedExpenseDetails,
    $$SharedExpenseDetailTableFilterComposer,
    $$SharedExpenseDetailTableOrderingComposer,
    $$SharedExpenseDetailTableAnnotationComposer,
    $$SharedExpenseDetailTableCreateCompanionBuilder,
    $$SharedExpenseDetailTableUpdateCompanionBuilder,
    (SharedExpenseDetails, $$SharedExpenseDetailTableReferences),
    SharedExpenseDetails,
    PrefetchHooks Function(
        {bool sharedExpenseId,
        bool currencyId,
        bool loanId,
        bool transactionId})> {
  $$SharedExpenseDetailTableTableManager(
      _$AppDatabase db, $SharedExpenseDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SharedExpenseDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SharedExpenseDetailTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SharedExpenseDetailTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sharedExpenseId = const Value.absent(),
            Value<String> currencyId = const Value.absent(),
            Value<int> loanId = const Value.absent(),
            Value<int> transactionId = const Value.absent(),
            Value<double> percentage = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> rateExchange = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              SharedExpenseDetailsCompanion(
            id: id,
            sharedExpenseId: sharedExpenseId,
            currencyId: currencyId,
            loanId: loanId,
            transactionId: transactionId,
            percentage: percentage,
            amount: amount,
            rateExchange: rateExchange,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sharedExpenseId,
            required String currencyId,
            required int loanId,
            required int transactionId,
            required double percentage,
            required double amount,
            required double rateExchange,
            required String status,
          }) =>
              SharedExpenseDetailsCompanion.insert(
            id: id,
            sharedExpenseId: sharedExpenseId,
            currencyId: currencyId,
            loanId: loanId,
            transactionId: transactionId,
            percentage: percentage,
            amount: amount,
            rateExchange: rateExchange,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SharedExpenseDetailTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {sharedExpenseId = false,
              currencyId = false,
              loanId = false,
              transactionId = false}) {
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
                if (sharedExpenseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sharedExpenseId,
                    referencedTable: $$SharedExpenseDetailTableReferences
                        ._sharedExpenseIdTable(db),
                    referencedColumn: $$SharedExpenseDetailTableReferences
                        ._sharedExpenseIdTable(db)
                        .id,
                  ) as T;
                }
                if (currencyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.currencyId,
                    referencedTable: $$SharedExpenseDetailTableReferences
                        ._currencyIdTable(db),
                    referencedColumn: $$SharedExpenseDetailTableReferences
                        ._currencyIdTable(db)
                        .id,
                  ) as T;
                }
                if (loanId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.loanId,
                    referencedTable:
                        $$SharedExpenseDetailTableReferences._loanIdTable(db),
                    referencedColumn: $$SharedExpenseDetailTableReferences
                        ._loanIdTable(db)
                        .id,
                  ) as T;
                }
                if (transactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transactionId,
                    referencedTable: $$SharedExpenseDetailTableReferences
                        ._transactionIdTable(db),
                    referencedColumn: $$SharedExpenseDetailTableReferences
                        ._transactionIdTable(db)
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

typedef $$SharedExpenseDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SharedExpenseDetailTable,
    SharedExpenseDetails,
    $$SharedExpenseDetailTableFilterComposer,
    $$SharedExpenseDetailTableOrderingComposer,
    $$SharedExpenseDetailTableAnnotationComposer,
    $$SharedExpenseDetailTableCreateCompanionBuilder,
    $$SharedExpenseDetailTableUpdateCompanionBuilder,
    (SharedExpenseDetails, $$SharedExpenseDetailTableReferences),
    SharedExpenseDetails,
    PrefetchHooks Function(
        {bool sharedExpenseId,
        bool currencyId,
        bool loanId,
        bool transactionId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountingTypeTableTableManager get accountingType =>
      $$AccountingTypeTableTableManager(_db, _db.accountingType);
  $$DocumentTypeTableTableManager get documentType =>
      $$DocumentTypeTableTableManager(_db, _db.documentType);
  $$FlowTypeTableTableManager get flowType =>
      $$FlowTypeTableTableManager(_db, _db.flowType);
  $$PaymentTypeTableTableManager get paymentType =>
      $$PaymentTypeTableTableManager(_db, _db.paymentType);
  $$CurrencyTableTableManager get currency =>
      $$CurrencyTableTableManager(_db, _db.currency);
  $$ChartAccountTableTableManager get chartAccount =>
      $$ChartAccountTableTableManager(_db, _db.chartAccount);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
  $$ContactTableTableManager get contact =>
      $$ContactTableTableManager(_db, _db.contact);
  $$WalletTableTableManager get wallet =>
      $$WalletTableTableManager(_db, _db.wallet);
  $$CreditCardTableTableManager get creditCard =>
      $$CreditCardTableTableManager(_db, _db.creditCard);
  $$JournalEntryTableTableManager get journalEntry =>
      $$JournalEntryTableTableManager(_db, _db.journalEntry);
  $$JournalDetailTableTableManager get journalDetail =>
      $$JournalDetailTableTableManager(_db, _db.journalDetail);
  $$TransactionEntryTableTableManager get transactionEntry =>
      $$TransactionEntryTableTableManager(_db, _db.transactionEntry);
  $$TransactionDetailTableTableManager get transactionDetail =>
      $$TransactionDetailTableTableManager(_db, _db.transactionDetail);
  $$LoanEntryTableTableManager get loanEntry =>
      $$LoanEntryTableTableManager(_db, _db.loanEntry);
  $$LoanDetailTableTableManager get loanDetail =>
      $$LoanDetailTableTableManager(_db, _db.loanDetail);
  $$SharedExpenseEntryTableTableManager get sharedExpenseEntry =>
      $$SharedExpenseEntryTableTableManager(_db, _db.sharedExpenseEntry);
  $$SharedExpenseDetailTableTableManager get sharedExpenseDetail =>
      $$SharedExpenseDetailTableTableManager(_db, _db.sharedExpenseDetail);
}
