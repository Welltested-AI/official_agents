import 'dart:convert';

import 'package:http/http.dart' as http;

/// Generates a list of links to GitHub issues for a given repository and label.
///
/// The [closedIssues] parameter determines whether to include closed issues in the list.
/// The default value is `false`.
Future<List<String>> generateGitIssuesLink({bool closedIssues = false}) async {
  String? issueApiUrl =
      'https://api.github.com/repos/flame-engine/flame/issues';

  /// The maximum number of issues to retrieve.
  final issueLimit = closedIssues ? 350 : 50;

  /// The list of issue URLs.
  final issueUrls = <String>[];

  if (closedIssues) {
    issueApiUrl = '$issueApiUrl&state=closed';
  }

  // Loop through the pages of results.
  while (issueApiUrl != null && issueLimit > issueUrls.length) {
    final response = await http.get(Uri.parse(issueApiUrl));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body).cast<Map>();

      for (final issue in responseBody) {
        issueUrls.add(issue['html_url'] as String);
      }

      if (response.headers.containsKey('link')) {
        String links = response.headers['link']!;

        /// If the `Link` header contains a `rel="next"` link, extract the URL.
        if (links.contains('rel="next"')) {
          RegExp regExp = RegExp(r'<(.+?)>');
          issueApiUrl = regExp.firstMatch(links)!.group(1);
        } else {
          issueApiUrl = null;
        }
      } else {
        issueApiUrl = null;
      }
    }
  }

  return issueUrls;
}
