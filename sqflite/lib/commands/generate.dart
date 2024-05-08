import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class GenerateCommand extends Command {
  GenerateCommand(
      {required this.exampleDataSource, required this.docDataSource});
  final DataSource exampleDataSource;
  final DataSource docDataSource;
  final generateInstructions = StringInput('Instructions');
  final codeReference1 = CodeInput('Reference', optional: true);
  final codeReference2 = CodeInput('Reference', optional: true);

  @override
  String get intent => 'Generate navigation related code using go_router based on request';

  @override
  List<DashInput> get registerInputs =>
      [generateInstructions, codeReference1, codeReference2];

  @override
  String get slug => 'generate';

  @override
  List<Step> get steps {
    final docReferences = MatchDocumentOuput();
    final codeReferences = MatchDocumentOuput();
    final filteredReferences = PromptOutput();
    final resultOutput = PromptOutput();
    return [
      MatchDocumentStep(
          query:
              'examples/instructions of writing code using sqflite - $generateInstructions $codeReference1 $codeReference2.',
          dataSources: [docDataSource],
          output: docReferences),
      MatchDocumentStep(
          query:
              'examples/instructions of writing code using sqflite - $generateInstructions $codeReference1 $codeReference2.',
          dataSources: [exampleDataSource],
          output: codeReferences),
      PromptQueryStep(
          prompt:
              '''You are tasked with finding the at most top 3 most relevant references from the shared input refereces for a specific query. Your goal is to provide a concise list of references out of the shared references in Markdown format.

Query: examples/instructions of writing code using sqflite - $generateInstructions $codeReference1 $codeReference2.

Input References:
## Doc References
$docReferences

## Code Refrences
$codeReferences

Instructions:
1. Read through the provided inpur references and identify the most relevant references that are pertinent to the given query.
2. For each relevant reference, provide the following information in Markdown format:
   - Brief Summary describing relevance to the given query
   - Reference content

Example input:
  Query: Latest version of go_router

  Input References:
  This article introduces go_router, a new Flutter router package designed specifically for web applications.
  This blog post announces the release of go_router version 2.0, highlighting the new features and improvements.
  This guide explains asynchronous programming concepts in Dart, including Futures, Streams, and async/await syntax.

Example Output:

  - **Reference Title:** "Blog on go_router v2.0 Released: What's New?"
  - **Reference Content**: This blog post announces the release of go_router version 2.0, highlighting the new features and improvements.

Please provide the list of relevant references in the specified Markdown format.''',
          promptOutput: filteredReferences),
      PromptQueryStep(
          prompt:
              '''You are tasked with generating Flutter code to implement local storage using the sqflite package. Your goal is to create code snippets as per the user requirement including (but not limited to) how to create a SQLite database, define database tables, perform CRUD operations, and handle asynchronous operations using sqflite. 
              
          Please find the instructions <Instructions> and relevant code references/examples <Code References> shared.
          Instructions: $generateInstructions
           
          Code References:
          ```dart
          // code reference 1
          $codeReference1

          // code reference 2
          $codeReference2
          ```
          
          Documentation or examples of the chopper package for reference:
          $filteredReferences
          

          Deliverables:
          1. Generated Flutter code demonstrating navigation using the go_router package.
          2. Documentation outlining the process of generating the code, including explanations and usage examples.
          ''',
          promptOutput: resultOutput),
      AppendToChatStep(value: '$resultOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      'Generate the code using sqflite: $generateInstructions \n\nOptionally attach any references: $codeReference1 $codeReference2';
}