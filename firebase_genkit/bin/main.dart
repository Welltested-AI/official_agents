import 'package:dash_agent/dash_agent.dart';
import 'package:firebase_genkit/agent.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final genkitDocUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://firebase.google.com/sitemap_0_of_1.xml',
      [RegExp(r'^https://firebase.google.com/docs/genkit.*')]);
  await processAgent(MyAgent(genkitDocUrls));
}

class SitemapHelper {
  static Future<List<String>> fetchAndFilterUrls(
      String sitemapUrl, List<RegExp> urlPatterns) async {
    final response = await http.get(Uri.parse(sitemapUrl));

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final urls = xmlDoc
          .findAllElements('loc')
          .map((element) => element.text)
          .where((url) => urlPatterns.any((pattern) => pattern.hasMatch(url)))
          .toList();
      return urls;
    } else {
      throw Exception('Failed to fetch sitemap: ${response.statusCode}');
    }
  }
}
