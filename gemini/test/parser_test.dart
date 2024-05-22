import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class SitemapParser {
  final String sitemapUrl;
  final RegExp urlPattern;

  SitemapParser({
    required this.sitemapUrl,
    required this.urlPattern,
  });

  Future<List<String>> fetchAndFilterUrls() async {
    final response = await http.get(Uri.parse(sitemapUrl));

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final urls = xmlDoc
          .findAllElements('loc')
          .map((element) => element.text)
          .where((url) => urlPattern.hasMatch(url))
          .toList();
      return urls;
    } else {
      throw Exception('Failed to fetch sitemap: ${response.statusCode}');
    }
  }
}

void main() async {
  final sitemapUrl = 'https://firebase.google.com/sitemap_0_of_1.xml';
  final urlPattern = RegExp(r'^https://firebase.google.com/docs/vertex-ai.*');

  final parser = SitemapParser(sitemapUrl: sitemapUrl, urlPattern: urlPattern);
  final matchingUrls = await parser.fetchAndFilterUrls();

  print('Matching URLs:');
  print(matchingUrls);
}
