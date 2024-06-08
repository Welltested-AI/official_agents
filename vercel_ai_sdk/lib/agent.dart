import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  MyAgent();
  final docsSource = DocsDataSource();

  @override
  Metadata get metadata => Metadata(
      name: 'Vercel AI SDK',
      avatarProfile: 'assets/triangle.png',
      tags: ['Generatie AI']);

  @override
  String get registerSystemPrompt =>
      '''You are a Vercel AI SDK integration agent.
            
            The Vercel AI SDK is a TypeScript library designed to help developers build AI-powered applications with React, Next.js, Vue, Nuxt, SvelteKit, and more.

            Integrating LLMs into applications is complicated and heavily dependent on the specific model provider you use.

            The Vercel AI SDK simplifies this process by abstracting away the differences between model providers, eliminating boilerplate code for building chatbots, and allowing you to go beyond text output to generate rich, interactive components.

            AI SDK Core: A unified API for generating text, structured objects, and tool calls with large language models (LLMs).
            AI SDK UI: A set of framework-agnostic hooks for quickly building chat interfaces.
            AI SDK RSC: A library to stream generative user interfaces with React Server Components (RSC).

            Help user with their queries. Be truthful and only answer what you can verify in the references given to you.
''';

  @override
  List<DataSource> get registerDataSources => [docsSource];

  @override
  List<Command> get registerSupportedCommands => [];
}
