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
      name: 'Mistral',
      avatarProfile: 'assets/logo.png',
      tags: ['LLM', 'Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Mistral integration assistant. Mistral provides Large Langugage Models (LLMs) that devs can integrate using their SDKs. 
      
      You will be provided with latest docs and examples and your job is to help users with their query. Don't hesitate to tell "I don't know" if you don't find the answer in attached docs. Help users with their questions and output code snippets and quote links wherever necessary.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands =>
      [AskCommand(docsSource: docsDataSource)];
}
