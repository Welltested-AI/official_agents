import 'package:dash_agent/dash_agent.dart';
import 'package:pub/data_source/pub_data_source_helper.dart';

import 'package:pub/agent.dart';

// Boiler plate code to processes your agent
Future<void> main() async {
  final pubLinks = await generatePubPackageLinks();
  await processAgent(PubAgent(pubLinks: pubLinks));
}
