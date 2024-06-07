import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class TestCommand extends Command {
  TestCommand();
  final primaryObject = CodeInput('Test Object');
  final testInstructions = StringInput('Instructions', optional: true);
  final referenceObject1 = CodeInput('Reference', optional: true);
  final referenceObject2 = CodeInput('Reference', optional: true);
  final referenceObject3 = CodeInput('Reference', optional: true);
  @override
  String get intent => 'Write tests for your chopper related code';

  @override
  List<DashInput> get registerInputs => [
        primaryObject,
        testInstructions,
        referenceObject1,
        referenceObject2,
        referenceObject3
      ];

  @override
  String get slug => 'test';

  @override
  String get textFieldLayout =>
      'Generate test for your chopper-related code $primaryObject with $testInstructions\n\nOptionally attach any supporting code: $referenceObject1 $referenceObject2 $referenceObject3';

  @override
  List<Step> get steps {
    final testOutput = PromptOutput();
    return [
      PromptQueryStep(
          prompt:
              '''Write tests for the Flutter Chopper related code <Code> with instructions - $testInstructions. 

Code:
```dart
$primaryObject
```

Here are some contextual code or references provided by the user:
```dart
// reference 1
$referenceObject1

// reference 2
$referenceObject2

// reference 3
$referenceObject3
```

Sample Unit test unrelated to the above scenerio as a reference:

```dart
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
static ApiService create() {
final client = ChopperClient(
client: MockClient((request) async {
  Map result = mockData[request.url.path]?.firstWhere((mockQueryParams) {
    if (mockQueryParams['id'] == request.url.queryParameters['id']) return true;
    return false;
  }, orElse: () => null);
  if (result == null) {
    return http.Response(
        json.encode({'error': "not found"}), 404);
  }
  return http.Response(json.encode(result), 200);
}),
baseUrl: Uri.parse('https://mysite.com/api'),
services: [
  _\$ApiService(),
],
converter: JsonConverter(),
errorConverter: JsonConverter(),
);
return _\$ApiService(client);
}

@Get(path: "/get")
Future<Response> get(@Query() String url);
}
```

Generate the test for the user's code based on the instructions.
''',
          promptOutput: testOutput),
      AppendToChatStep(value: '$testOutput')
    ];
  }
}
