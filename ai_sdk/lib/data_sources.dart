import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://sdk.vercel.ai/sitemap.xml'),
        WebDataObject.fromWebPage('https://www.npmjs.com/package/ai'),
        WebDataObject.fromWebPage(
            'https://vercel.com/blog/vercel-ai-sdk-3-1-modelfusion-joins-the-team')
      ];
}

class ExamplesDataSource extends DataSource {
  ExamplesDataSource(
    this.exampleUrls,
  );
  final List<String> exampleUrls;

  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        ...exampleUrls.map((url) => WebDataObject.fromWebPage(url)),
      ];
}

class ProvidersDataSource extends DataSource {
  ProvidersDataSource(this.providerUrls);
  final List<String> providerUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [...providerUrls.map((url) => WebDataObject.fromWebPage(url))];
}
