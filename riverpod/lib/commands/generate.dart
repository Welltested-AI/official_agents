import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/steps/steps.dart';
import 'package:dash_agent/variables/dash_input.dart';
import 'package:dash_agent/variables/dash_output.dart';

class GenerateCommand extends Command {
  GenerateCommand(this.exampleDataSource, this.providerDatasource);
  final DataSource exampleDataSource;
  final DataSource providerDatasource;
  final generateInstructions = StringInput('Generate Instructions');
  final codeReference = CodeInput('Reference', optional: true);

  @override
  String get intent => 'Generate custom providers';

  @override
  List<DashInput> get registerInputs => [generateInstructions, codeReference];

  @override
  String get slug => '/generate';

  @override
  List<Step> get steps {
    final providerChoiceOutput = PromptOutput();
    final suitableProvidersOutput = MatchDocumentOuput();
    final resultOutput = PromptOutput();
    return [
      PromptQueryStep(
          prompt:
              '''Here are what the different kinds of available riverpod providers:
              
              ## Provider	
              - Returns any type	
              - A service class / computed property (filtered list)
              - typically used for:
                caching computations
                exposing a value to other providers (such as a Repository/HttpClient).
                offering a way for tests or widgets to override a value.
                reducing rebuilds of providers/widgets without having to use select.

              ## StateProvider	
              - Returns any type	
              - A filter condition / simple state object
              - StateProvider exists primarily to allow the modification of simple variables by the User Interface.
              The state of a StateProvider is typically one of:

              an enum, such as a filter type
              a String, typically the raw content of a text field
              a boolean, for checkboxes
              a number, for pagination or age form fields
              You should not use StateProvider if:

              your state needs validation logic
              your state is a complex object (such as a custom class, a list/map, ...)
              the logic for modifying your state is more advanced than a simple count++.
              For more advanced cases, consider using NotifierProvider instead and create a Notifier class.
              While the initial boilerplate will be a bit larger, having a custom Notifier class is critical for the long-term maintainability of your project as it centralizes the business logic of your state in a single place.

              ## FutureProvider	
              - Returns a Future of any type	
              - A result from an API call
              - FutureProvider is the equivalent of Provider but for asynchronous code.

              FutureProvider is typically used for:

                performing and caching asynchronous operations (such as network requests)
                nicely handling error/loading states of asynchronous operations
                combining multiple asynchronous values into another value
              FutureProvider gains a lot when combined with ref.watch. This combination allows automatic re-fetching of some data when some variables change, ensuring that we always have the most up-to-date value.

              ## StreamProvider	
              - Returns a Stream of any type	
              - A stream of results from an API
              - StreamProvider is similar to FutureProvider but for Streams instead of Futures.

              StreamProvider is usually used for:

                listening to Firebase or web-sockets
                rebuilding another provider every few seconds
                Since Streams naturally expose a way for listening to updates, some may think that using StreamProvider has a low value. In particular, you may believe that Flutter's StreamBuilder would work just as well for listening to a Stream, but this is a mistake.

              Using StreamProvider over StreamBuilder has numerous benefits:

                it allows other providers to listen to the stream using ref.watch.
                it ensures that loading and error cases are properly handled, thanks to AsyncValue.
                it removes the need for having to differentiate broadcast streams vs normal streams.
                it caches the latest value emitted by the stream, ensuring that if a listener is added after an event is emitted, the listener will still have immediate access to the most up-to-date event.
                it allows easily mocking the stream during tests by overriding the StreamProvider.

              ## NotifierProvider	(recommended choice for complex and scalable cases.)
              - Returns a subclass of (Async)Notifier	
              - A complex state object that is immutable except through an interface
              - NotifierProvider is a provider that is used to listen to and expose a Notifier.
              AsyncNotifierProvider is a provider that is used to listen to and expose an AsyncNotifier. AsyncNotifier is a Notifier that can be asynchronously initialized.
              (Async)NotifierProvider along with (Async)Notifier is Riverpod's recommended solution for managing state which may change in reaction to a user interaction.

              It is typically used for:

                exposing a state which can change over time after reacting to custom events.
                centralizing the logic for modifying some state (aka "business logic") in a single place, improving maintainability over time.


              From the above choices, while provider(s) do you think are the best fit for user's usecase to generate $generateInstructions $codeReference.

              Simply provide the name of the provider(s) and reason they are the right fit.
              ''',
          promptOutput: providerChoiceOutput),
      MatchDocumentStep(
          query:
              'examples/instructions of writing code for a riverpod provider $providerChoiceOutput for $generateInstructions $codeReference.',
          dataSources: [exampleDataSource, providerDatasource],
          output: suitableProvidersOutput),
      PromptQueryStep(
          prompt:
              '''You're a Flutter/Dart coding assistant helping user with using riverpod in their code. Here are their instructions: $generateInstructions along with the code reference:
          $codeReference
          
          We think the below choice of the correct provider and reasoning for it,
          $providerChoiceOutput
          
          Documentation or examples of the above provider choice for your reference:
          $suitableProvidersOutput
          
          Generate the complete code as per user's instruction.
          ''',
          promptOutput: resultOutput),
      AppendToChatStep(value: '$resultOutput')
    ];
  }

  @override
  String get textFieldLayout =>
      'Generate the riverpod provider code for $generateInstructions $codeReference';
}
