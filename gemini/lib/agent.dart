import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'data_sources.dart';

class MyAgent extends AgentConfiguration {
  MyAgent(
    List<String> geminiAPIUrls,
  ) {
    geminiApiDocsDataSource = GeminiApDataSource(geminiAPIUrls);
  }
  late final GeminiApDataSource geminiApiDocsDataSource;
  final GeminiApiExamplesDataSource geminiApiExamplesDataSource =
      GeminiApiExamplesDataSource();
  @override
  Metadata get metadata => Metadata(
      name: 'Gemini',
      avatarProfile: 'assets/logo.png',
      tags: ['Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Gemini API or SDK integration assist agent. 

      Gemini is a series of LLMs offered by google to add generative AI to your apps. You will be provided with latest docs and examples of Gemini and you have to help users with any questions. Output code and quote links wherever required and only answer truthfully. If you don't know the answer to a question, let user know.''';

  @override
  List<DataSource> get registerDataSources => [
        geminiApiDocsDataSource,
        geminiApiExamplesDataSource,
      ];

  @override
  List<Command> get registerSupportedCommands => [];
}
