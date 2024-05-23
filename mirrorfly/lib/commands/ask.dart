import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

/// [AskCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsSource].
class AskCommand extends Command {
  AskCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Your query');
  final codeAttachment = CodeInput('Primary method', optional: true);

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
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery$codeAttachment',
          dataSources: [docsSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are an agent to help developer integrate MirrorFly chat SDK in their codebase. Here is the user query: $userQuery, here is the code attachment: $codeAttachment and some relevant mirrorfly documents for your reference: $matchingDocuments. 
            
            Answer the user's query.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
