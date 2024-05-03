import 'package:chopper/commands/debug.dart';
import 'package:chopper/commands/generate.dart';
import 'package:chopper/commands/test.dart';
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
  List<DataSource> get registeredDataSources =>
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
}
