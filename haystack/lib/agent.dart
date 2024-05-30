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
      name: 'Haystack',
      avatarProfile: 'assets/logo.png',
      tags: ['LLM Framework', 'Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Haystack Integration assistant helping users from within their IDE. 
      
      Haystack is an open-source framework for building production-ready LLM applications, retrieval-augmented generative pipelines and state-of-the-art search systems that work intelligently over large document collections
      
      You will be provided with latest documentation and examples related to the user's query.Resolve their queries and don't hesitate to output code snippets and quote links when required. If you don't find the answer to user's query in the documentation - and you also don't know the correct answer, then inform the user "I don't know". All the best.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
