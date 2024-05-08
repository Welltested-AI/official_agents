import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:sqflite/commands/debug.dart';
import 'package:sqflite/commands/generate.dart';
import 'package:sqflite/commands/test.dart';
import 'commands/ask.dart';
import 'data_source/data_sources.dart';

class SqfliteAgent extends AgentConfiguration {
  final List<String> issuesLinks;
  final IssuesDataSource issueSource;
  final docsSource = DocsDataSource();
  final exampleSource = ExampleDataSource();
  final testSource = TestExampleDataSource();

  SqfliteAgent({required this.issuesLinks})
      : issueSource = IssuesDataSource(issuesLinks);

  @override
  List<DataSource> get registeredDataSources =>
      [docsSource, exampleSource, issueSource, testSource];

  @override
  List<Command> get registerSupportedCommands => [
        AskCommand(
            docsSource: docsSource,
            exampleDataSource: exampleSource,
            issuesDataSource: issueSource),
        DebugCommand(
            exampleDataSource: exampleSource,
            docDataSource: docsSource,
            issueDataSource: issueSource),
        GenerateCommand(
            exampleDataSource: exampleSource, docDataSource: docsSource),
        TestCommand(testSource)
      ];
}
