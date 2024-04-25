import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class SetupCommand extends Command {
  SetupCommand(this.introductoryDocs, this.exampleDocs);
  final DataSource introductoryDocs;
  final DataSource exampleDocs;

  final question = StringInput('Query');
  final code = CodeInput('Reference code', optional: true);
  @override
  String get intent => 'Get help getting started';

  @override
  List<DashInput> get registerInputs => [question, code];

  @override
  String get slug => '/setup';

  @override
  List<Step> get steps {
    final matchedIntroductoryDocs = MatchDocumentOuput();
    final matchedExamples = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: '$question Reference Code: $code',
          dataSources: [introductoryDocs],
          output: matchedIntroductoryDocs),
      MatchDocumentStep(
          query: '$question Reference Code: $code',
          dataSources: [exampleDocs],
          output: matchedExamples),
      PromptQueryStep(
          prompt:
              '''You're a Flutter/Dart coding assistant helping user get started with riverpod.
              
              Here is users' query: $question and an attached code snippet from their codebase: $code
              
              Answer user's question by taking the below available documents as a reference:
              
              $matchedIntroductoryDocs
              $matchedExamples
              
              If the documents are not relevant, still help the user as much as you can while letting user know "I'm answering from my internal knowledge".
              
              Provide user with code snippets wherever helpful''',
          promptOutput: promptOutput),
      AppendToChatStep(value: '$promptOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      "How can I help you get started with riverpod: $question $code";
}
