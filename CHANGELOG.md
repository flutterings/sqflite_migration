# Change Log for sqflite_migration
A library to enable sqlite db migrations, using sqflite plugin.

## [v0.3.0](http://github.com/flutterings/sqflite_migration/compare/v0.2.0...v0.3.0) - 2021-04-14

### Feats
* Support null-safety.
[36a4011](https://github.com/flutterings/sqflite_migration/commit/36a4011fdd0def1469c28bb154f3edb0d0b93319)

### Bugs
* Fixed async/await bug in executeInitialization function.
[0fb80ae](https://github.com/flutterings/sqflite_migration/commit/0fb80aee26564d3df92e4950b3976d94f8db3abc)

### Docs
* Fix example code in documentation.
[3a36bdf](https://github.com/flutterings/sqflite_migration/commit/3a36bdf3227df1894e17a5ff15917a9a96d1aa34)
[3a36bdf](https://github.com/flutterings/sqflite_migration/commit/3a36bdf3227df1894e17a5ff15917a9a96d1aa34)

## [v0.2.0](http://github.com/flutterings/sqflite_migration/compare/v0.1.1...v0.2.0) - 2020-09-04

### Bugs
* Based on open_database_with_migration.dart new version of database every time will be equal migrations.length + 1. Situation when we'll perform migration to the version lesser than migrations.length + 1 looks impossible, because of the way we determine the current version. In this case assertion should check it in the manner suggested by the current PR. [ad24d00](https://github.com/flutterings/sqflite_migration/commit/ad24d00874189fbf8c73ef4a8b60cceb9f3d1748)

## [v0.1.2](http://github.com/flutterings/sqflite_migration/compare/v0.1.1...v0.1.2) - 2019-08-23

### Test
* remove deprecated failing tests [dfc249c](https://github.com/flutterings/sqflite_migration/commit/dfc249c48ec5d350561762444dd104778c35a564)

## [v0.1.1](http://github.com/flutterings/sqflite_migration/compare/v0.1.0...v0.1.1) - 2019-08-23

### Chore
* replace deprecated fonts-droid dependency in travis, with fonts-droid-fallback [091605a](https://github.com/flutterings/sqflite_migration/commit/091605a5089d8f3614074cdbb00aacd6258d7c91)

### Bugs
* allow empty scripts array closes #2 [5d22773](https://github.com/flutterings/sqflite_migration/commit/5d2277350eddfab27e58a042421752c8e80f373a)

## [v0.1.0](http://github.com/flutterings/sqflite_migration/compare/v0.0.2...v0.1.0) - 2019-03-19

### Chore
* fix formatting issue [9038c91](https://github.com/flutterings/sqflite_migration/commit/9038c916ff224ac413972b67a32de2b7ba91a8a6)

### Docs
* add example [6ce670a](https://github.com/flutterings/sqflite_migration/commit/6ce670a2da4ccc642d76e83dd2b1cee279ca097b)

## [v0.0.2](http://github.com/flutterings/sqflite_migration/compare/v0.0.1...v0.0.2) - 2019-03-04

### Chore
* fix formatting issue [8155d98](https://github.com/flutterings/sqflite_migration/commit/8155d98093e6e02a339f9a432f4799fd98047db8)

### Fixes
* Use dart:async imports to make the library backward compatible. [6b4194e](https://github.com/flutterings/sqflite_migration/commit/6b4194ec734585cdc07dd99ca296b9e3a75bb0b7)

### Docs
* enhance package description. [e6804ba](https://github.com/flutterings/sqflite_migration/commit/e6804ba14c014414ae919531d7f92c1c09d1d68c)


This CHANGELOG.md was generated with [**Changelog for Dart**](https://pub.dartlang.org/packages/changelog)
