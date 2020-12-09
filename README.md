[![Build Status](https://travis-ci.org/flutterings/sqflite_migration.svg?branch=master)](https://travis-ci.org/flutterings/sqflite_migration)
[![codecov](https://codecov.io/gh/flutterings/sqflite_migration/branch/master/graph/badge.svg)](https://codecov.io/gh/flutterings/sqflite_migration)

# Migrate your mobile sqlite database

Library to manage sqlite db migrations using [sqflite](https://pub.dartlang.org/packages/sqflite) plugin.

## Getting Started

```dart
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

final config = MigrationConfig(initializationScript: initialScript, migrationScripts: migrations);

Future<Database> open() async {
 final databasesPath = await getDatabasesPath();
 final path = join(databasesPath, 'test.db');
 
 return await openDatabaseWithMigration(path, config);
}
```
