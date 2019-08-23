///
/// Contains the needed configuration to run the migration on a sqlite database.
///
/// [initializationScript] (required) should create the initial db state in a
/// form of sql script. Every item in the list must contain a single sqlite
/// statement. Must not be empty.
///
/// [migrationScripts] (required) should contain migrations towards the newest
/// db state. Every item in the list must contain a single sqlite statement.
/// Must not be empty.
///
class MigrationConfig {
  final List<String> initializationScript;
  final List<String> migrationScripts;

  MigrationConfig({this.initializationScript, this.migrationScripts})
      : assert(initializationScript != null,
            'The initializationScript cannot be null.'),
        assert(
            migrationScripts != null, 'The migrationScripts cannot be null.');
}
