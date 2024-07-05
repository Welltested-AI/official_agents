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
        WebDataObject.fromSiteMap('https://jestjs.io/sitemap.xml'),
        // WebDataObject.fromWebPage(
        //     'https://docs.nestjs.com/fundamentals/testing'),
        // WebDataObject.fromWebPage('https://docs.nestjs.com/recipes/automock'),
        // WebDataObject.fromWebPage(
        //     'https://dev.to/niemet0502/writing-unit-tests-for-your-nestjs-rest-api-3cgg')
      ];
}
