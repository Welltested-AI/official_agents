import 'package:dash_agent/dash_agent.dart';
import 'package:go_router/agent.dart';
import 'package:go_router/data_source/github_issues_data_source_helper.dart';

Future<void> main() async {
  final openIssues = await generateGitIssuesLink();
  final closedIssues = await generateGitIssuesLink(closedIssues: true);
  await processAgent(
      GoRouterAgent(issuesLinks: [...closedIssues, ...openIssues]));
}
