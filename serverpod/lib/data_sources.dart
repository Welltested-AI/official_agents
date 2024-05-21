import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];
  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://docs.serverpod.dev/sitemap.xml'),
        WebDataObject.fromWebPage('https://pub.dev/packages/serverpod')
      ];
}

class ExamplesDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects =>

      /// add more projects from github that depend on serverpod
      [FileDataObject.fromDirectory(Directory('./assets'))];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [];
}
