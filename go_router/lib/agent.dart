import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'commands/ask.dart';
import 'data_source/data_sources.dart';

class GoRouterAgent extends AgentConfiguration {
  final List<String> issuesLinks;
  final IssuesDataSource issueSource;
  final docsSource = DocsDataSource();
  final exampleSource = ExampleDataSource();

  GoRouterAgent({required this.issuesLinks})
      : issueSource = IssuesDataSource(issuesLinks);

  @override
  List<DataSource> get registeredDataSources =>
      [docsSource, exampleSource, issueSource];

  @override
  List<Command> get registerSupportedCommands =>
      [AskCommand(docsSource: docsSource)];
}
