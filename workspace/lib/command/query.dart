import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class QueryCommand extends Command {
  /// Inputs
  final userQuery = StringInput('Query', optional: false);

  @override
  String get slug => '/query';

  @override
  String get intent => 'Answer to queries related to your project';

  @override
  String get textFieldLayout => "Hi, Please share your query: $userQuery";

  @override
  List<DashInput> get registerInputs => [userQuery];

  @override
  List<Step> get steps {
    // Outputs
    final matchingCode = MultiCodeObject();
    final promptOutput = PromptOutput();
    return [
      WorkspaceQueryStep(query: '$userQuery', output: matchingCode),
      PromptQueryStep(
        prompt: '''Here are the related references from user's project:
            $matchingCode. 
            
            Answer the user's query. 
            Query: $userQuery.''',
        promptOutput: promptOutput,
      ),
      AppendToChatStep(value: '$promptOutput')
    ];
  }
}
