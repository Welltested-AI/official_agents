import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class WidgetCommand extends Command {
  WidgetCommand();

  /// Inputs
  final extraDetails = StringInput('Additional Details', optional: true);
  final codeAttachment = CodeInput('Testable code', optional: false);
  final reference1 = CodeInput('Existing Reference', optional: true);
  final reference2 = CodeInput('Existing Reference', optional: true);
  final reference3 = CodeInput('Existing Reference', optional: true);
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
      "Hi, I'm here to help you generate widget tests for your codebase. Please share the following info: $codeAttachment \n $extraDetails \nReferences [Optional]: $reference1 $reference2 $reference3";

  @override
  List<DashInput> get registerInputs =>
      [extraDetails, codeAttachment, reference1, reference2, reference3];

  @override
  List<Step> get steps {
    // Outputs
    final promptOutput = PromptOutput();
    return [
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
// Reference 1
$reference1

// Reference 2
$reference2

// Reference 3
$reference3
```

Sharing widget test template that you can use to generate widget test:
```dart
$widgetTestTemplate
```

Additioanl things to keep in mind:
1. Include inline comments for improving code readability.
2. State any assumption made or libraries used while creating widget tests.
            ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
