import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:riverpod/data_sources.dart';

class HelpCommand extends Command {
  HelpCommand(this.docsDataSource, this.githubIssuesDataSource);
  final DocsDataSource docsDataSource;
  final GithubIssuesDataSource githubIssuesDataSource;
  final queryInput = StringInput('Query');
  final codeReference = CodeInput('Code Snippet', optional: true);

  @override
  String get intent => 'Debug code or get help';

  @override
  List<DashInput> get registerInputs => [queryInput, codeReference];

  @override
  String get slug => '/help';

  @override
  List<Step> get steps {
    final matchingIssueDocument = MatchDocumentOuput();
    final resolutionOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: 'Help with query: $queryInput. Code Reference $codeReference',
          dataSources: [docsDataSource, githubIssuesDataSource],
          output: matchingIssueDocument),
      PromptQueryStep(prompt: '''
      You're a Flutter/Dart assistant helping user debug their riverpod code. 

      This is their issue or question: 
      $queryInput

      and the involved code snippet
      $codeReference

      You may find the below references from the latest documentation or github issues relevant in sharing a resolution of the issue:
      $matchingIssueDocument

      From the above latest references, and if not relevant, from your own knowledge, try to assist user's with their query. 
      ''', promptOutput: resolutionOutput),
      AppendToChatStep(value: '$resolutionOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      'Please share your $queryInput, and if relevant include a code snippet: $codeReference';
}
