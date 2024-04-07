import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class DocCommand extends Command {
  DocCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userQuery = StringInput('Your query', optional: false);

  @override
  String get slug => '/doc';

  @override
  String get intent => 'Your Flutter doc expert';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you with core flutter queries. Let me know your question: $userQuery";

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
            '''You are an Flutter expert who answers user's queries related to the framework. \n\n Please find the user query <Query> and relavant references <References> picked from the Flutter docs to assist you: \n\n Query: $userQuery, \nReferences: $matchingDocuments. Please respond to the user's query!''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(
          value:
              '$promptOutput')
    ];
  }
}
