import 'package:chopper/commands/debug.dart';
import 'package:chopper/commands/generate.dart';
import 'package:chopper/commands/test.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'data_source/data_sources.dart';

class ChopperAgent extends AgentConfiguration {
  final List<String> issuesLinks;
  final IssuesDataSource issueSource;
  final docsSource = DocsDataSource();
  final exampleSource = ExampleDataSource();

  ChopperAgent({required this.issuesLinks})
      : issueSource = IssuesDataSource(issuesLinks);

  @override
  List<DataSource> get registerDataSources =>
      [docsSource, exampleSource, issueSource];

  @override
  List<Command> get registerSupportedCommands => [
        GenerateCommand(
            exampleDataSource: exampleSource, docDataSource: docsSource),
        DebugCommand(
            exampleDataSource: exampleSource,
            docDataSource: docsSource,
            issueDataSource: issueSource),
        TestCommand()
      ];

  @override
  Metadata get metadata => Metadata(
      name: 'Chopper',
      tags: ['flutter', 'dart', 'flutter favorite', 'flutter package']);

  @override
  String get registerSystemPrompt =>
      '''You are a Chopper Integration assistant inside user's IDE. Chopper is an http client generator for Dart and Flutter using source_gen and inspired by Retrofit.
      
      You will be provided with latest docs and examples relevant to user queries and you have to help user with any questions they have related to Chopper. Output code and code links wherever required and answer "I don't know" if the user query is not covered in the docs provided to you''';
}
