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
      name: 'Langchain 2.0',
      avatarProfile: 'assets/logo.png',
      tags: ['LLM Frameworks', 'Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Langchain Integration assistant inside user's IDE. LangChain is a framework for developing applications powered by large language models (LLMs). It provides open sourced building blocks and components and third party integration to building production ready LLM application.
      
      You will be provided with latest docs and examples relevant to user queries and you have to help user with any questions they have related to Langchain. Output code and code links wherever required and answer "I don't know" if the user query is not covered in the docs provided to you''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
