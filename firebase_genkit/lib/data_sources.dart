import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/filters/filter.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  DocsDataSource(this.docUrls);
  final List<String> docUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [...docUrls.map((e) => WebDataObject.fromWebPage(e))];
}

class ExamplesDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        //TODO: add code filter
        WebDataObject.fromGithub('https://github.com/firebase/genkit', '',
            codeFilter: CodeFilter(
                pathRegex:
                    r'^samples\/.*') //only include files in the /sample folder of the repo
            )
      ];
}
