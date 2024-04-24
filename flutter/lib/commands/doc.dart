import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DocCommand extends Command {
  DocCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userQuery = StringInput('Query', optional: false);

  @override
  String get slug => 'doc';

  @override
  String get intent => 'Ask across Flutter docs';

  @override
  String get textFieldLayout =>
      "Hi! Ask me anything from Flutter docs: $userQuery";

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
            '''You are an Flutter expert who answers user's queries related to the framework.
            
            Please find the user query <Query> and relavant references <References> picked from the Flutter docs to assist you: 
            
            Query: $userQuery
            
            References: 
            $matchingDocuments
            
            Note: 
            1. If the references don't address the question, state that "I couldn't fetch your answer from the doc sources, but I'll try to answer from my own knowledge".
            2. Be truthful, complete and detailed with your responses and include code snippets wherever required.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
