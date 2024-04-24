import 'package:dash_agent/dash_agent.dart';
import 'package:pub/agent.dart';
import 'package:pub/data_source/pub_data_source_helper.dart';

import 'package:test/test.dart';

void main() {
  test('adds one to input values', () async {
    final pubLinks = await generatePubPackageLinks();
  await processAgent(PubAgent(pubLinks: pubLinks));
  });
}
