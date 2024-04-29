## Part 3: Advanced Features and Applications - Riverpod

### 1. AutoDispose Modifier

*   **Purpose**: Automatically dispose of providers (especially `FutureProvider` and `StreamProvider`) when they are no longer used, preventing memory leaks and unnecessary resource consumption.
*   **Implementation**:

```dart
final authStateChangesProvider = StreamProvider.autoDispose((ref) {
  // ...
});
```

*   **Additional functionalities**:
    *   `ref.onDispose()`: Perform custom cleanup logic when the provider is disposed. 
    *   `ref.keepAlive()`: Prevent the provider from being disposed even if no listeners are present.
    *   `KeepAliveLink` & Timeout-based caching: Dispose the state after a specified duration.

```dart
final link = ref.keepAlive();
final timer = Timer(const Duration(seconds: 30), () => link.close());
ref.onDispose(() => timer.cancel());
```

### 2. Family Modifier

*   **Purpose**: Create parameterized providers that accept arguments, allowing for more dynamic and flexible state management.
*   **Implementation**:

```dart
final movieProvider = FutureProvider.family<Movie, int>((ref, movieId) {
  // ...
});

// Usage
final movieAsync = ref.watch(movieProvider(550));
```

*   **Limitations**: 
    *   Directly passing multiple parameters is not supported.
    *   Workarounds:
        *   Pass a custom object that implements `hashCode` and the equality operator.
        *   Use the `riverpod_generator` package for more extensive parameter support. 

### 3. Dependency Overrides

*   **Purpose**: Dynamically replace the behavior of a provider with a different implementation, often used for testing or handling situations where a dependency is not immediately available. 
*   **Implementation**:

```dart
final sharedPreferencesProvider = Provider((ref) => throw UnimplementedError());

// Override
runApp(ProviderScope(
  overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ],
  child: MyApp(),
));
```

### 4. Combining Providers

*   **Purpose**: Create providers that depend on other providers, allowing for modularity and code reuse.
*   **Approaches**:
    *   **Explicit Dependency**: Watch the required provider within the dependent provider using `ref.watch`.

```dart
final settingsRepositoryProvider = Provider((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsRepository(sharedPreferences);
});
```

    *   **Passing `Ref` as an argument**: Access the required provider implicitly using `ref.read` within the dependent object's methods.

```dart
class SettingsRepository {
  const SettingsRepository(this.ref);
  final Ref ref;

  // ...
}

final settingsRepositoryProvider = Provider((ref) => SettingsRepository(ref));
```

### 5. Scoping Providers

*   **Purpose**: Limit the scope of a provider to a specific part of the application, improving performance and preventing unnecessary rebuilds.
*   **Implementation**: Use a nested `ProviderScope` with overrides to provide a different value for the provider within a specific subtree.

```dart
final currentProductIndex = Provider((ref) => throw UnimplementedError());

// Usage
ListView.builder(
  itemBuilder: (context, index) => ProviderScope(
    overrides: [currentProductIndex.overrideWithValue(index)],
    child: const ProductItem(),
  ),
);
```

### 6. Filtering Widget Rebuilds with `select`

*   **Purpose**: Optimize widget rebuilds by only listening to specific properties of a complex object within a provider.
*   **Implementation**: Use the `select` method to specify a function that extracts the relevant property. 

```dart
class BytesReceivedText extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bytesReceived = ref.watch(
      connectionProvider.select((connection) => connection.state.bytesReceived),
    );
    // ...
  }
}
```

### 7. Testing with Riverpod

*   **Benefits**:
    *   Isolated state: Each test has its own `ProviderScope`, preventing state sharing between tests and eliminating the need for setup/teardown.
    *   Easy mocking: Dependency overrides allow for replacing real implementations with mocks during tests.
*   **Example**:

```dart
testWidgets('Override moviesRepositoryProvider', (tester) async {
  await tester.pumpWidget(ProviderScope(
    overrides: [
      moviesRepositoryProvider.overrideWithValue(MockMoviesRepository())
    ],
    child: MoviesApp(),
  ));
  // ...
});
```

### 8. Logging with `ProviderObserver`

*   **Purpose**: Monitor state changes and debug applications by observing provider updates.
*   **Implementation**: Subclass `ProviderObserver` and override the `didUpdateProvider` method.

```dart
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('[${provider.name ?? provider.runtimeType}] value: $newValue');
  } 
}

// Usage
runApp(ProviderScope(observers: [Logger()], child: MyApp()));
``` 

### 9. App Architecture with Riverpod 

*   **Importance**: Choosing a suitable architecture is crucial for managing complexity and maintainability in large applications.
*   **Recommendation**: The author proposes a four-layer architecture (data, domain, application, presentation) for building robust Riverpod applications. 