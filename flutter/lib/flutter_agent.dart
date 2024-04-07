import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';

import 'doc_command.dart';
import 'data_sources.dart';

/// Your agent configurations
class FlutterAgent extends AgentConfiguration {
  final docsSource = DocsDataSource();

  @override
  List<DataSource> get registeredDataSources => [docsSource];

  @override
  List<Command> get registerSupportedCommands =>
      [DocCommand(docsSource: docsSource)];
}
