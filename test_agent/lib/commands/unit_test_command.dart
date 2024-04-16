import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class UnitTestCommand extends Command {
  UnitTestCommand();

  /// Inputs
  final extraDetails = StringInput('Additional Details', optional: true);
  final codeAttachment = CodeInput('Testable code', optional: false);
  final reference1 = CodeInput('Existing Reference', optional: true);
  final reference2 = CodeInput('Existing Reference', optional: true);
  final reference3 = CodeInput('Existing Reference', optional: true);
  final unitTestTemplate = '''import 'university_remote_data_source_test.mocks.dart';

@GenerateMocks([UniversityEndpoint])
void main() {
    late UniversityEndpoint endpoint;
    late UniversityRemoteDataSource dataSource;

    group("Test function calls", () {
        setUp(() {
            endpoint = MockUniversityEndpoint();
            dataSource = UniversityRemoteDataSource(universityEndpoint: endpoint);
        });

        test('Test dataSource calls getUniversitiesByCountry from endpoint', () {
            when(endpoint.getUniversitiesByCountry("test"))
                    .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

            dataSource.getUniversitiesByCountry("test");
            verify(endpoint.getUniversitiesByCountry("test"));
        });

        test('Test dataSource maps getUniversitiesByCountry response to Stream',
                () {
            when(endpoint.getUniversitiesByCountry("test"))
                    .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

            expect(
                dataSource.getUniversitiesByCountry("test"),
                emitsInOrder([
                    const AppResult<List<University>>.loading(),
                    const AppResult<List<University>>.data([])
                ]),
            );
        });

        test(
                'Test dataSource maps getUniversitiesByCountry response to Stream with error',
                () {
            ApiError mockApiError = ApiError(
                statusCode: 400,
                message: "error",
                errors: null,
            );
            when(endpoint.getUniversitiesByCountry("test"))
                    .thenAnswer((realInvocation) => Future.error(mockApiError));

            expect(
                dataSource.getUniversitiesByCountry("test"),
                emitsInOrder([
                    const AppResult<List<University>>.loading(),
                    AppResult<List<University>>.apiError(mockApiError)
                ]),
            );
        });
    });
}''';

  @override
  String get slug => 'unit';

  @override
  String get intent => 'Generate unit test';

  @override
  String get textFieldLayout =>
      "Hi, please share the code and any other optional instructions to be following while generating unit test. \nCode: $codeAttachment \nAdditional Details[Optional] $extraDetails \nReference 1[Optional]: $reference1 \nReference 2[Optional]: $reference2 \nReference 3[Optional]: $reference3";

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
1. Include inline comments for improving code readability
2. State any assumption made or libraries used while creating unit tests
3. Brief about the test cases considered while generating code and how they are helping in generating a full code coverage
            ''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
