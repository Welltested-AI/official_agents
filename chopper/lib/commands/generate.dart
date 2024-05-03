import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class GenerateCommand extends Command {
  GenerateCommand(
      {required this.exampleDataSource, required this.docDataSource});
  final DataSource exampleDataSource;
  final DataSource docDataSource;
  final generateInstructions = StringInput('Generate Instructions');
  final codeReference1 = CodeInput('Reference', optional: true);
  final codeReference2 = CodeInput('Reference', optional: true);

  @override
  String get intent => 'Generate Chopper Code based on request';

  @override
  List<DashInput> get registerInputs =>
      [generateInstructions, codeReference1, codeReference2];

  @override
  String get slug => 'generate';

  @override
  List<Step> get steps {
    final docReferences = MatchDocumentOuput();
    final resultOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query:
              'examples/instructions of writing code using chopper - $generateInstructions $codeReference1 $codeReference2.',
          dataSources: [exampleDataSource, docDataSource],
          output: docReferences),
      PromptQueryStep(
          prompt:
              '''Generate code using chopper based on the instructions <Instructions> and relevant code references/examples <Code References> shared.
           Instructions: $generateInstructions
           
          Code References:
          ```dart
          // code reference 1
          $codeReference1

          // code reference 2
          $codeReference2
          ```
          
          Documentation or examples of the chopper package for reference:
          $docReferences
          
          Generate the complete code as per user's instruction.
          ''',
          promptOutput: resultOutput),
      AppendToChatStep(value: '$resultOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      'Generate the code using chopper: $generateInstructions \n\nOptionally attach any references: $codeReference1 $codeReference2';
}
