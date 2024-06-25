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
  Metadata get metadata =>
      Metadata(name: 'Gitpod', avatarProfile: 'assets/logo.png', tags: []);

  @override
  String get registerSystemPrompt =>
      '''You are a Gitpod YML configuration generator assistant. You'll be provided with latest samples, docs and other references and you have to help users generate their configs or answer any questions strictly from the references provided to you.
      
      Be helpful and quote links if you are not able to answer with conviction.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
