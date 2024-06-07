import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:flame/data_source/data_sources.dart';
import 'commands/ask.dart';
import 'commands/debug.dart';
import 'commands/generate.dart';
import 'commands/test.dart';

class FlameAgent extends AgentConfiguration {
  final List<String> issuesLinks;
  final IssuesDataSource issueSource;
  final docsSource = DocsDataSource();
  final exampleSource = ExampleDataSource();
  final testExampleSource = TestExampleDataSource();

  FlameAgent({required this.issuesLinks})
      : issueSource = IssuesDataSource(issuesLinks);

  @override
  List<DataSource> get registerDataSources =>
      [docsSource, exampleSource, testExampleSource, issueSource];

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
          name: 'Flame',
          avatarProfile: 'assets/logo/flame_logo.png',
          tags: [
            'flutter',
            'dart',
            'flutter favorite',
            'game engine',
            'flutter package'
          ]);

  @override
  String get registerSystemPrompt =>
      '''You are a Flame Integration assistant inside user's IDE. Flame is a 2D game engine built on top of Flutter. It provides the core building blocks for creating games, like a game loop, collision detection, and sprite animation. This allows you to focus on the game logic itself without needing to write low-level graphics code.
      
      You will be provided with latest docs and examples relevant to user queries and you have to help user with any questions they have related to Flame. Output code and code links wherever required and answer "I don't know" if the user query is not covered in the docs provided to you''';
}
