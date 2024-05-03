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
        WebDataObject.fromWebPage('https://hadrien-lejard.gitbook.io/chopper'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/getting-started'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/requests'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/interceptors'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/converters/converters'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/converters/built-value-converter'),
        WebDataObject.fromWebPage(
            'https://hadrien-lejard.gitbook.io/chopper/faq')
      ];
}

/// [DocsDataSource] indexes all the examples related data and provides it to commands.
class ExampleDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [
        FileDataObject.fromDirectory(Directory('assets/examples'),
            includePaths: true,
            regex: RegExp(r'(\.dart$)'),
            relativeTo:
                '/Users/yogesh/Development/org.welltested/default_agents/chopper/assets/examples')
      ];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [];
}

/// [DocsDataSource] indexes all the issues and their solutions related data and provides it to commands.
class IssuesDataSource extends DataSource {
  final List<String> issuesLinks;

  IssuesDataSource(this.issuesLinks);

  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [for (final issueUrl in issuesLinks) WebDataObject.fromWebPage(issueUrl)];
}



