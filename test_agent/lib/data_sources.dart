import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

class GeneralDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromWebPage(
            'https://pub.dev/documentation/mocktail/latest/'),
        WebDataObject.fromWebPage('https://pub.dev/packages/bloc_test'),
        WebDataObject.fromWebPage(
            'https://pub.dev/documentation/mockito/latest/index.html'),
        WebDataObject.fromSiteMap(
            'https://github.com/rrousselGit/riverpod/blob/master/examples/todos/test/widget_test.dart'),
        WebDataObject.fromSiteMap(
            'https://github.com/rrousselGit/riverpod/blob/master/examples/counter/test/widget_test.dart'),
        WebDataObject.fromWebPage('https://pub.dev/packages/mockito/example'),
        WebDataObject.fromWebPage(
            'https://www.toptal.com/flutter/unit-testing-flutter'),
        WebDataObject.fromWebPage(
            'https://github.com/oudaykhaled/nyt-flutter-clean-architecture-unit-test/blob/master/test/unit-tests/articles_list/data/remote/article_service_impl_test.dart'),
        WebDataObject.fromWebPage(
            'https://github.com/oudaykhaled/nyt-flutter-clean-architecture-unit-test/blob/master/test/unit-tests/articles_list/data/repository/article_repo_impl_test.dart'),
        WebDataObject.fromWebPage(
            'https://github.com/wednesday-solutions/flutter_template/blob/main/test/domain/weather/get_favorite_cities_stream_use_case_impl_test.dart'),
        WebDataObject.fromWebPage(
            'https://github.com/wednesday-solutions/flutter_template/blob/main/test/presentation/widget/destinations/weather/search/widgets/search_page_results_content_test.dart'),
      ];
}
