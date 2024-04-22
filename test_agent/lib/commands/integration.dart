import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class IntegrationCommand extends Command {
  // inputs
  final testFlow = StringInput('Test Flow', optional: false);
  final testCode1 = CodeInput('Code 1', optional: false);
  final testCode2 = CodeInput('Code 2', optional: true);
  final testCode3 = CodeInput('Code 3', optional: true);
  final testCode4 = CodeInput('Code 4', optional: true);
  final testCode5 = CodeInput('Code 5', optional: true);
  final testCode6 = CodeInput('Code 6', optional: true);
  final testCode7 = CodeInput('Code 7', optional: true);

  final extraDetails = StringInput('Additional Details', optional: true);

  final reference1 = CodeInput('Existing Reference', optional: true);
  final reference2 = CodeInput('Existing Reference', optional: true);

  // outputs
  final executionStepOuput = PromptOutput();
  final starterTemplateOutput = PromptOutput();
  final referenceFilledGeneratedTest = PromptOutput();
  final integrationTestOutput = PromptOutput();

  @override
  String get slug => 'integration';

  @override
  String get intent => 'Generate integration test';

  @override
  List<DashInput> get registerInputs => [
        testFlow,
        testCode1,
        testCode2,
        testCode3,
        testCode4,
        testCode5,
        testCode6,
        testCode7,
        extraDetails,
        reference1,
        reference2
      ];

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you generate integration test for your code base. Please share the following info: $testFlow\nWidget Codes: $testCode1 $testCode2 $testCode3 $testCode4 $testCode5 $testCode6 $testCode7 \nReferences: $reference1 $reference2 \n $extraDetails";

  @override
  List<Step> get steps => [
        PromptQueryStep(
            prompt:
                '''You are a Flutter Integrations Test writing assistant. Your task to generate integration test based on the details shared by the user below.
  
  Test Flow: $testFlow
  
  Contextual Code from User's Project:
  ```dart
  // contextual code 1
  $testCode1

  // contextual code 2
  $testCode2

  // contextual code 3
  $testCode3

  // contextual code 4
  $testCode4

  // contextual code 5
  $testCode5

  // contextual code 6
  $testCode6

  // contextual code 7
  $testCode7
  ````
  
  Additional Instruction from User:
  $extraDetails

  Existing Integration Test from User's project:
  ```dart
  // integration test reference 1
  $reference1

  // integration test referece 2
  $reference2
  ```

  You may reuse or refer the above tests to:
  1. Fill in code for parts for which contextual code might be missing (like app launch, reaching a certain page, etc).
  2. Output test that match user's test writing pattern.

  Note:
  1. Only generate test code based on the contextual code that is shared. Don't generate any key or text by assumption (that is if they are not present in contextual for use).
  2. In case if the key is not provided to find a widget look for other ways. For example, one approach can be use with widget type.
  3. Generate test that is easy to understand, workds and is reliable.
  4. Finally, make sure to share feedback on how the integration test can be further enhanced by the user.
  ''',
            promptOutput: integrationTestOutput),
        AppendToChatStep(value: '$integrationTestOutput')
      ];
}
