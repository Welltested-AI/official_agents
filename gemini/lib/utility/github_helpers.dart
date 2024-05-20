import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubHelpers {
  static Future<List<String>> getDartFileContents(
      String repositoryOwner, String repositoryName, String folderPath) async {
    final dartFileUrls = await getDartFileDownloadUrls(
        repositoryOwner, repositoryName, folderPath);
    return downloadDartFileContents(dartFileUrls);
  }

  static Future<List<Map<String, dynamic>>> getDartFileDownloadUrls(
      String repositoryOwner, String repositoryName, String folderPath) async {
    final url = Uri.parse(
        'https://api.github.com/repos/$repositoryOwner/$repositoryName/contents/$folderPath?ref=main');

    final response =
        await http.get(url, headers: {'Authorization': 'Bearer <pat>'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final dartFileUrls = <Map<String, dynamic>>[];
      for (var item in data) {
        if (item['type'] == 'file' && item['name'].endsWith('.dart')) {
          dartFileUrls.add({
            'url': item['download_url'],
            'path': '$folderPath/${item['name']}'
          });
          break;
        } else if (item['type'] == 'dir') {
          final nestedPath = '$folderPath/${item['name']}';
          dartFileUrls.addAll(await getDartFileDownloadUrls(
              repositoryOwner, repositoryName, nestedPath));
        }
      }
      return dartFileUrls;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<String>> downloadDartFileContents(
      List<Map<String, dynamic>> dartFileUrls) async {
    final dartFileContents = <String>[];
    for (final fileData in dartFileUrls) {
      final url = fileData['url'];
      final path = fileData['path'];
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final content = '// path: $path\n\n\n${response.body}';
        dartFileContents.add(content);
      } else {
        print('Error downloading file: $url');
      }
    }
    return dartFileContents;
  }
}
