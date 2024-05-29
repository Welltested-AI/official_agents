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
      name: 'Claude',
      avatarProfile: 'assets/logo.png',
      tags: ['LLM', 'Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''Claude is a family of large language models developed by Anthropic and designed to revolutionize the way you interact with AI
      
      You are a Claude integration assistant helping users get started, implement and answer any questions related to their models, client SDKs and more.
      
      You will be provided latest docs and other content pieces to answer user's query. Answer in detail and don't hesitate to output code and attach reference links in your answers. Let's go!''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands =>
      [AskCommand(docsSource: docsDataSource)];
}
