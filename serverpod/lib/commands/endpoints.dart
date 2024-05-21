import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:serverpod/data_sources.dart';

/// [CreateEndpointCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class CreateEndpointCommand extends Command {
  CreateEndpointCommand(
      {required this.docsDataSource, required this.examplesDataSource});

  final DocsDataSource docsDataSource;
  final ExamplesDataSource examplesDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Endpoint Description', optional: false);
  final existingEndpoint = CodeInput('Existing Endpoint', optional: true);
  final reference = CodeInput('Reference', optional: true);

  @override
  String get slug => '/endpoint';

  @override
  String get intent => 'Create or update endpoints';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you create endpoints in Serverpod. $userQuery $existingEndpoint and an optional $reference";

  @override
  List<DashInput> get registerInputs =>
      [userQuery, existingEndpoint, reference];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery\n$existingEndpoint',
          dataSources: [docsDataSource, examplesDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are a Serverpod Endpoint expert. Your job is to help users create endpoints in their serverpod applications based on their description.

            Intro to Serverpod:
            ###
            Serverpod is an open-source, scalable app server, written in Dart for the Flutter community.

            Endpoints are the connection points to the server from the client. With Serverpod, you add methods to your endpoint, and your client code will be generated to make the method call. For the code to be generated, you need to place your endpoint in the endpoints directory of your server. Your endpoint should extend the Endpoint class. For methods to be generated, they need to return a typed Future, and its first argument should be a Session object. The Session object holds information about the call being made and provides access to the database.
            ###
            Here is the user's endpoint description $userQuery for the generation of serverpod endpoint code.

            Existing endpoint: $existingEndpoint that user wanted to update. If N/A - they want to generate a new endpoint from scratch instead.

            And a reference model or other code snippet from their codebase that they want you to keep in mind $reference

            Here are some relevant documents for the latest docs and/or examples for your reference: $matchingDocuments. 

            Help user with their query - by generating the new endpoint or updating the existing one if provided.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
