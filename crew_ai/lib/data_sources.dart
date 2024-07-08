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
        WebDataObject.fromGithub(
            'https://github.com/joaomdmoura/crewAI-tools', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/joaomdmoura/crewai/', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/joaomdmoura/crewAI-examples', accessToken)
      ];
}
