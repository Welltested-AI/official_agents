import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  final accessToken = '';
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://www.cometchat.com/docs/sitemap.xml'),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-android-kotlin',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-android-java',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-react',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-angular',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-vue',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-flutter',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-ios',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/cometchat/cometchat-sample-app-react-native',
            accessToken),
        WebDataObject.fromWebPage('https://pub.dev/packages/cometchat'),
        WebDataObject.fromWebPage(
            'https://pub.dev/packages/cometchat_chat_uikit'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/calls-sdk-ionic'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/calls-sdk-javascript'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/calls-sdk-react-native'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-sdk-ionic'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-sdk-javascript'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-sdk-react-native'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-uikit-angular'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-uikit-react'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-uikit-react-native'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/chat-uikit-vue'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/uikit-elements'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/uikit-resources'),
        WebDataObject.fromWebPage(
            'https://www.npmjs.com/package/@cometchat/uikit-shared')
      ];
}
