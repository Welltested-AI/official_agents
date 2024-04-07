import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/system_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

class DocsDataSource extends DataSource {
  final flutterDocSiteMap = 'https://docs.flutter.dev/sitemap.xml';
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [WebDataObject.fromSiteMap(flutterDocSiteMap)];
}
