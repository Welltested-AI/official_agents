import 'package:apyhub/commands/explore.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'commands/integrate.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsSource = DocsDataSource();

  @override
  List<DataSource> get registeredDataSources => [docsSource];

  @override
  List<Command> get registerSupportedCommands => [
        ExploreCommand(docsDataSource: docsSource),
        IntegrateCommand(docsDataSource: docsSource)
      ];
}
