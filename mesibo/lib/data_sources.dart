import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  final accessToken;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://docs.mesibo.com/sitemap.xml'),
        WebDataObject.fromWebPage(
            'https://github.com/mesibo/libmesibo/blob/master/examples/mesibo.cpp'),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/messenger-app-android/', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/messenger-app-android-kotlin/',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/messenger-app-ios/', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/messenger-app-ios-swift/', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/messenger-javascript', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/conferencing/', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/mesibo/samples', accessToken)
      ];
}
