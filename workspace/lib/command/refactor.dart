import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class RefactorCommand extends Command {
  /// Inputs
  final instruction = StringInput('Instruction', optional: false);
  final codeAttachment = CodeInput(
    'Code',
  );

  @override
  String get slug => 'refactor';

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
        prompt:
            '''You are a Flutter/Dart assistant helping user modify code within their editor window.

            Modification instructions from user: <736841542> 
            
            Please find the editor file code. To represent the selected code, we have it highlighted with <CURSOR_SELECTION> ..... <CURSOR_SELECTION>.
            <805088184>
            
           Proceed step by step: 
           1. Describe the selected piece of code.
           2. What are the possible optimizations?
           3. How do you plan to achieve that ? [Dont output code yet]
           4. Output the modified code to be be programatically replaced in the editor in place of the CURSOR_SELECTION.
           
           Since this is without human review, you need to output the precise CURSOR_SELECTION
            
          IMPORTANT NOTE: Please make sure to output the modified code in a single code block. Do not just give explanation prose but also give the final code at last.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
