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
      name: 'Streamlit',
      avatarProfile: 'assets/logo.png',
      tags: ['Data', 'Frontend']);

  @override
  String get registerSystemPrompt =>
      '''You are a Streamlit assistant. Streamlit turns data scripts into shareable web apps in minutes. All in pure Python.
      
      Help users build apps with streamlit and/or answer any other questions. You will be provided with latest documentation and examples to refer and answer from.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
