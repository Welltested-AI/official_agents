import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:go_router/commands/debug.dart';
import 'package:go_router/commands/generate.dart';
import 'package:go_router/commands/test.dart';
import 'commands/ask.dart';
import 'data_source/data_sources.dart';

class GoRouterAgent extends AgentConfiguration {
  final List<String> issuesLinks;
  final IssuesDataSource issueSource;
  final docsSource = DocsDataSource();
  final exampleSource = ExampleDataSource();
  final testExampleSource = TestExampleDataSource();

  GoRouterAgent({required this.issuesLinks})
      : issueSource = IssuesDataSource(issuesLinks);

  @override
  List<DataSource> get registerDataSources =>
      [docsSource, exampleSource, issueSource, testExampleSource];

  @override
  List<Command> get registerSupportedCommands => [
        AskCommand(
            docsSource: docsSource,
            exampleDataSource: exampleSource,
            issuesDataSource: issueSource),
        GenerateCommand(
            exampleDataSource: exampleSource, docDataSource: docsSource),
        DebugCommand(
            exampleDataSource: exampleSource,
            docDataSource: docsSource,
            issueDataSource: issueSource),
        TestCommand(testExampleSource)
      ];

  @override
  Metadata get metadata => Metadata(
      name: 'GoRouter',
      tags: ['flutter', 'dart', 'flutter package', 'flutter favorite']);

  @override
  String get registerSystemPrompt =>
      '''You are a GoRouter Integration assistant inside user's IDE. GoRouter is a declarative routing package for Flutter that uses the Router API to provide a convenient, url-based API for navigating between different screens.
      
      You will be provided with latest docs and examples relevant to user queries and you have to help user with any questions they have related to GoRouter. Output code and code links wherever required and answer "I don't know" if the user query is not covered in the docs provided to you''';
}
