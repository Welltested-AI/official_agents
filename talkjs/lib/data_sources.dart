import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects =>
      [FileDataObject.fromDirectory(Directory('./assets/docs'))];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromWebPage('https://talkjs.com/resources/tag/tutorials',
            deepCrawl: true),
        WebDataObject.fromWebPage('https://pub.dev/packages/talkjs_flutter'),
        WebDataObject.fromWebPage('https://www.npmjs.com/package/talkjs'),
        WebDataObject.fromGithub(
          'https://github.com/talkjs/talkjs-examples',
        )
      ];
}
