import 'package:dash_agent/dash_agent.dart';
import 'package:aws_fundamentals/agent.dart';

/// Entry point used by the [dash-cli] to extract your agent configuration during publishing.
Future<void> main() async {
  await processAgent(MyAgent());
}
