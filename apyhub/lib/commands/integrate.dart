import 'package:apyhub/data_sources.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

/// [IntegrateCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class IntegrateCommand extends Command {
  IntegrateCommand({required this.docsDataSource});

  final DocsDataSource docsDataSource;

  /// Inputs to be provided by the user in the text field
  final apiDescription = StringInput('API Description', optional: false);
  final existingCode = CodeInput('Exisiting Code', optional: true);
  final existingCode2 = CodeInput('Exisiting Code', optional: true);
  final existingCode3 = CodeInput('Exisiting Code', optional: true);

  @override
  String get slug => '/integrate';

  @override
  String get intent => 'Integrate API in your code';

  @override
  String get textFieldLayout =>
      "Hi, Let's integrate $apiDescription $existingCode $existingCode2 $existingCode3";

  @override
  List<DashInput> get registerInputs =>
      [apiDescription, existingCode, existingCode2, existingCode3];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query:
              'API Documentation for: $apiDescription that may or may not include $existingCode',
          dataSources: [docsDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt: '''
            You are an ApyHub API Integration assistant. 

            ApyHub provides developers with pre-built APIs for various usecases that they can directly use in their code to execute the task without having to worry writing their own code.
            
            This is the user's API description: $apiDescription and a code snippets from their codebase that they may want you to take as a reference and generate code that adds to it or just use as example of how their project style is.
            $existingCode
            $existingCode2
            $existingCode3
            
            Here are some relevant APIs that ApyHub offers:
            $matchingDocuments

            Choose the API that the user wants to integrate based on their description and generate the integration code for it for their codebase - include the request, data classes or anything else like error handling. Keep their code references attached in mind.
            
            Be thorugh and factually correct with the API integration. If something is not possible, let user know.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
