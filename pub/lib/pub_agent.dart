import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:pub/commands/debug_command.dart';
import 'package:pub/commands/setup_command.dart';

import 'commands/search_command.dart';
import 'data_source/data_sources.dart';

/// Your agent configurations
class PubAgent extends AgentConfiguration {
  final List<String> pubLinks;
  final PubDataSource docsSource;
  PubAgent({required this.pubLinks}) : docsSource = PubDataSource(pubLinks);

  @override
  List<DataSource> get registeredDataSources {
    return [docsSource];
  }

  @override
  List<Command> get registerSupportedCommands => [
        SearchCommand(docsSource: docsSource),
        DebugCommand(docsSource: docsSource),
        SetupCommand(docsSource: docsSource)
      ];
}
