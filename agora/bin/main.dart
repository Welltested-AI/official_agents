import 'package:dash_agent/dash_agent.dart';
import 'package:agora/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final urls = await SitemapHelper.fetchAndFilterUrls(
      'https://docs.agora.io/en/sitemap.xml',
      [RegExp(r'^https://docs.agora.io/en.*')]);
  await processAgent(MyAgent(urls));
}
