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
  List<DataSource> get registeredDataSources =>
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
}
