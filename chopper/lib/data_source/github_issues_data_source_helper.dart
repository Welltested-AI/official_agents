import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> generateGitIssuesLink({bool closedIssues = false}) async {
  var issueApiUrl = 'https://api.github.com/repos/lejard-h/chopper/issues';

  if (closedIssues) {
    issueApiUrl = '$issueApiUrl?state=closed';
  }

  final response = await http.get(Uri.parse(issueApiUrl));

  if (response.statusCode != 200) {
    throw 'Failed to get the github issues. Response received: ${response.statusCode} ${response.body}';
  }

  final issueUrls = <String>[];
  final responseBody = jsonDecode(response.body).cast<Map>();

  for (final issue in responseBody) {
    issueUrls.add(issue['html_url'] as String);
  }

  return issueUrls;
}
