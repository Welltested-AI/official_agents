import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

class IntroductoryDocs extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [
        FileDataObject.fromDirectory(Directory(
            '/Users/samyak/Documents/commanddash/default_agents/riverpod/assets/notes'))
      ];
  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromWebPage('https://pub.dev/packages/riverpod'),
        WebDataObject.fromWebPage('https://pub.dev/packages/riverpod/example'),
        WebDataObject.fromWebPage('https://pub.dev/packages/riverpod/install'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/introduction/why_riverpod'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/introduction/getting_started'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/essentials/first_request'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/migration/from_state_notifier'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/migration/from_change_notifier'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/migration/0.14.0_to_1.0.0'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/migration/0.13.0_to_0.14.0'),
        WebDataObject.fromWebPage(
            'https://github.com/dhafinrayhan/dummymart/blob/master/lib/features/auth/providers/auth_state.dart'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/concepts/combining_providers')
      ];
}

class ExampleDocs extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [
        FileDataObject.fromDirectory(
            Directory(
                '/Users/samyak/Documents/commanddash/default_agents/riverpod/assets/examples'),
            includePaths: true,
            regex: RegExp(r'(\.dart$)'),
            relativeTo:
                '/Users/samyak/Documents/commanddash/default_agents/riverpod/assets/examples')
      ];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [];
}

class ProviderDocs extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/notifier_provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/future_provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/state_notifier_provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/future_provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/stream_provider'),
        WebDataObject.fromWebPage(
            'https://riverpod.dev/docs/providers/state_provider'),
      ];
}

class DocsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [WebDataObject.fromSiteMap('https://riverpod.dev/sitemap.xml')];
}
