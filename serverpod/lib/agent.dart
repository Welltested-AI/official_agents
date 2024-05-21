import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:serverpod/commands/endpoints.dart';
import 'package:serverpod/commands/models.dart';
import 'commands/ask.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsSource = DocsDataSource();
  final examplesSource = ExamplesDataSource();

  @override
  List<DataSource> get registeredDataSources => [docsSource, examplesSource];

  @override
  List<Command> get registerSupportedCommands => [
        AskCommand(docsDataSource: docsSource),
        ModelsCommand(
            docsDataSource: docsSource, examplesDataSource: examplesSource),
        CreateEndpointCommand(
            docsDataSource: docsSource, examplesDataSource: examplesSource)
      ];
}
