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
  List<DataSource> get registeredDataSources =>
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
}
