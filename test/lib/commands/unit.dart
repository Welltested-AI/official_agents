import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class UnitCommand extends Command {
  final DataSource generalSource;
  UnitCommand(this.generalSource);

  /// Inputs
  final codeAttachment = CodeInput('Test Code', optional: false);
  final extraDetails = StringInput('Instructions', optional: true);
  final reference1 =
      CodeInput('Existing Test', optional: true, includeContextualCode: false);
  final unitTestTemplate = '''// Import necessary packages and files
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
      "To generate unit test, please provide: $codeAttachment \n $extraDetails \n\n A matching existing test [Optional]: $reference1";

  @override
  List<DashInput> get registerInputs =>
      [extraDetails, codeAttachment, reference1];

  @override
  List<Step> get steps {
    // Outputs

    final generatedUnitTest = PromptOutput();

    return [
      PromptQueryStep(
        prompt: '''You are a Flutter/Dart unit test writing assistant.

Generate Flutter unit tests covering common as well as edge case scenarios for the code shared below keeping the important instructions in mind:

```dart
$codeAttachment
```

Important instructions shared below:
$extraDetails

Please find existing test from user's codebase to understand their testing style:
```dart
$reference1
```

Sharing a unit test template that you can use to generate unit test:
```dart
$unitTestTemplate
```

Additional things to keep in mind:
1. Include inline comments for improving code readability.
2. State any assumption made or libraries used while creating unit tests.
3. Generate smart test cases that not only covers all possible execution paths covers the intended behaviours based real world use cases.
            ''',
        promptOutput: generatedUnitTest,
      ),
      AppendToChatStep(value: '$generatedUnitTest')
    ];
  }
}
