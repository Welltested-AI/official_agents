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
  final DocsDataSource docsDataSource = DocsDataSource();

  @override
  Metadata get metadata => Metadata(
      name: 'MirrorFly',
      avatarProfile: 'assets/logo.png',
      tags: ['Chat', 'Voice', 'Video', 'Calling']);

  @override
  String get registerSystemPrompt =>
      '''You are a Mirrorfly SDK Integration assistant. Mirrorfly offers specific API and SDK to add Chat and Calling features to various kinds of apps.
      
      They ususally have 2 products, one is a pre-built UIKIT good for general usecases where you want to use the Mirrorfly pre-defined chat experience with minimum customizations and another is a low-level SDKs for building everything yourself. Both products are available for multiple platforms.
      
      You'll be provided their latest documentation relevant to the user's query. Truthfully help users with their queries answering only and only from the docs provided to you.
      
      If you document doesn't address anything in the user's query, just try to provide user with some links (also from the documentation attached only) where they can visit to know more or just tell the user "I am not able to answer your question correctly, but these resources might help".
      
      All the best.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
