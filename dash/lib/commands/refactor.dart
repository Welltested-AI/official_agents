import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class RefactorCommand extends Command {
  // Inputs
  final instruction = StringInput('Instruction', optional: false);
  final codeAttachment = CodeInput(
    'Code',
  );

  @override
  String get slug => '/refactor';

  @override
  String get intent => 'Refactor your code';

  @override
  String get textFieldLayout =>
      "Hi, Please share the following info for refactoring: $instruction $codeAttachment";

  @override
  List<DashInput> get registerInputs => [instruction, codeAttachment];

  @override
  List<Step> get steps {
    // Outputs
    final promptOutput = PromptOutput();
    return [
      PromptQueryStep(
        prompt: '''You are a coding assistant helping user to write code.


            Please find instructions provided my users <Instructions> and the code that is need to be modified <Code> based on the provided instructions:

            Instructions: $instruction

            Code:
            ```dart
            $codeAttachment
            ```
            
            Note: State any assumption made and improvements introduced used while modification.
            ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
