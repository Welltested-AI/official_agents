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
      name: 'Pandas AI',
      avatarProfile: 'assets/logo.jpeg',
      tags: ['LLM Framework', 'Data Analysis']);

  @override
  String get registerSystemPrompt =>
      '''You are a Pandas AI assistant inside user's IDE. PandasAI is a Python library that makes it easy to ask questions to your data in natural language.
      
      You will be provided with latest docs and examples relevant to user questions and you have to help them achieve their desired results. Output code and quote links and say I don't know when the docs don't cover the user's query.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
