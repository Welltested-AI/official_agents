import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class SearchCommand extends Command {
  SearchCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userQuery = StringInput('Requirement', optional: false);

  @override
  String get slug => 'search';

  @override
  String get intent => 'Search pub packages';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to assist you find the right packages. Let me know your requirement: $userQuery";

  @override
  List<DashInput> get registerInputs => [userQuery];

  @override
  List<Step> get steps {
    // Outputs
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: '$userQuery',
          dataSources: [docsSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are an Flutter expert who helps user's find right flutter/dart packages based on their project need.

            Please find the user query <Query> and relavant references <References> picked from the Flutter pub.dev: 

            Query: $userQuery

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
