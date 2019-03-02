import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:sqflite_migration/sqflite_migration.dart';

void main() {
  final populatedScript = ['script line 1', 'script line 2'];

  test('should throw assertion when initializationScript is null', () async {
    expect(
        () => MigrationConfig(migrationScripts: populatedScript),
        throwsA(TypeMatcher<AssertionError>().having((e) => e.message,
            'message', equals('The initializationScript cannot be null.'))));
  });

  test('should throw assertion when migrationScript is null', () async {
    expect(
        () => MigrationConfig(initializationScript: populatedScript),
        throwsA(TypeMatcher<AssertionError>().having((e) => e.message,
            'message', equals('The migrationScripts cannot be null.'))));
  });

  test('should throw assertion when initializationScript is empty', () async {
    expect(
        () => MigrationConfig(
            initializationScript: [], migrationScripts: populatedScript),
        throwsA(TypeMatcher<AssertionError>().having((e) => e.message,
            'message', contains('The initializationScript cannot be empty.'))));
  });

  test('should throw assertion when migrationScript is empty', () async {
    expect(
        () => MigrationConfig(
            initializationScript: populatedScript, migrationScripts: []),
        throwsA(TypeMatcher<AssertionError>().having((e) => e.message,
            'message', equals('The migrationScripts cannot be empty.'))));
  });
}
