import 'package:ai_sdk/commands/generate.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:dash_agent/data/datasource.dart';

import 'commands/help.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  MyAgent(List<String> exampleUrls, List<String> providerUrls) {
    examplesDataSource = ExamplesDataSource(exampleUrls);
    providersDataSource = ProvidersDataSource(providerUrls);
  }
  final docsSource = DocsDataSource();
  late final ExamplesDataSource examplesDataSource;
  late final ProvidersDataSource providersDataSource;

  @override
  List<DataSource> get registeredDataSources =>
      [docsSource, examplesDataSource, providersDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        HelpCommand(docsSource: docsSource),
        GenerateCommand(
            docsSource: docsSource,
            examplesDataSource: examplesDataSource,
            providersDataSource: providersDataSource),
        // DebugCommand(docsSource: docsSource, issuesDataSource: issuesDataSource)
      ];
}
