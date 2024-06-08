import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DocumentCommand extends Command {
  // inputs
  final code = CodeInput('Code', optional: false);
  final additionalInstructions =
      StringInput('Additional Instrunction', optional: true);

  final referenceCode = CodeInput('Reference Code', optional: true);

  // outputs
  final documentedCode = PromptOutput();

  @override
  String get slug => '/document';

  @override
  String get intent => 'Add inline documentation to your code';

  @override
  List<DashInput> get registerInputs =>
      [code, additionalInstructions, referenceCode];

  @override
  String get textFieldLayout =>
      "Hi, Let's generate inline documentation. Please share the following info: $code $referenceCode $additionalInstructions";

  @override
  List<Step> get steps => [
        PromptQueryStep(
            prompt:
                '''You are a coding assistant and instructor who writes professional code.
    
    Please find the user's code <Code>, additional instructional instructions <Additional Instructions>, and relevant references <References> to update existing comments or generate inline documentation if they are not already present in the user shared code.
    
    Code:
    ```dart
    $code
    ```
    
    References:
    ```dart
    $referenceCode
    ```
    
    Additional Instructions: $additionalInstructions
    
    Share the updated code with proper comments back. Keep it as informational as possible for other developers to understand.''',
            promptOutput: documentedCode),
        AppendToChatStep(value: '$documentedCode')
      ];
}
