import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:serverpod/data_sources.dart';

/// [AskCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class AskCommand extends Command {
  AskCommand({required this.docsDataSource});

  final DocsDataSource docsDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Query', optional: false);
  final codeAttachment = CodeInput('Code Reference', optional: true);

  @override
  String get slug => '/ask';

  @override
  String get intent => 'Ask anything about Serverpod';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you with Serverpod. $userQuery $codeAttachment";

  @override
  List<DashInput> get registerInputs => [userQuery, codeAttachment];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery$codeAttachment',
          dataSources: [docsDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are a Serverpod Integration agent. Serverpod is an open-source, scalable app server, written in Dart for the Flutter community. Your job is to help users with their queries about serverpod from the latest datasources provided to you or your internal knowledge.
            
            Here is the $userQuery, here is an optional $codeAttachment from them and some relevant documents for the latest docs for your reference: $matchingDocuments. 
            
            Help user with their query.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
