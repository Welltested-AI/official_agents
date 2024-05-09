import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DebugCommand extends Command {
  DebugCommand(
      {required this.exampleDataSource,
      required this.docDataSource,
      required this.issueDataSource});
  final DataSource exampleDataSource;
  final DataSource docDataSource;
  final DataSource issueDataSource;
  final issueDescription = StringInput('Issue Description');
  final codeReference1 = CodeInput('Reference', optional: true);
  final codeReference2 = CodeInput('Reference', optional: true);

  @override
  String get intent => 'Debug flame code';

  @override
  List<DashInput> get registerInputs =>
      [issueDescription, codeReference1, codeReference2];

  @override
  String get slug => 'debug';

  @override
  List<Step> get steps {
    final docReferences = MatchDocumentOuput();
    final issueReferences = MatchDocumentOuput();
    final resultOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: '$issueDescription',
          dataSources: [exampleDataSource, docDataSource],
          output: docReferences),
      MatchDocumentStep(
          query: '$issueDescription',
          dataSources: [issueDataSource],
          output: issueReferences),
      PromptQueryStep(
          prompt:
              '''Assist in debugging the code written using Flutter's flame package based on the information shared.
            Issue Description: $issueDescription
           
          Code References:
          ```dart
          // code reference 1
          $codeReference1

          // code reference 2
          $codeReference2
          ```
          
          Official Chopper Documentation References:
          $docReferences

          GitHub Issue Messages:
          $issueReferences
          ''',
          promptOutput: resultOutput),
      AppendToChatStep(value: '$resultOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      'Share the following details to understand your issue better: $issueDescription \n\nOptionally attach any references: $codeReference1 $codeReference2';
}
