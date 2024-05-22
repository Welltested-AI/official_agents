import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:riverpod/commands/generate.dart';
import 'package:riverpod/commands/help.dart';
import 'package:riverpod/commands/setup.dart';
import 'package:riverpod/commands/test.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  MyAgent(List<String> openIssues, List<String> closedIssues) {
    githubIssues = GithubIssuesDataSource(openIssues, closedIssues);
  }
  final introductoryDocs = IntroductoryDocs();
  final exampleDocs = ExampleDocs();
  final providerDocs = ProviderDocs();
  final documentationDocs = DocsDataSource();
  late final GithubIssuesDataSource githubIssues;

  @override
  List<DataSource> get registeredDataSources => [introductoryDocs, exampleDocs];

  @override
  List<Command> get registerSupportedCommands => [
        SetupCommand(introductoryDocs, exampleDocs),
        HelpCommand(documentationDocs, githubIssues),
        GenerateCommand(exampleDocs, providerDocs),
        TestCommand()
      ];
}
