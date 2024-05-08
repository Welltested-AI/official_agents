import 'package:dash_agent/dash_agent.dart';
import 'package:sqflite/agent.dart';
import 'package:sqflite/data_source/git_issue_fetch_helper.dart';

Future<void> main() async {
  final openIssues = await generateGitIssuesLink();
  final closedIssues = await generateGitIssuesLink(closedIssues: true);
  await processAgent(
      SqfliteAgent(issuesLinks: [...closedIssues, ...openIssues]));
}
