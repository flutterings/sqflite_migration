import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/src/migration_config.dart';
import 'package:sqflite_migration/src/migrator.dart';

///
/// Open the database at a given path, while running the provided migration
/// scripts.
///
/// [config] (required) specifies the migration configuration.
///
Future<Database> openDatabaseWithMigration(
    String path, MigrationConfig config) async {
  final migrator = Migrator(config);
  return await openDatabase(path,
      version: config.migrationScripts.length + 1,
      onCreate: migrator.executeInitialization,
      onUpgrade: migrator.executeMigration);
}
