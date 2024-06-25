import 'package:apyhub/data_sources.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

/// [IntegrateCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class ExploreCommand extends Command {
  ExploreCommand({required this.docsDataSource});

  final DataSource docsDataSource;

  /// Inputs to be provided by the user in the text field
  final apiDescription = StringInput('Usecase', optional: false);
  @override
  String get slug => '/explore';

  @override
  String get intent => 'Find the right API';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you find the right ApyHub API.  $apiDescription";

  @override
  List<DashInput> get registerInputs => [apiDescription];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: 'API for this usecase: $apiDescription ',
          dataSources: [docsDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt: '''
            You are an ApyHub API Integration assistant. 

            ApyHub provides developers with pre-built APIs for various usecases that they can directly use in their code to execute the task without having to worry writing their own code.
            
            This is the user's usecase description: $apiDescription.
            
            Here are some relevant APIs that ApyHub offers:
            $matchingDocuments

            Choose the API that the user can use based on their usecase. If there is no API available, inform the user accordingly
            
            Also quote the url of the page of the API if available. Don't cook up things on your own. Be understanding of what is the functionality API offers and generate factually correct answers only''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
