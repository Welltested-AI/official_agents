import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class WidgetCommand extends Command {
  final DataSource generalSource;
  WidgetCommand(this.generalSource);

  /// Inputs
  final codeAttachment = CodeInput('Widget Code', optional: false);
  final extraDetails = StringInput('Instructions', optional: true);
  final contextualCode1 = CodeInput('Contextual Code', optional: true);
  final contextualCode2 = CodeInput('Contextual Code', optional: true);
  final reference1 = CodeInput('Existing Widget Test', optional: true);

  final widgetTestTemplate = '''// necessary imports
import 'package:sample_app/lib/main.dart';

void main() {
  testWidgets('Verify add user button present on ActiveUsers page',
      (WidgetTester tester) async {
    
    //Arrange - Pump MyApp() widget to tester
    await tester.pumpWidget(MyApp());

    //Act - Find button by type 
    var fab = find.byType(FloatingActionButton);

    //Assert - Check that button widget is present
    expect(fab, findsOneWidget);
 
  });
}''';

  @override
  String get slug => 'widget';

  @override
  String get intent => 'Generate widget test';

  @override
  String get textFieldLayout =>
      "To generate widget test, please provide: $codeAttachment \n $extraDetails \n\nSupporting contextual code:$contextualCode1$contextualCode2\n\nA matching existing widget test [Optional]: $reference1";

  @override
  List<DashInput> get registerInputs => [
        codeAttachment,
        extraDetails,
        contextualCode1,
        contextualCode2,
        reference1
      ];

  @override
  List<Step> get steps {
    // Outputs
    final possibleTestOutput = PromptOutput();
    final matchingWorksapceTests = MultiCodeObject();
    final testDocs = MatchDocumentOuput();

    final generatedWidgetTest = PromptOutput();
    return [
      PromptQueryStep(
          prompt:
              'basic concise example template for widget test for $codeAttachment',
          promptOutput: possibleTestOutput),
      WorkspaceQueryStep(
          query: '$possibleTestOutput', output: matchingWorksapceTests),
      MatchDocumentStep(
          query:
              'widget tests for $codeAttachment with instructions: $extraDetails',
          dataSources: [generalSource],
          output: testDocs),
      PromptQueryStep(
        prompt: '''You are a Flutter/Dart widget test writing assistant.

Generate Flutter widget tests covering common as well as edge case scenarios for the code shared below keeping the important instructions in mind:

```dart
$codeAttachment
```

Important instructions shared below:
$extraDetails

Please find additional references that you can use to generate unit tests as well:
```dart
$reference1
```
$matchingWorksapceTests

Sharing some docs and a widget test template that you can use to generate widget test:

$testDocs

```dart
$widgetTestTemplate
```

Additioanl things to keep in mind:
1. Include inline comments for improving code readability.
2. State any assumption made or libraries used while creating widget tests.
            ''',
        promptOutput: generatedWidgetTest,
      ),
      AppendToChatStep(value: '$generatedWidgetTest')
    ];
  }
}
