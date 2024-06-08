import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:test/commands/integration.dart';
import 'package:test/data_sources.dart';

import 'commands/unit.dart';
import 'commands/widget.dart';

/// Your agent configurations
class TestAgent extends AgentConfiguration {
  final generalSource = GeneralDataSource();
  @override
  List<DataSource> get registeredDataSources => [generalSource];

  @override
  List<Command> get registerSupportedCommands => [
        UnitCommand(generalSource),
        WidgetCommand(generalSource),
        IntegrationCommand(),
      ];
}
