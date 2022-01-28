// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psschooldb.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPsSchoolDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PsSchoolDBBuilder databaseBuilder(String name) =>
      _$PsSchoolDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PsSchoolDBBuilder inMemoryDatabaseBuilder() =>
      _$PsSchoolDBBuilder(null);
}

class _$PsSchoolDBBuilder {
  _$PsSchoolDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PsSchoolDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PsSchoolDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PsSchoolDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PsSchoolDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PsSchoolDB extends PsSchoolDB {
  _$PsSchoolDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  DptListDao? _dptDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `pass` TEXT NOT NULL, `rollNo` TEXT NOT NULL, `dpt` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DptListEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `newDpt` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  DptListDao get dptDao {
    return _dptDaoInstance ??= _$DptListDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'UserEntity',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pass': item.pass,
                  'rollNo': item.rollNo,
                  'dpt': item.dpt
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'UserEntity',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pass': item.pass,
                  'rollNo': item.rollNo,
                  'dpt': item.dpt
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'UserEntity',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pass': item.pass,
                  'rollNo': item.rollNo,
                  'dpt': item.dpt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> getAllUser() async {
    return _queryAdapter.queryList('SELECT * FROM UserEntity',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pass: row['pass'] as String,
            dpt: row['dpt'] as String,
            rollNo: row['rollNo'] as String));
  }

  @override
  Future<UserEntity?> getUserByEmail(String _email) async {
    return _queryAdapter.query('SELECT * FROM UserEntity WHERE email=?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pass: row['pass'] as String,
            dpt: row['dpt'] as String,
            rollNo: row['rollNo'] as String),
        arguments: [_email]);
  }

  @override
  Future<List<UserEntity>> getUserDptWise(String dept) async {
    return _queryAdapter.queryList('SELECT * FROM UserEntity WHERE dpt=?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pass: row['pass'] as String,
            dpt: row['dpt'] as String,
            rollNo: row['rollNo'] as String),
        arguments: [dept]);
  }

  @override
  Future<UserEntity?> getSingleUser(int id) async {
    return _queryAdapter.query('SELECT * FROM UserEntity WHERE id=?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pass: row['pass'] as String,
            dpt: row['dpt'] as String,
            rollNo: row['rollNo'] as String),
        arguments: [id]);
  }

  @override
  Future<List<int>> addUser(List<UserEntity> ue) {
    return _userEntityInsertionAdapter.insertListAndReturnIds(
        ue, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserEntity ue) async {
    await _userEntityUpdateAdapter.update(ue, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserEntity ue) async {
    await _userEntityDeletionAdapter.delete(ue);
  }
}

class _$DptListDao extends DptListDao {
  _$DptListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dptListEntityInsertionAdapter = InsertionAdapter(
            database,
            'DptListEntity',
            (DptListEntity item) =>
                <String, Object?>{'id': item.id, 'newDpt': item.dptName}),
        _dptListEntityUpdateAdapter = UpdateAdapter(
            database,
            'DptListEntity',
            ['id'],
            (DptListEntity item) =>
                <String, Object?>{'id': item.id, 'newDpt': item.dptName}),
        _dptListEntityDeletionAdapter = DeletionAdapter(
            database,
            'DptListEntity',
            ['id'],
            (DptListEntity item) =>
                <String, Object?>{'id': item.id, 'newDpt': item.dptName});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DptListEntity> _dptListEntityInsertionAdapter;

  final UpdateAdapter<DptListEntity> _dptListEntityUpdateAdapter;

  final DeletionAdapter<DptListEntity> _dptListEntityDeletionAdapter;

  @override
  Future<List<DptListEntity>> getAllDpt() async {
    return _queryAdapter.queryList('SELECT * FROM DptListEntity',
        mapper: (Map<String, Object?> row) => DptListEntity(
            id: row['id'] as int?, dptName: row['newDpt'] as String));
  }

  @override
  Future<List<DptListEntity>> getAllDptExcept(String dpt) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DptListEntity WHERE newDpt IS NOT ?1',
        mapper: (Map<String, Object?> row) => DptListEntity(
            id: row['id'] as int?, dptName: row['newDpt'] as String),
        arguments: [dpt]);
  }

  @override
  Future<DptListEntity?> getOnlyDpt(String oldDpt) async {
    return _queryAdapter.query('SELECT * FROM DptListEntity WHERE newDpt=?1',
        mapper: (Map<String, Object?> row) => DptListEntity(
            id: row['id'] as int?, dptName: row['newDpt'] as String),
        arguments: [oldDpt]);
  }

  @override
  Future<DptListEntity?> getDptFromId(int _id) async {
    return _queryAdapter.query('SELECT * FROM DptListEntity WHERE id=?1',
        mapper: (Map<String, Object?> row) => DptListEntity(
            id: row['id'] as int?, dptName: row['newDpt'] as String),
        arguments: [_id]);
  }

  @override
  Future<List<int>> addDpt(List<DptListEntity> dlEntity) {
    return _dptListEntityInsertionAdapter.insertListAndReturnIds(
        dlEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDpt(DptListEntity upDlEntity) async {
    await _dptListEntityUpdateAdapter.update(
        upDlEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDPt(DptListEntity dDlEntity) async {
    await _dptListEntityDeletionAdapter.delete(dDlEntity);
  }
}
