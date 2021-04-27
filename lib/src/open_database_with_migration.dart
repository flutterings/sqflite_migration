import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/src/migration_config.dart';
import 'package:sqflite_migration/src/migrator.dart';

///
/// Open the database at a given path, while running the provided migration
/// scripts.
///
/// [path] (required) specifies the path to the database file.
/// [config] (required) specifies the migration configuration.
/// [openDatabase] (optional) do not override this. It is used for testing.
/// [onConfigure] (optional) is the first callback invoked when opening
/// the database.
///
Future<Database> openDatabaseWithMigration(
  String path,
  MigrationConfig config, {
  openDatabase = openDatabase,
  onConfigure = onConfigure,
}) async {
  final migrator = Migrator(config);
  final configure = onConfigure;
  return await openDatabase(
    path,
    version: config.migrationScripts.length + 1,
    onCreate: migrator.executeInitialization,
    onUpgrade: migrator.executeMigration,
    onConfigure: configure,
  );
}
