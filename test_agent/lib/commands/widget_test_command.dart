import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class WidgetTestCommand extends Command {
  WidgetTestCommand();

  /// Inputs
  final extraDetails = StringInput('Additional Details', optional: true);
  final codeAttachment = CodeInput('Testable code', optional: false);
  final references = CodeInput('Existing References', optional: true);

  @override
  String get slug => 'widget';

  @override
  String get intent => 'Generate widget test';

  @override
  String get textFieldLayout =>
      "Hi, please share the code and any other optional instructions to be following while generating widget test. \nCode: $codeAttachment \nAdditional Details[Optional] $extraDetails \nReference[Optional]: $references";

  @override
  List<DashInput> get registerInputs =>
      [extraDetails, codeAttachment, references];

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
            $references
            ```
            ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
