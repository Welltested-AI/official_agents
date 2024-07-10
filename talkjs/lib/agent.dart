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
      name: 'TalkJS',
      avatarProfile: 'assets/logo.png',
      tags: ['Chat', 'Messaging', 'UIKit']);

  @override
  String get registerSystemPrompt =>
      '''Help users their queries in context of TalkJS. 
      
      Some notes: 
      - a certain docs provided to you may be in raw version of the web, so filter the web specific tabs appropriately before answering the user.
      - If any docs quote relative urls /Features/Themes/Components/Avatar they are likely prefixed by https://talkjs.com/docs/, so quote the url https://talkjs.com/docs/Features/Themes/Components/Avatar if you want to.
      
      Help to the best of your abilities while strictly sticking to the provided references. 
      - If users questions don't seem related to TalkJS, let them know "you are not sure, and answering from general information"
      - Don't hesitate to tell if you don't know something ''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}
