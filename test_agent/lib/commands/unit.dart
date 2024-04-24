import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class UnitCommand extends Command {
  UnitCommand();

  /// Inputs
  final extraDetails = StringInput('Additional Details', optional: true);
  final codeAttachment = CodeInput('Testable code', optional: false);
  final reference1 = CodeInput('Existing Reference', optional: true);
  final reference2 = CodeInput('Existing Reference', optional: true);
  final reference3 = CodeInput('Existing Reference', optional: true);
  final unitTestTemplate =
      '''// Import necessary packages and files
...

// Generate mocks for dependencies
@GenerateMocks([UniversityEndpoint])
void main() {
  // Declare variables
  late UniversityEndpoint endpoint;
  late UniversityRemoteDataSource dataSource;

  // Group tests related to function calls
  group("Test function calls", () {
    // Set up dependencies before each test
    setUp(() {
      endpoint = MockUniversityEndpoint();
      dataSource = UniversityRemoteDataSource(universityEndpoint: endpoint);
    });

    // Test if dataSource calls getUniversitiesByCountry from endpoint
    test('Test dataSource calls getUniversitiesByCountry from endpoint', () {
      // Mock the endpoint response
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

      // Call the method under test
      dataSource.getUniversitiesByCountry("test");

      // Verify if the method in endpoint is called with correct parameters
      verify(endpoint.getUniversitiesByCountry("test"));
    });

    // Test if dataSource maps getUniversitiesByCountry response to Stream
    test('Test dataSource maps getUniversitiesByCountry response to Stream', () {
      // Mock the endpoint response
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

      // Expect the method under test to emit certain values in order
      expect(
        dataSource.getUniversitiesByCountry("test"),
        emitsInOrder([
          const AppResult<List<University>>.loading(),
          const AppResult<List<University>>.data([])
        ]),
      );
    });

    // Test if dataSource maps getUniversitiesByCountry response to Stream with error
    test('Test dataSource maps getUniversitiesByCountry response to Stream with error', () {
      // Create a mock API error
      ApiError mockApiError = ApiError(
        statusCode: 400,
        message: "error",
        errors: null,
      );

      // Mock the endpoint response
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.error(mockApiError));

      // Expect the method under test to emit certain values in order
      expect(
        dataSource.getUniversitiesByCountry("test"),
        emitsInOrder([
          const AppResult<List<University>>.loading(),
          AppResult<List<University>>.apiError(mockApiError)
        ]),
      );
    });
  });
}
}''';

  @override
  String get slug => 'unit';

  @override
  String get intent => 'Generate unit test';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you generate unit tests for your codebase. Please share the following info: $codeAttachment \n $extraDetails \nReferences [Optional]: $reference1 $reference2 $reference3";

  @override
  List<DashInput> get registerInputs =>
      [extraDetails, codeAttachment, reference1, reference2, reference3];

  @override
  List<Step> get steps {
    // Outputs
    final promptOutput = PromptOutput();
    return [
      PromptQueryStep(
        prompt: '''You are a Flutter/Dart unit test writing assistant.

Generate Flutter unit tests covering common as well as edge case scenarios for the code shared below keeping the important instructions in mind:

```dart
$codeAttachment
```

Important instructions shared below:
$extraDetails

Please find additional references that you can use to generate unit tests as well:
```dart
// Reference 1
$reference1

// Reference 2
$reference2

// Reference 3
$reference3
```

Sharing unit test template that you can use to generate unit test:
```dart
$unitTestTemplate
```

Additional things to keep in mind:
1. Include inline comments for improving code readability.
2. State any assumption made or libraries used while creating unit tests.
3. Generate smart test cases that not only covers all possible execution paths covers the intended behaviours based real world use cases.
4. Brief about the test cases considered while generating code and how they are helping in generating a full code coverage.
            ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
