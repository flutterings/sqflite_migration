import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_migration/sqflite_migration.dart';
import 'package:sqflite_migration/src/migrator.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  test('should not run any executions on an empty initialiazationScript list',
      () async {
    var db = MockDatabase();

    var config = MigrationConfig(
      initializationScript: [],
      migrationScripts: [],
    );

    await Migrator(config).executeInitialization(db, 1);

    verifyZeroInteractions(db);
  });

  test('should run executions on an initialiazationScript list of 1', () async {
    var db = MockDatabase();

    var config = MigrationConfig(
      initializationScript: ['script line 1'],
      migrationScripts: [],
    );

    await Migrator(config).executeInitialization(db, 1);

    verify(db.execute('script line 1'));
  });

  test('should run all executions on an initialiazationScript list', () async {
    var db = MockDatabase();

    var config = MigrationConfig(
      initializationScript: ['script line 1', 'script line 2'],
      migrationScripts: [],
    );

    await Migrator(config).executeInitialization(db, 1);

    verify(db.execute('script line 1'));
    verify(db.execute('script line 2'));
  });

  test('should run any migrations when initializing', () async {
    var db = MockDatabase();

    var config = MigrationConfig(
      initializationScript: ['init script line 1', 'init script line 2'],
      migrationScripts: ['migration script line 1', 'migration script line 2'],
    );

    await Migrator(config)
        .executeInitialization(db, config.migrationScripts.length + 1);

    verify(db.execute('init script line 1'));
    verify(db.execute('init script line 2'));

    verify(db.execute('migration script line 1'));
    verify(db.execute('migration script line 2'));
  });

  test('should throw error if the new version is not greater than the old',
      () async {
    var db = MockDatabase();
    var config = MigrationConfig(
      initializationScript: [],
      migrationScripts: [],
    );

    expect(
        () async => await Migrator(config).executeMigration(db, 1, 1),
        throwsA(TypeMatcher<AssertionError>().having(
            (e) => e.message,
            'message',
            equals(
                'The newVersion(1) should always be greater than the oldVersion(1).'))));
  });

  test(
      'should throw error if the new version is greater than the migration scripts',
      () async {
    var db = MockDatabase();
    var config = MigrationConfig(
      initializationScript: ['init script line 1', 'init script line 2'],
      migrationScripts: [],
    );

    expect(
        () async => await Migrator(config).executeMigration(db, 1, 2),
        throwsA(TypeMatcher<AssertionError>().having(
            (e) => e.message,
            'message',
            equals('New version (2) requires exact 2 migrations.'))));
  });

  test(
      'should throw error if the new version is greater than the migration scripts',
      () async {
    var db = MockDatabase();
    var config = MigrationConfig(
      initializationScript: [],
      migrationScripts: [],
    );

    expect(
        () async => await Migrator(config).executeMigration(db, 1, 2),
        throwsA(TypeMatcher<AssertionError>().having(
            (e) => e.message,
            'message',
            equals('New version (2) requires exact 2 migrations.'))));
  });

  test('should not execute migrations older than the oldVersion', () async {
    var db = MockDatabase();
    var config = MigrationConfig(
      initializationScript: [],
      migrationScripts: [
        'migration line 1',
        'migration line 2',
        'migration line 3',
      ],
    );

    await Migrator(config)
        .executeMigration(db, 2, config.migrationScripts.length + 1);

    verify(db.execute('migration line 2'));
    verify(db.execute('migration line 3'));
  });
}
