import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_migration/sqflite_migration.dart';

class MockConfig extends Mock implements MigrationConfig {}

void main() {
  test('should pass the path to sqflite', () async {
    final config = MockConfig();
    when(config.migrationScripts).thenReturn([]);
    final log = [];

    await openDatabaseWithMigration('path', config,
        openDatabase: (
          path, {
          int version,
          OnDatabaseConfigureFn onConfigure,
          OnDatabaseCreateFn onCreate,
          OnDatabaseVersionChangeFn onUpgrade,
        }) =>
            log.add(path));

    expect(log, ['path']);
  });

  test(
      'should determine the version according to the number of migration scripts',
      () async {
    final config = MockConfig();
    when(config.migrationScripts).thenReturn(['script 1', 'script 2']);
    final log = [];

    await openDatabaseWithMigration('path', config,
        openDatabase: (
          path, {
          int version,
          OnDatabaseConfigureFn onConfigure,
          OnDatabaseCreateFn onCreate,
          OnDatabaseVersionChangeFn onUpgrade,
        }) =>
            log.add(version));

    expect(log, [3]);
  });
}
