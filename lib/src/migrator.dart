import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_migration/src/migration_config.dart';

class Migrator {
  final MigrationConfig config;

  Migrator(this.config);

  Future<void> executeInitialization(Database db, int version) async {
    config.initializationScript
        .forEach((script) async => await db.execute(script));
    config.migrationScripts.forEach((script) async => await db.execute(script));
  }

  Future<void> executeMigration(
      Database db, int oldVersion, int newVersion) async {
    assert(oldVersion < newVersion,
        'The newVersion($newVersion) should always be greater than the oldVersion($oldVersion).');
    assert(config.migrationScripts.length >= newVersion,
        'New version ($newVersion) requires ${newVersion - config.migrationScripts.length} migrations more than what you have.');

    for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
      await db.execute(config.migrationScripts[i]);
    }
  }
}
