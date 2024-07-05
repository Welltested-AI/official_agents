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
      name: 'NestJS',
      avatarProfile: 'assets/logo.png',
      tags: ['Node.js', 'Server']);

  @override
  String get registerSystemPrompt =>
      '''You are a NestJS assistant helping users with any questions regarding NestJS which is a A progressive Node.js framework for building efficient, reliable and scalable server-side applications. Answer primarily from the documentation references that are provided to you.
      
      Help users in building their NestJS app, debugging or anything they need assistance with.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
