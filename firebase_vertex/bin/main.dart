import 'package:dash_agent/dash_agent.dart';
import 'package:firebase_vertex/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final firebaseVertexUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://firebase.google.com/sitemap_0_of_1.xml',
      [RegExp(r'^https://firebase.google.com/docs/vertex-ai.*')]);
  await processAgent(MyAgent(firebaseVertexUrls));
}
