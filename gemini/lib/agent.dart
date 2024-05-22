import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:gemini/commands/firebase-vertex.dart';
import 'package:gemini/commands/gen-ai-sdk.dart';

import 'commands/ask.dart';
import 'data_sources.dart';

class MyAgent extends AgentConfiguration {
  MyAgent(List<String> firebaseVertexUrls, List<String> geminiAPIUrls,
      List<String> geminiDartSamples) {
    firebaseVertexAiDataSource = FirebaseVertexAiDataSource(firebaseVertexUrls);
    geminiApiDocsDataSource = GeminiApDataSource(geminiAPIUrls);
    geminiApiExamplesDataSource =
        GeminiApiExamplesDataSource(geminiDartSamples);
  }
  late FirebaseVertexAiDataSource firebaseVertexAiDataSource;
  late GeminiApDataSource geminiApiDocsDataSource;
  late GeminiApiExamplesDataSource geminiApiExamplesDataSource;

  @override
  List<DataSource> get registeredDataSources => [
        firebaseVertexAiDataSource,
        geminiApiDocsDataSource,
        geminiApiExamplesDataSource,
      ];

  @override
  List<Command> get registerSupportedCommands => [
        AskCommand(
            firebaseVertexAiDataSource: firebaseVertexAiDataSource,
            geminiApiDataSource: geminiApiDocsDataSource),
        FirebaseVertex(firebaseVertexAiDataSource),
        GenAISDK(geminiApiDocsDataSource, geminiApiExamplesDataSource)
      ];
}
