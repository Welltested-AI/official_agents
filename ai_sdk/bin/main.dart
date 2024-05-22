import 'package:ai_sdk/utility/helpers.dart';
import 'package:dash_agent/dash_agent.dart';
import 'package:ai_sdk/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  final exampleUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://sdk.vercel.ai/sitemap.xml', [
    RegExp(r'^https://sdk.vercel.ai/examples.*'),
  ]);
  final providerUrls = await SitemapHelper.fetchAndFilterUrls(
      'https://sdk.vercel.ai/sitemap.xml',
      [RegExp(r'^https://sdk.vercel.ai/providers.*')]);

  await processAgent(MyAgent(
    exampleUrls,
    providerUrls,
  ));
}
