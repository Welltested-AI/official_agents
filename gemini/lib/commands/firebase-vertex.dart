import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:gemini/data_sources.dart';

class FirebaseVertex extends Command {
  FirebaseVertex(this.firebaseVertexAiDataSource);
  final FirebaseVertexAiDataSource firebaseVertexAiDataSource;
  final generateInstructions = StringInput('Generate Instructions');

  final referenceCode = CodeInput('Reference', optional: true);
  final referenceCode2 = CodeInput('Reference', optional: true);
  @override
  String get slug => '/firebase-vertex';

  @override
  String get intent => 'Integrate Gemini via Firebase Vertex AI';

  @override
  List<DashInput> get registerInputs =>
      [generateInstructions, referenceCode, referenceCode2];
  @override
  String get textFieldLayout =>
      'Hi! I can help you generate or edit Gemini code via the Firebase Vertex AI. Let me know your instructions $generateInstructions and any code references: $referenceCode $referenceCode2';

  @override
  List<Step> get steps {
    final matchDocumentsOutput = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query:
              'Documentaion or sample for Gemini API via the Firebase Vertex AI for Dart SDK for $generateInstructions and $referenceCode $referenceCode2',
          dataSources: [firebaseVertexAiDataSource],
          output: matchDocumentsOutput),
      PromptQueryStep(prompt: '''
        The Vertex AI Gemini API gives you access to the latest generative AI models from Google: the Gemini models. If you need to call the Vertex AI Gemini API directly from your mobile or web app rather than server-side — you can use the Vertex AI for Firebase SDKs.

        Write a code snippet in Dart for a Flutter app using the Firebase Vertex AI to perform the following task:
        $generateInstructions 

        Here's some reference code:
        $referenceCode
        $referenceCode2

        Here is the latest documentation of Firebase Vertex AI that should be referred to cater the user's query.

        $matchDocumentsOutput

        Vertex AI Firebase SDK is very new and it doesn't have a lot of examples or in depth documentation, so if you don't find a relevant document - inform the user and try to quote any trusted sources from the documenation provided for further details.
        ''', promptOutput: promptOutput),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
