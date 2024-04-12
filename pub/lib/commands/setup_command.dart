import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class SetupCommand extends Command {
  SetupCommand({required this.docsSource});

  final DataSource docsSource;

  /// Inputs
  final userIntention = StringInput('Your query', optional: false);
  final codeInput = CodeInput('Relevant code (if any)', optional: true);

  @override
  String get slug => 'setup';

  @override
  String get intent => 'Share a draft implementation of package';

  @override
  String get textFieldLayout =>
      "Hi, please state your intention of using package, and provide relevant code (if any) that is relevant to package implemtation: $userIntention $codeInput";

  @override
  List<DashInput> get registerInputs =>
      [userIntention, codeInput];

  @override
  List<Step> get steps {
    // Outputs
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query: '$userIntention',
          dataSources: [docsSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt:
            '''You are an Flutter expert who helps devs in implementation of flutter/dart packages based on their project need.
            
            Please find the user user intention <Intention>, and relavant code from project <Relevant Code>: 
            
            Intention: $userIntention
            Relevant Code: $codeInput

            Finally, also find the relavant references <References> picked from the Flutter pub.dev for you to help in assisting.
            References: 
            $matchingDocuments.
            
            Now, share the implementation of package based on the user intention shared above!
           **Note**: Please only share code and relevant explanation. Also, be concise on code explanation and minimise prose''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: 'Intetntion $userIntention \n\nImplementation:$promptOutput')
    ];
  }
}
