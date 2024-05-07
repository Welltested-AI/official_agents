import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
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
  List<WebDataObject> get webObjects => [];
}

/// [BlogsDataSource] is a specific data source indexing blogs stored in filesystem or on web.
///
/// We are not using it in any of the commands.
class BlogsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [
        DirectoryFiles(Directory('directory_path_to_data_source'),
            relativeTo: 'parent_directory_path')
      ];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [WebDataObject.fromWebPage('https://sampleurl.com')];
}
