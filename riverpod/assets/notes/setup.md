### Why use Riverpod?

*   **Limitations of Provider**:
    *   Reliance on the widget tree can lead to `ProviderNotFoundException`.
    *   Logic often intertwined within widgets, hindering testability and maintainability. 
*   **Advantages of Riverpod**:
    *   **Compile-time safety**: Providers declared globally, accessible anywhere, preventing runtime errors.
    *   **Improved State Management**: Separation of state and logic from UI improves code organization.
    *   **Reactive**: Only rebuilds what's necessary, optimizing performance.
    *   **Testability**: Providers can be easily mocked and overridden in tests.

### Installation and Setup

1.  Add `flutter_riverpod` dependency to `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^2.3.6 
```

2.  Wrap your root widget with `ProviderScope`:

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

*   `ProviderScope` stores the state of all providers and creates a `ProviderContainer`.

### Core Concepts

*   **Provider**: An object encapsulating a piece of state and enabling listening to its changes. 
*   **Creating a Provider**:

```dart
final helloWorldProvider = Provider((ref) => 'Hello world');
```

*   **Reading a Provider**:

**1. Using `ConsumerWidget`**:

```dart
class HelloWorldWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld); 
  }
}
```

**2. Using `Consumer`**:

```dart
class HelloWorldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final helloWorld = ref.watch(helloWorldProvider);
        return Text(helloWorld);
      },
    );
  }
}
```

**3. Using `ConsumerStatefulWidget` & `ConsumerState`**:

```dart
class HelloWorldWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<HelloWorldWidget> createState() => _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends ConsumerState<HelloWorldWidget> {
  @override
  Widget build(BuildContext context) {
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld);
  }
} 
```

*   **WidgetRef**:  Provides access to any provider within the app. Similar to `BuildContext` but for providers. 
    *   Available as an argument in `Consumer` and `ConsumerWidget`.
    *   Available as a property in `ConsumerState`. 