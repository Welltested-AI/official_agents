import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> generatePubPackageLinks() async {
  // get all the packages available
  final packagesListUrl = 'https://pub.dev/api/package-names';
  final response = await http.get(Uri.parse(packagesListUrl));

  if (response.statusCode != 200) {
    throw 'Failed to get the package list. Response received: ${response.statusCode} ${response.body}';
  }

  final List<String> packageList =
      jsonDecode(response.body)['packages'].cast<String>();

  final baseUrl = 'https://pub.dev';
  return [for (final package in packageList) '$baseUrl/packages/$package'];
}
