import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/filters/filter.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects =>
      [FileDataObject.fromFile(File('your_file_path'))];

  @override
  List<ProjectDataObject> get projectObjects =>
      [ProjectDataObject.fromText('Data in form of raw text')];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://haystack.deepset.ai/sitemap.xml'),
        WebDataObject.fromSiteMap(
            'https://docs.haystack.deepset.ai/sitemap.xml'),
        WebDataObject.fromGithub(
            'https://github.com/deepset-ai/haystack-cookbook', accessToken,
            codeFilter: CodeFilter(pathRegex: r'^notebooks\/.*'))
      ];
}
