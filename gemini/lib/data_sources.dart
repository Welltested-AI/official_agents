import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

class FirebaseVertexAiDataSource extends DataSource {
  FirebaseVertexAiDataSource(this.documentationUrls);
  final List<String> documentationUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        ...documentationUrls
            .map((url) => WebDataObject.fromWebPage('$url?platform=flutter'))
      ];
}

class GeminiApDataSource extends DataSource {
  GeminiApDataSource(this.documentationUrls);
  final List<String> documentationUrls;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects =>
      [...documentationUrls.map((url) => WebDataObject.fromWebPage(url))];
}

class GeminiApiExamplesDataSource extends DataSource {
  GeminiApiExamplesDataSource(this.codeSamples);
  final List<String> codeSamples;
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  // TODO: implement projectObjects
  List<ProjectDataObject> get projectObjects => [];
  // List<ProjectDataObject> get projectObjects =>
  //     [...codeSamples.map((sample) => ProjectDataObject.fromText(sample))];

  @override
  List<WebDataObject> get webObjects => [];
}

class PromptDataSource extends DataSource {
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromWebPage(
            'https://ai.google.dev/gemini-api/docs/prompting-intro'),
        WebDataObject.fromWebPage(
            'https://ai.google.dev/gemini-api/docs/prompting-strategies'),
        WebDataObject.fromWebPage(
            'https://ai.google.dev/gemini-api/docs/file-prompting-strategies'),
        WebDataObject.fromWebPage(
            'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/chat_company_chatbot_7'),
        WebDataObject.fromWebPage(
            'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/classification_classify_articles_11'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/code_explanation_explain_a_sql_function_20'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/code_generation_generate_quick_sort_unit_test_24'),
        WebDataObject.fromWebPage(
            'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/extraction_extract_dates__and__events_38'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/image_fill_an_empty_form_52'),
        // WebDataObject.fromSiteMap(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/question_answering_analyze_market_share_68'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/summarization_summarize_hotel_reviews_77'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/video_extract_video_chapters_87'),
        // WebDataObject.fromWebPage(
        //     'https://cloud.google.com/vertex-ai/generative-ai/docs/prompt-gallery/samples/writing_email_writing_98')
      ];
}
