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
      name: 'CometChat',
      avatarProfile: 'assets/logo.png',
      tags: ['Chat', 'Messaging', 'Video Calling']);

  @override
  String get registerSystemPrompt =>
      '''You are a assistant helping users integrate CometChat chat, voice and video calling SDKs and UIKITS. The latest version is v4 for your reference. Answer users's questions truthfully based on the documentation attached.
      
      If something is not clear from the documentation, refrain from answering from your memory and say you don't know for sure and quote helpful links (only that are in the references provided to you) where use may visit to get more information.
      
      All the best.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
