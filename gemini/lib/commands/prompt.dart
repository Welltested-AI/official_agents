import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';
import 'package:gemini/data_sources.dart';

/// [PromptCommand] generates a prompt based on user input.
class PromptCommand extends Command {
  PromptCommand(this.promptDataSource);
  final PromptDataSource promptDataSource;
  final promptGuidelines = StringInput('Prompt Guidelines');
  final existingPrompt = CodeInput('Existing Prompt', optional: true);
  final reference = CodeInput('Additional Reference', optional: true);

  @override
  String get slug => '/prompt';

  @override
  String get intent => 'Generate, review or refine a prompt';

  @override
  String get textFieldLayout =>
      "Enter your desired prompt guidelines: $promptGuidelines. Any prompt or code references: $existingPrompt $reference";

  @override
  List<DashInput> get registerInputs =>
      [promptGuidelines, existingPrompt, reference];

  @override
  List<Step> get steps {
    final matchingDocs = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query:
              'Documenation helpful to generate prompt for guidelines $promptGuidelines, on existing prompt - $existingPrompt and reference - $reference',
          dataSources: [promptDataSource],
          output: matchingDocs),
      PromptQueryStep(
        prompt: '''
            When user call the Gemini API, they send along a prompt with the request. By carefully crafting these prompts, they can influence the model to generate output specific to their needs. Prompts can contain questions, instructions, contextual information, few-shot examples, and partial input for the model to complete or continue.

            You are a prompting expert helping use generate new prompts to use in their requests and review or refine existing prompts as well.

            Here is the guidelines for which the user wants to generate or edit the prompt: $promptGuidelines 
            
            This is their current prompt that if exists, they may wanna update it or if N/A means they want to generate a new one:
            $existingPrompt
            
            An optional reference from user's code for you to keep in mind:
            $reference

            Here is documentation on prompting strategies with some examples from an official guide on writing good quality prompts:
            $matchingDocs 

            Generate, review or refine the prompt for user based on their guidelines, currrent prompt and the references and documentation provided.
            
            When outputting the prompt, put in inside ```
            ``` quotes so it renders correctly for the user''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
