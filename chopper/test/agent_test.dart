import 'package:chopper/agent.dart';
import 'package:chopper/data_source/github_issues_data_source_helper.dart';
import 'package:dash_agent/dash_agent.dart';

import 'package:test/test.dart';

void main() {
  test('test agent config', () async {
    final openIssuesLinks = await generateGitIssuesLink();
    final closedIssuesLinks = await generateGitIssuesLink(closedIssues: true);
    await processAgent(
        ChopperAgent(issuesLinks: [...closedIssuesLinks, ...openIssuesLinks]));
  });
}
