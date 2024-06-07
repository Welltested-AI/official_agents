import 'package:dash_agent/dash_agent.dart';
import 'package:flame/agent.dart';
import 'package:flame/data_source/github_issues_data_source_helper.dart';

import 'package:test/test.dart';

void main() {
  test('adds one to input values', () async {
    final openIssues = await generateGitIssuesLink();
    final closedIssues = await generateGitIssuesLink(closedIssues: true);
    await processAgent(FlameAgent(issuesLinks: []));
  });
}
