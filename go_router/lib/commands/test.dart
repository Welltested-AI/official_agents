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
  String get intent => 'Write tests for your navigation related code using go_router';

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
      'Generate test for your go_router-related code $primaryObject with $testInstructions\n\nOptionally attach any supporting code: $referenceObject1 $referenceObject2 $referenceObject3';

  @override
  List<Step> get steps {
    final testOutput = PromptOutput();
    final testReferences = MatchDocumentOuput();
    return [
      MatchDocumentStep(
          query:
              'examples/instructions of writing tests for go_router code - $testInstructions $primaryObject.',
          dataSources: [testDataSource],
          output: testReferences),
      PromptQueryStep(
          prompt:
              '''You are tasked with testing the navigation functionality implemented using the go_router package in a Flutter app. Your goal is to ensure that the navigation flows smoothly, routes are correctly defined, and route parameters are handled accurately. 
              
Write tests for the Flutter go_router related code <Code> with instructions - $testInstructions. 

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
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_examples/on_exit.dart' as example;

void main() {
  testWidgets('testing on_exit navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const example.MyApp());

    await tester.tap(find.text('Go to the Details screen'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure to leave this page?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(example.DetailsScreen), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure to leave this page?'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.byType(example.HomeScreen), findsOneWidget);
  });
}
```
''',
          promptOutput: testOutput),
      AppendToChatStep(value: '$testOutput')
    ];
  }
}
