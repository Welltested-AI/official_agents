import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  DocsDataSource(this.firebaseVertexDocUrls);
  final List<String> firebaseVertexDocUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        ...firebaseVertexDocUrls
            .map((e) => WebDataObject.fromWebPage('$e?platform=flutter'))
            .toList(),
        ...firebaseVertexDocUrls
            .map((e) => WebDataObject.fromWebPage('$e?platform=web'))
            .toList(),
        ...firebaseVertexDocUrls
            .map((e) => WebDataObject.fromWebPage('$e?platform=android'))
            .toList(),
        ...firebaseVertexDocUrls
            .map((e) => WebDataObject.fromWebPage('$e?platform=ios'))
            .toList(),
      ];
}
