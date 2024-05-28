import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:firebase_genkit/data_sources.dart';

/// [AskCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class AskCommand extends Command {
  AskCommand({required this.docsDataSource});

  final ExamplesDataSource docsDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Query');
  final codeAttachment = CodeInput('Code Reference', optional: true);

  @override
  String get slug => '/ask';

  @override
  String get intent => 'Ask me anything';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you. $userQuery $codeAttachment";

  @override
  List<DashInput> get registerInputs => [userQuery, codeAttachment];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();

    return [
      MatchDocumentStep(
          query: '$userQuery$codeAttachment',
          dataSources: [docsDataSource],
          output: matchingDocuments),
      AppendToChatStep(value: '$matchingDocuments')
    ];
  }
}
