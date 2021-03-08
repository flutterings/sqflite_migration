import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/src/migration_config.dart';

///
/// An internal class which contains methods to execute the initial and
/// migration scripts.
///
/// [config] (required) the migration configuration to execute.
///
class Migrator {
  final MigrationConfig config;

  Migrator(this.config);

  Future<void> executeInitialization(Database db, int version) async {
    for (String script in config.initializationScript) {
      await db.execute(script);
    }

    for (String script in config.migrationScripts) {
      await db.execute(script);
    }
  }

  Future<void> executeMigration(
      Database db, int oldVersion, int newVersion) async {
    assert(oldVersion < newVersion,
        'The newVersion($newVersion) should always be greater than the oldVersion($oldVersion).');
    assert(config.migrationScripts.length == newVersion - 1,
    'New version ($newVersion) requires exact ${newVersion - config.migrationScripts.length} migrations.');

    for (var i = oldVersion - 1; i < newVersion - 1; i++) {
      await db.execute(config.migrationScripts[i]);
    }
  }
}
