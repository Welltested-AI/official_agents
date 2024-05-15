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
      'Generate test for your flame-related code $primaryObject with $testInstructions\n\nOptionally attach any supporting code: $referenceObject1 $referenceObject2 $referenceObject3';

  @override
  List<Step> get steps {
    final testOutput = PromptOutput();
    final testReferences = MatchDocumentOuput();
    return [
      MatchDocumentStep(
          query:
              'examples/instructions of writing tests for flame code - $testInstructions $primaryObject.',
          dataSources: [testDataSource],
          output: testReferences),
      PromptQueryStep(
          prompt:
              '''You are tasked with testing the flame code.
              
Write tests for flame-related code <Code> with instructions - $testInstructions. 

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
import 'package:flame_test/flame_test.dart';
import 'package:flame_test_example/game.dart';
import 'package:flutter_test/flutter_test.dart';

final myGame = FlameTester(MyGame.new);
void main() {
  group('flameTest', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    testWithGame<MyGame>(
      'can load the game',
      MyGame.new,
      (game) async {
        expect(game.world.children.length, 1);
      },
    );

    myGame.testGameWidget(
      'render the game widget',
      verify: (game, tester) async {
        expect(
          find.byGame<MyGame>(),
          findsOneWidget,
        );
      },
    );

    myGame.testGameWidget(
      'render the background correctly',
      setUp: (game, _) async {
        await game.ready();
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<MyGame>(),
          matchesGoldenFile('goldens/game.png'),
        );
      },
    );
  });
}
```
''',
          promptOutput: testOutput),
      AppendToChatStep(value: '$testOutput')
    ];
  }
}
