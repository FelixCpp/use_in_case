# Package uic-interactor-busy-state-listener

This module provides methods that makes it easy to register callbacks which receive the busy-status (true, false) when the interactor has been invoked.

## Getting started

In order to use this library you must add it to the dependency in your pubspec.yaml file.

```yaml
dependencies:
  uic_interactor_timeout:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor-busy-state-listener
```

## Usage

Since this module only provides an extension, the usage is basically the same in reference to the [uic-interactor](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor) module. Using this dependency enables new methods called **listenOnBusyState** and **receiveBusyStateChange** which can be inserted into the call-hiarchy.

To demonstrate the usage of this module we assume you have implemented something heavy we want to profile. For this example I've implemented an interactor that takes a given amount of time and returns pi when the time elapsed.

```dart
class Return500AfterDelayInteractor extends ParameterizedResultInteractor<Duration, int> {
  const Return500AfterDelayInteractor();

  @override
  Future<int> execute(Duration delay) {
    return Future.delayed(delay, () => 500);
  }
}
```

Using the **listenOnBusyState** method can be used like this:

```dart
final listener = BusyStateConsumingListener();
const interactor = Return500AfterDelayInteractor();

final subscription = listener.isLoading.listen((isLoading) {
  print('Interactor is working: $isLoading');
});

final result = await interactor(Duration(milliseconds: 750))
    .listenOnBusyState(listener)
    .get();

await subscription.cancel();
await listener.release();

print('Computation result: $result');

///
/// ~ Function Output ~
/// Interactor is working: true
/// Interactor is working: false
/// Computation result: 500
///
```

The *receiveBusyStateChange* method can be used like demonstrated below. In order to make the call-hierarchy clear i've used the `configure(...).run` method.

```Dart
const interactor = Return500AfterDelayInteractor();
  final completer = Completer<int>();

  interactor(Duration(milliseconds: 750)).receiveBusyStateChange((isLoading) {
    print('Interactor is working $isLoading');
  }).configure((event) {
    event.whenOrNull(
      onStart: (input) {
        print('Started');
      },
      onSuccess: (data) {
        print('Succeeded');
        completer.complete(data);
      },
      onFailure: (exception) {
        print('Failure');
        completer.completeError(exception);
      },
    );
  }).run();

  await completer.future.then((result) {
    print('Computation result: $result');
  });

  ///
  /// ~ Function Output ~
  /// Interactor is working true
  /// Started
  /// Succeeded
  /// Interactor is working false
  /// Computation result: 500
  ///
```

## Additional information

Like every other extensions these methods can be registered multiple times. Just make sure to clean up the resources (Subscriptions & streams) like shown by the example. In future i want to automate this process but i'm not that far yet.
