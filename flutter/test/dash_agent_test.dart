import 'package:dash_agent/dash_agent.dart';
import 'package:flutter/agent.dart';

import 'package:test/test.dart';

void main() {
  test('adds one to input values', () async {
    await processAgent(FlutterAgent());
  });
}
