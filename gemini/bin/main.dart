import 'package:dash_agent/dash_agent.dart';
import 'package:gemini/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final geminiAPIUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://ai.google.dev/sitemap_0_of_1.xml',
      [RegExp(r'^https://ai.google.dev/gemini-api/docs.*')]);

  await processAgent(MyAgent(geminiAPIUrls));
}
