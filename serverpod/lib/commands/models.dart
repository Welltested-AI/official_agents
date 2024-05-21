import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:serverpod/data_sources.dart';

/// [ModelsCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsDataSource].
class ModelsCommand extends Command {
  ModelsCommand(
      {required this.docsDataSource, required this.examplesDataSource});

  final DocsDataSource docsDataSource;
  final ExamplesDataSource examplesDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Model Description', optional: false);
  final existingModel = CodeInput('Existing Model', optional: true);
  final reference = CodeInput('Reference', optional: true);

  @override
  String get slug => '/model';

  @override
  String get intent => 'Creating or update model yaml files';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you create models in Serverpod. $userQuery $existingModel and an optional $reference";

  @override
  List<DashInput> get registerInputs => [userQuery, existingModel, reference];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery\n$existingModel',
          dataSources: [docsDataSource, examplesDataSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are a Serverpod Model expert. Your job is to help users generate models in their serverpod applications based on their provided description.

            Intro to serverpod:
            ###
            Serverpod is an open-source, scalable app server, written in Dart for the Flutter community.

            Models are Yaml files used to define serializable classes in Serverpod. They are used to generate Dart code for the server and client, and, if a database table is defined, to generate database code for the server. Using regular .yaml files within lib/src/models is supported, but it is recommended to use .spy.yaml (.spy stands for "Server Pod Yaml") to leverage syntax highlighting provided by the Serverpod Extension for VS Code.

            The files are analyzed by the Serverpod CLI when generating the project and creating migrations.

            Run serverpod generate to generate dart classes from the model files.
            ###

            Here is the model description from the user $userQuery for the generation of serverpod model files.
            
            Existing model: $existingModel that user wanted to update. If N/A - user wants to generate a new model.

            And a sample model or other code snippet from their codebase that they want you to keep in mind $reference

            Here are some relevant documents for the latest docs and/or examples for your reference: $matchingDocuments. 

            Help user with their query - by generating the new models or update the existing ones if provided.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
