import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

class PubDataSource extends DataSource {
  final List<String> pubLinks;
  PubDataSource(this.pubLinks);
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        for (final packageUrl in pubLinks) WebDataObject.fromWebPage(packageUrl)
      ];
}
