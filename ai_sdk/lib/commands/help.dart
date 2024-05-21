import 'package:ai_sdk/data_sources.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

/// [HelpCommand] accepts a [CodeInput] from the user with their query [StringInput] and provides the with a suitable answer taking reference from your provided [docsSource].
class HelpCommand extends Command {
  HelpCommand({required this.docsSource});

  final DocsDataSource docsSource;

  /// Inputs to be provided by the user in the text field
  final userQuery = StringInput('Query', optional: false);
  final codeAttachment = CodeInput('Code Reference', optional: true);

  @override
  String get slug => '/help';

  @override
  String get intent => 'Get any help with AI SDK';

  @override
  String get textFieldLayout =>
      "Hi, I'm here to help you with Vercel AI SDK. $userQuery $codeAttachment";

  @override
  List<DashInput> get registerInputs => [userQuery, codeAttachment];

  @override
  List<Step> get steps {
    // Temporary outputs generated during processing command.
    final matchingDocuments = MatchDocumentOuput();
    final promptOutput = PromptOutput();

    return [
      MatchDocumentStep(
          query: '$userQuery$codeAttachment',
          dataSources: [docsSource],
          output: matchingDocuments),
      PromptQueryStep(
        prompt: '''You are a Vercel AI SDK integration agent.
            
            The Vercel AI SDK is a TypeScript library designed to help developers build AI-powered applications with React, Next.js, Vue, Nuxt, SvelteKit, and more.

            Integrating LLMs into applications is complicated and heavily dependent on the specific model provider you use.

            The Vercel AI SDK simplifies this process by abstracting away the differences between model providers, eliminating boilerplate code for building chatbots, and allowing you to go beyond text output to generate rich, interactive components.

            AI SDK Core: A unified API for generating text, structured objects, and tool calls with large language models (LLMs).
            AI SDK UI: A set of framework-agnostic hooks for quickly building chat interfaces.
            AI SDK RSC: A library to stream generative user interfaces with React Server Components (RSC).


            Here is the user query: $userQuery, and their attached code snippet: $codeAttachment
            
            Some relevant documents based on user's query for your reference: $matchingDocuments
            
            Answer the user's query. If the documents are not relevant, answer from your memory but give them a disclaimer.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
