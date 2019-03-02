import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_migration/sqflite_migration.dart';
import 'package:sqflite_migration/src/migrator.dart';

class MockConfig extends Mock implements MigrationConfig {}
class MockDatabase extends Mock implements Database {}

void main() {
  test('should not run any executions on an empty initialiazationScript list',
      () async {
    var db = MockDatabase();

    var config = MockConfig();
    when(config.initializationScript).thenReturn([]);
    when(config.migrationScripts).thenReturn([]);

    await Migrator(config).executeInitialization(db, 1);

    verifyZeroInteractions(db);
  });

  test('should run executions on an initialiazationScript list of 1', () async {
    var db = MockDatabase();

    var config = MockConfig();
    when(config.initializationScript).thenReturn(['script line 1']);
    when(config.migrationScripts).thenReturn([]);

    await Migrator(config).executeInitialization(db, 1);

    verify(db.execute('script line 1'));
  });

  test('should run all executions on an initialiazationScript list', () async {
    var db = MockDatabase();

    var config = MockConfig();
    when(config.initializationScript)
        .thenReturn(['script line 1', 'script line 2']);
    when(config.migrationScripts).thenReturn([]);

    await Migrator(config).executeInitialization(db, 1);

    verify(db.execute('script line 1'));
    verify(db.execute('script line 2'));
  });

  test('should run any migrations when initializing', () async {
    var db = MockDatabase();

    var config = MockConfig();
    when(config.initializationScript)
        .thenReturn(['init script line 1', 'init script line 2']);
    when(config.migrationScripts)
        .thenReturn(['migration script line 1', 'migration script line 2']);

    await Migrator(config).executeInitialization(db, 1);

    verify(db.execute('init script line 1'));
    verify(db.execute('init script line 2'));

    verify(db.execute('migration script line 1'));
    verify(db.execute('migration script line 2'));
  });

  test('should throw error if the new version is not greater than the old',
      () async {
    var db = MockDatabase();
    var config = MockConfig();

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
    var config = MockConfig();
    when(config.migrationScripts).thenReturn([]);

    expect(
        () async => await Migrator(config).executeMigration(db, 1, 2),
        throwsA(TypeMatcher<AssertionError>().having(
            (e) => e.message,
            'message',
            equals(
                'New version (2) requires 2 migrations more than what you have.'))));
  });

  test(
      'should throw error if the new version is greater than the migration scripts',
      () async {
    var db = MockDatabase();
    var config = MockConfig();
    when(config.migrationScripts).thenReturn([]);

    expect(
        () async => await Migrator(config).executeMigration(db, 1, 2),
        throwsA(TypeMatcher<AssertionError>().having(
            (e) => e.message,
            'message',
            equals(
                'New version (2) requires 2 migrations more than what you have.'))));
  });

  test('should not execute migrations older than the oldVersion', () async {
    var db = MockDatabase();
    var config = MockConfig();
    when(config.migrationScripts).thenReturn([
      'migration line 1',
      'migration line 2',
      'migration line 3',
    ]);

    await Migrator(config).executeMigration(db, 2, 3);

    verify(db.execute('migration line 2'));
    verify(db.execute('migration line 3'));
  });

  test('should not execute migrations newer than the newVersion', () async {
    var db = MockDatabase();
    var config = MockConfig();
    when(config.migrationScripts).thenReturn([
      'migration line 1',
      'migration line 2',
      'migration line 3',
    ]);

    await Migrator(config).executeMigration(db, 1, 2);

    verify(db.execute('migration line 1'));
    verify(db.execute('migration line 2'));
  });
}
