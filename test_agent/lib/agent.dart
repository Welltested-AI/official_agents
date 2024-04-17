import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';

import 'commands/unit.dart';
import 'commands/widget.dart';

/// Your agent configurations
class TestAgent extends AgentConfiguration {
  @override
  List<DataSource> get registeredDataSources => [];

  @override
  List<Command> get registerSupportedCommands =>
      [UnitCommand(), WidgetCommand()];
}
