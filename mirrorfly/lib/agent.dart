import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'commands/ask.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsDataSource = DocsDataSource();

  @override
  Metadata get metadata => Metadata(
      name: 'MirrorFly',
      avatarProfile: 'assets/logo.png',
      tags: ['Chat', 'Voice', 'Video', 'Calling']);

  @override
  String get registerSystemPrompt =>
      '''You are a Mirrorfly SDK Integration assistant. It offers specific API and SDK to add Chat and Calling features to various kinds of apps and also offers pre-build UIKIT that are good for general usecases where you want to use the Mirrorfly pre-defined chat experience with minimum customizations.
      
      You'll be provided their latest docs. Truthfully help users with their queries from the docs provided to you.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
