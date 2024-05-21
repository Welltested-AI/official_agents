import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:gemini/data_sources.dart';

/// [AskCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsSource].
class AskCommand extends Command {
  AskCommand(
      {required this.firebaseVertexAiDataSource,
      required this.geminiApiDataSource});

  final FirebaseVertexAiDataSource firebaseVertexAiDataSource;
  final GeminiApDataSource geminiApiDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Your query');
  final codeAttachment = CodeInput('Reference', optional: true);
  final codeAttachment2 = CodeInput('Reference', optional: true);

  @override
  String get slug => '/ask';

  @override
  String get intent => 'About Gemini API and Firebase VertexAI';

  @override
  String get textFieldLayout =>
      "Hi, Let me know your query. $userQuery $codeAttachment $codeAttachment2";

  @override
  List<DashInput> get registerInputs =>
      [userQuery, codeAttachment, codeAttachment2];

  @override
  List<Step> get steps {
    final geminiDocuments = MatchDocumentOuput();
    final vertexDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query:
              'Flutter/dart: $userQuery Code attachments:\n\n$codeAttachment $codeAttachment2',
          dataSources: [geminiApiDataSource],
          output: geminiDocuments),
      MatchDocumentStep(
          query:
              'Flutter/dart: $userQuery Code attachments:\n\n$codeAttachment $codeAttachment2',
          dataSources: [firebaseVertexAiDataSource],
          output: vertexDocuments),
      PromptQueryStep(
        prompt:
            '''You are a Gemini integration assist agent for Flutter/dart. Developers can integrate Gemini via 
            1. Connecting to their direct APIs via SDKs
            2. Via VertexAI on Firebase
            3. Via VertexAI on Google Cloud
            
            Here is the $userQuery, here is the $codeAttachment and some relevant documents for your reference from multiple documentation sources including gemini api docs and vertex ai docs: $geminiDocuments $vertexDocuments. 
            
            Assist the user with their query.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
