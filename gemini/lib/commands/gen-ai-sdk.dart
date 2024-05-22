import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:gemini/data_sources.dart';

class GenAISDK extends Command {
  GenAISDK(this.geminiApDataSource, this.geminiApiExamplesDataSource);
  final GeminiApDataSource geminiApDataSource;
  final GeminiApiExamplesDataSource geminiApiExamplesDataSource;

  final generateInstructions = StringInput('Generate Instructions');

  final referenceCode = CodeInput('Reference', optional: true);
  final referenceCode2 = CodeInput('Reference', optional: true);

  @override
  String get slug => '/gen-ai-sdk';

  @override
  String get intent => 'Integrate Gemini directly via Gen AI SDK';

  @override
  List<DashInput> get registerInputs =>
      [generateInstructions, referenceCode, referenceCode2];

  @override
  String get textFieldLayout =>
      'Hi! I can help you generate or edit Gemini integreate via Google Gen AI Dart SDK. Let me know your instructions $generateInstructions and any code references: $referenceCode $referenceCode2';

  @override
  List<Step> get steps {
    final geminiAPIDocs = MatchDocumentOuput();
    final genAiCodeSamples = MatchDocumentOuput();
    final promptOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query:
              'Documentation for Gemini API with google_gen_ai Dart SDK $generateInstructions and $referenceCode $referenceCode2',
          dataSources: [geminiApDataSource],
          output: geminiAPIDocs),
      MatchDocumentStep(
          query: '$generateInstructions and $referenceCode $referenceCode2',
          dataSources: [geminiApDataSource],
          output: genAiCodeSamples),
      PromptQueryStep(prompt: '''
        The Gemini API gives you access to the latest generative AI models from Google: the Gemini models. Flutter developers can access these APIs via the Google Generative AI SDK in Dart.

        Write a code snippet in Dart for a Flutter app using the Google Gen AI SDK to perform the following task:
        $generateInstructions 

        Here's some reference code:
        $referenceCode
        $referenceCode2

        Here is the latest documentation of the Gemini API:
        $geminiAPIDocs

        Here are some code samples of the Google Generative AI Dart SDK:
        $genAiCodeSamples

        Googe Generative AI SDK is new and it doesn't have a lot of examples or in depth documentation, so if you don't find a relevant document - inform the user and try to quote any trusted sources from the documenation provided for further details.
        ''', promptOutput: promptOutput),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
