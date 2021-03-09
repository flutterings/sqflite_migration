import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

final initialScript = [
  '''
create table _todo_list (
  id integer primary key autoincrement,
  alias text not null
  )
''',
  '''
create table _task (
  id integer primary key autoincrement,
  description text,
  todo_list_id integer not null,
  CONSTRAINT fk_todo_lists
    FOREIGN KEY (todo_list_id)
    REFERENCES _todo_list(id)
);
'''
];

final migrations = [
  '''
  alter table _task add column done integer default 0;
  '''
];

final config = MigrationConfig(
    initializationScript: initialScript, migrationScripts: migrations);

class DatabaseRepository {
  static Database? _database;
  String? path;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await (getDatabasesPath() as FutureOr<String>);
    final path = join(databasesPath, 'test.db');

    return await openDatabaseWithMigration(path, config);
  }

  Future<Map?> findById(int id) async {
    final db = await (database as FutureOr<Database>);
    List<Map> maps = await db.query('_task',
        columns: ['id', 'description'], where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
