import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class AskCommand extends Command {
  AskCommand(
      {required this.docsSource,
      required this.exampleDataSource,
      required this.issuesDataSource});

  final DataSource docsSource;
  final DataSource exampleDataSource;
  final DataSource issuesDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Query', optional: false);
  final codeAttachment = CodeInput('Code');

  @override
  String get slug => 'ask';

  @override
  String get intent => 'Ask me anything';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you. Please let know your $userQuery and any optionally any relevant code: $codeAttachment";

  @override
  List<DashInput> get registerInputs => [userQuery, codeAttachment];

  @override
  List<Step> get steps {
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery$codeAttachment',
          dataSources: [docsSource, exampleDataSource, issuesDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are tasked with answering any query related to flutter's flame framework. Please find the below shared details:
            
            Query: $userQuery, 
            
            Code Attachment:
            $codeAttachment 
            
            References: 
            $matchingDocuments. 
            
            Note: 
             1. If the references don't address the question, state that "I couldn't fetch your answer from the doc sources, but I'll try to answer from my own knowledge".
             2. Be truthful, complete and detailed with your responses and include code snippets wherever required.
            Now, answer the user's query.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
