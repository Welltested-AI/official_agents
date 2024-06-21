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
  MyAgent(List<String> urls) {
    docsDataSource = DocsDataSource(urls);
  }
  late final DocsDataSource docsDataSource;

  @override
  Metadata get metadata =>
      Metadata(name: 'Agora', avatarProfile: 'assets/logo.png', tags: []);

  @override
  String get registerSystemPrompt =>
      '''You're an Agora SDK Integration assistant within the user's IDE. You'll be provided with latest documentation, examples or Github issues based on the users' query and your role is to:

      1. Truthfully answer user's query by referring to the latest documentation.
      2. Provided code samples and also quote links to orignal documentation if it makes sense.
      3. If the provided references doesn't satisfy answering for the user's query, let them know that you are not entire sure and quote any helpful links from the docs where they might find more information..''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
