import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DebugCommand extends Command {
  DebugCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userIntention = StringInput('Your query', optional: false);
  final errorDetails = StringInput('Error Detail', optional: true);
  final codeInput = CodeInput('Relevant code', optional: true);

  @override
  String get slug => 'debug';

  @override
  String get intent => 'Debug the package implementation';

  @override
  String get textFieldLayout =>
      "Hi, please state your intention of using package, share any error details, and provide relevant code for debugging assistance: $userIntention $errorDetails $codeInput";

  @override
  List<DashInput> get registerInputs =>
      [userIntention, errorDetails, codeInput];

  @override
  List<Step> get steps {
    // Outputs
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: '$userIntention',
          dataSources: [docsSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are an Flutter expert who helps devs in implementation of flutter/dart packages based on their project need.
            
            Please find the user user intention <Intention>, error detail <Error Faced>, and relavant code from project <Relevant Code>: 
            
            Intention: $userIntention
            Error Faced: $errorDetails
            Relevant Code: $codeInput

            Finally, also find the relavant references <References> picked from the Flutter pub.dev for you to help in assisting.
            References: 
            $matchingDocuments.
            
            Now, respond to the user's query!
           **Note**: Please be specific and concise to the user's query and minimise prose''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
