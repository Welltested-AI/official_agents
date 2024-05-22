import 'package:ai_sdk/data_sources.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

/// [AskCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsSource].
class GenerateCommand extends Command {
  GenerateCommand(
      {required this.docsSource,
      required this.examplesDataSource,
      required this.providersDataSource});

  final DocsDataSource docsSource;
  final ExamplesDataSource examplesDataSource;
  final ProvidersDataSource providersDataSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Requirement', optional: false);
  final codeAttachment = CodeInput('Code Reference', optional: true);

  @override
  String get slug => '/generate';

  @override
  String get intent => 'Generate code for your usecase';

  @override
  String get textFieldLayout =>
      "Hi, please let me know your $userQuery $codeAttachment";

  @override
  List<DashInput> get registerInputs => [userQuery, codeAttachment];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocs = MatchDocumentOuput();
    final matchingExamples = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery $codeAttachment',
          dataSources: [docsSource],
          output: matchingDocs),
      MatchDocumentStep(
          query: 'Code for: $userQuery with reference as $codeAttachment',
          dataSources: [examplesDataSource, providersDataSource],
          output: matchingExamples),
      PromptQueryStep(
        prompt:
            '''You are a Vercel AI SDK integration agent. You've to help generate code for the user's requirement for the SDK.
            
            The Vercel AI SDK is a TypeScript library designed to help developers build AI-powered applications with React, Next.js, Vue, Nuxt, SvelteKit, and more.

            Integrating LLMs into applications is complicated and heavily dependent on the specific model provider you use.

            The Vercel AI SDK simplifies this process by abstracting away the differences between model providers, eliminating boilerplate code for building chatbots, and allowing you to go beyond text output to generate rich, interactive components.

            AI SDK Core: A unified API for generating text, structured objects, and tool calls with large language models (LLMs).
            AI SDK UI: A set of framework-agnostic hooks for quickly building chat interfaces.
            AI SDK RSC: A library to stream generative user interfaces with React Server Components (RSC).
            
            Here is the user requirements: $userQuery, and their attached code snippet: $codeAttachment
            
            Some relevant documents based on user's requirements for your reference:
            $matchingDocs
            $matchingExamples
            
            Figure out if user wants to generate new code or update existing snippet and assist them with the process.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
