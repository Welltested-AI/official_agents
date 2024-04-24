import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:defaults/commands/document.dart';
import 'package:defaults/commands/refactor.dart';


/// Your agent configurations
class DefaultAgent extends AgentConfiguration {
  @override
  List<DataSource> get registeredDataSources => [];

  @override
  List<Command> get registerSupportedCommands =>
      [DocumentCommand(), RefactorCommand()];
}
