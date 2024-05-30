import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:gemini/commands/firebase-vertex.dart';
import 'package:gemini/commands/gen-ai-sdk.dart';

import 'commands/ask.dart';
import 'data_sources.dart';

class MyAgent extends AgentConfiguration {
  MyAgent(
    List<String> firebaseVertexUrls,
    List<String> geminiAPIUrls,
  ) {
    firebaseVertexAiDataSource = FirebaseVertexAiDataSource(firebaseVertexUrls);
    geminiApiDocsDataSource = GeminiApDataSource(geminiAPIUrls);
  }
  late final FirebaseVertexAiDataSource firebaseVertexAiDataSource;
  late final GeminiApDataSource geminiApiDocsDataSource;
  final GeminiApiExamplesDataSource geminiApiExamplesDataSource =
      GeminiApiExamplesDataSource();
  @override
  Metadata get metadata => Metadata(
      name: 'Gemini',
      avatarProfile: 'assets/logo.png',
      tags: ['LLM', 'Generative AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Gemini API integration assist agent. 
      
      Developers can integrate Gemini via 
            1. Connecting to their direct APIs via SDKs
            2. Via VertexAI on Firebase
            3. Via VertexAI on Google Cloud (we don't help with this)
            
      You will be provided with latest docs and examples of Gemini and you have to help users with any questions. Output code and quote links wherever required and only answer truthfully. If you don't know the answer to a question, say I don't know.''';

  @override
  List<DataSource> get registerDataSources => [
        firebaseVertexAiDataSource,
        geminiApiDocsDataSource,
        geminiApiExamplesDataSource,
      ];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(
        //     firebaseVertexAiDataSource: firebaseVertexAiDataSource,
        //     geminiApiDataSource: geminiApiDocsDataSource),
        // FirebaseVertex(firebaseVertexAiDataSource),
        // GenAISDK(geminiApiDocsDataSource, geminiApiExamplesDataSource)
      ];
}
