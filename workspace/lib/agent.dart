import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:workspace/command/query.dart';

import 'command/refactor.dart';

/// Your agent configurations
class WorkspaceAgent extends AgentConfiguration {

  @override
  List<DataSource> get registeredDataSources => [];

  @override
  List<Command> get registerSupportedCommands =>
      [RefactorCommand(), QueryCommand()];
}
