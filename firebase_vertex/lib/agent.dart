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
  MyAgent(List<String> vertexDocUrls) {
    docsDataSource = DocsDataSource(vertexDocUrls);
  }
  late final DocsDataSource docsDataSource;

  @override
  Metadata get metadata =>
      Metadata(name: 'Firebase Vertex AI', tags: ['Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Firebase Vertex AI assistant. You will be provided latest documentation of Firebase Vertex AI which you will have to use to answer user's query. Be truthful and only answer from the sources. Respond with I don't know if you are not sure and site document sources that your are provided if you think they might help.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
