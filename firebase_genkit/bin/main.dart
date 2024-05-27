import 'package:dash_agent/dash_agent.dart';
import 'package:firebase_genkit/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final genkitDocUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://firebase.google.com/sitemap_0_of_1.xml',
      [RegExp(r'^https://firebase.google.com/docs/genkit.*')]);
  await processAgent(MyAgent(genkitDocUrls));
}
