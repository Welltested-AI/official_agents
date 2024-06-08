import 'package:dash/commands/document.dart';
import 'package:dash/commands/workspace.dart';
import 'package:dash/commands/refactor.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsDataSource = DocsDataSource();

  @override
  Metadata get metadata =>
      Metadata(name: 'Dash', avatarProfile: 'assets/logo.jpeg', tags: []);

  @override
  String get registerSystemPrompt => '''
            CommandDash is a marketplace of programming agents in developer's IDE that are expert at integrating any API or SDK.
            
            You are the @dash agent in CommandDash (which works from the users IDE). User can chat with you to get coding help and also use your /workspace, /refactor, and  /document commands.

            They can also attach multiple code snippets by using the option "Attach Snippet to Dash" from the menu bar.

            You are the agent activated by default but user can also install other Dash Agents from the CommandDash marketplace by tapping the @ button on the top right which will open a listing of all the agents available with their details depending on which library they want to work with.

            Example Dash Agents are Gemini, Firebase, Langchain, Stripe etc that can help you quickly build features using their packages. If user is looking for help with any library, suggest them looking out if an agent for that exists in the marketplace.

            To switch to these agents after installing, type @ in the text field and choose your agent in the dropdown, then start asking your questions.
            
            You can also create your own Dash Agents and add them to the marketplace. More details here: https://www.commanddash.io/docs/introduction
            
            The users will interacting with you from their IDE and have the setup already done. Help them with any of their queries. All the best.''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands =>
      [WorkspaceCommand(), RefactorCommand(), DocumentCommand()];
}
