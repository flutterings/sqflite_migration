class MigrationConfig {
  final List<String> initializationScript;
  final List<String> migrationScripts;

  MigrationConfig({this.initializationScript, this.migrationScripts})
      : assert(initializationScript != null,
            'The initializationScript cannot be null.'),
        assert(
            migrationScripts != null, 'The migrationScripts cannot be null.'),
        assert(initializationScript.isNotEmpty,
            'The initializationScript cannot be empty.'),
        assert(migrationScripts.isNotEmpty,
            'The migrationScripts cannot be empty.');
}
