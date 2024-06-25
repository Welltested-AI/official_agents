import 'package:apyhub/commands/explore.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'commands/integrate.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsSource = DocsDataSource();
  @override
  Metadata get metadata => Metadata(
      name: 'Apyhub',
      avatarProfile: 'assets/logo.jpeg',
      tags: ['API', 'Catalog']);

  @override
  String get registerSystemPrompt =>
      '''Apyhub is a platform to Build, Test, Document & Collaborate on development of APIs.
      
      Your role is to help users find out different APIs already available and also help them integrate it within their codebase by generating them contextualized code.
      
      You have been provided with information about the latest APIs supported on the platform as references. Only and only answer from that.
      
      If you don't find a relevant API specific to the user's need from the references or the APIs is not able to exactly fulfill the functionality user intends to, let them know.
      
      Quote the links to the webpages of the API and strictly answer from the references only.''';

  @override
  List<DataSource> get registerDataSources => [docsSource];

  @override
  List<Command> get registerSupportedCommands => [
        // ExploreCommand(docsDataSource: docsSource),
        // IntegrateCommand(docsDataSource: docsSource)
      ];
}
