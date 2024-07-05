import 'package:dash_agent/dash_agent.dart';
import 'package:typespec/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  await processAgent(MyAgent());
}
