import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class TestCommand extends Command {
  TestCommand(this.testDataSource);
  final DataSource testDataSource;
  final primaryObject = CodeInput('Test Object');
  final testInstructions = StringInput('Instructions', optional: true);
  final referenceObject1 = CodeInput('Reference', optional: true);
  final referenceObject2 = CodeInput('Reference', optional: true);
  final referenceObject3 = CodeInput('Reference', optional: true);
  @override
  String get intent => 'Write tests for your navigation related code using sqflite';

  @override
  List<DashInput> get registerInputs => [
        primaryObject,
        testInstructions,
        referenceObject1,
        referenceObject2,
        referenceObject3
      ];

  @override
  String get slug => 'test';

  @override
  String get textFieldLayout =>
      'Generate test for your sqflite-related code $primaryObject with $testInstructions\n\nOptionally attach any supporting code: $referenceObject1 $referenceObject2 $referenceObject3';

  @override
  List<Step> get steps {
    final testOutput = PromptOutput();
    final testReferences = MatchDocumentOuput();
    return [
      MatchDocumentStep(
          query:
              'examples/instructions of writing tests for sqflite code - $testInstructions $primaryObject.',
          dataSources: [testDataSource],
          output: testReferences),
      PromptQueryStep(
          prompt:
              '''You are tasked with testing the storage functionality implemented using the sqflite package in a Flutter app. Your goal is to create test code as per the user requirements including(but not limited to) ensuringthat data is stored, retrieved, updated, and deleted accurately from the SQLite database, and that asynchronous operations are handled correctly. 
              
Write integration tests using flutter driver for the Flutter sqflite related code <Code> with instructions - $testInstructions. 

Code:
```dart
$primaryObject
```

Here are some contextual code or references provided by the user:
```dart
// reference 1
$referenceObject1

// reference 2
$referenceObject2

// reference 3
$referenceObject3
```

Few sample Unit tests unrelated to the above scenerio as a reference:

```dart
$testReferences
```

```dart
import 'dart:io';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide test;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_example/src/common_import.dart';
import 'package:test/test.dart' show test;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('sqflite open db', () {
      test('missing directory', () async {
        //await devVerbose();
        final path = join('test_missing_sub_dir', 'simple.db');
        try {
          await Directory(join(await getDatabasesPath(), dirname(path)))
              .delete(recursive: true);
        } catch (_) {}
        final db =
            await openDatabase(path, version: 1, onCreate: (db, version) async {
          expect(await db.getVersion(), 0);
        });
        expect(await db.getVersion(), 1);
        await db.close();
      });
      test('failure', () {
        // This one seems ignored
        // fail('regular test failure');
      });
      test('in_memory', () async {
        final db = await openDatabase(inMemoryDatabasePath, version: 1,
            onCreate: (db, version) async {
          expect(await db.getVersion(), 0);
        });
        expect(await db.getVersion(), 1);
        await db.close();
      });
  });
}
```
''',
          promptOutput: testOutput),
      AppendToChatStep(value: '$testOutput')
    ];
  }
}
