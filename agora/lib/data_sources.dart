import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  DocsDataSource(this.urls);
  final List<String> urls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=android')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=ios')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=macos')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=web')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=windows')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=electron')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=flutter')),
        ...urls
            .map((e) => WebDataObject.fromWebPage('$e?platform=react-native')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=react-js')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=unity')),
        ...urls.map((e) => WebDataObject.fromWebPage('$e?platform=unreal')),
      ];
}
