import 'dart:io';
import 'package:xml/xml.dart' as xml;

List<String> sitemapUrlFetcher(String filePath) {
  // Read the contents of the file
  File file = File(filePath);
  if (!file.existsSync()) {
    throw 'File not found: $filePath';
  }

  String contents = file.readAsStringSync();

  // Parse the XML
  var document = xml.XmlDocument.parse(contents);

  // Find all URL elements
  var urlElements = document.findAllElements('url');

  // Extract
  List<String> urls = [];
  for (var urlElement in urlElements) {
    var locElement = urlElement.findElements('loc').first;
    var url = locElement.firstChild?.value;
    if (url != null) {
      urls.add(url);
    }
  }

  return urls;
}
