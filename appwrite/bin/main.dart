import 'package:dash_agent/dash_agent.dart';
import 'package:appwrite/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final appwriteAIDocUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://appwrite.io/sitemap.xml',
      [RegExp(r'^https://appwrite.io/docs/products/ai.*')]);
  await processAgent(MyAgent(appwriteAIDocUrls));
}
