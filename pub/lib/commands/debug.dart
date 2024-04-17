import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DebugCommand extends Command {
  DebugCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userIntention = StringInput('Query', optional: false);
  final errorDetails = StringInput('Error', optional: true);
  final codeInput = CodeInput('Relevant code', optional: true);

  @override
  String get slug => 'debug';

  @override
  String get intent => 'Debug the package implementation';

  @override
  String get textFieldLayout =>
      "Hi, I am here to help you debug your package implementation. Please share the following info: $userIntention $errorDetails $codeInput";

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

              Please find the user intention <Intention>, error detail <Error Faced>, and relavant code from project <Relevant Code>: 

              Intention: $userIntention

              Error Encointered: 
              $errorDetails

              Relevant Code: 
              ```
              $codeInput
              ```

              Finally, also find the relavant references <References> picked from the Flutter pub.dev to assist you.

              References: 
              $matchingDocuments.

              Note: 
              1. Be specific and concise to the user's query and minimise prose until unless explicitly stated in the <Intention> provided by the user
              2. Be truthful with your response and include code snippets or example whenever required.
              3. If the references don't address the question, state that "I couldn't fetch your answer from the doc sources, but I'll try to answer from my own knowledge"
           ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
