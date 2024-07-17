import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  final accessToken;
  DocsDataSource(this.docUrls);
  final List<String> docUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        ...docUrls.map((e) => WebDataObject.fromWebPage(e)),
        WebDataObject.fromGithub(
            'https://github.com/firebase/genkit', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/TheFireCo/genkit-plugins', accessToken)
      ];
}
