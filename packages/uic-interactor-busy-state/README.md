# Use-In-Case: Busy-State Extension

It provides the ability to receive the current state of an interactor about whether he's currently working or not. This ability might be useful to show a loading indicator in flutter or track how long it takes to finish a specific task.

This packages is implemented as an extension for the [uic-interactor](../uic-interactor) package.

## Before diving into the Code

I recommended reading and understanding [this](../uic-interactor/README.md) README before using this extension. It provides a lot more information about how to write interactors as well as extensions.

## Getting started

Assuming you've understood the basic functionality of the [uic-interactor](../uic-interactor/) module we can now start depending on this module.

```Yaml
dependencies:
  uic_interactor:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor-busy-state
```

## Code examples

This extension provides two modifiers. Both of them notify the current state (working/not working) to you.

| Modifier                  | Parameter | Parameter type        |
| :------------------------ | :-------- | :-------------------- |
| receiveBusyStateChange    | callback  | void Function(bool)   |
| listenOnBusyState         | listener  | BusyStateListener     |

### Using the `receiveBusyStateChange` method

This method takes a callback as parameter that is directly hooked into the invocation flow of your interactor. Every time the interactor is invoked it produces *true*. When the interactor has finished its task, it produces *false*. This method should be your choice if your loading indicator depends on a single interactor.

For this example i've written a simple interactor that waits three seconds before returning.

```Dart
class Wait3SecondsInteractor implements Interactor {
    @override
    Future<void> execute(Nothing _) {
        return Future.delayed(const Duration(seconds: 3));
    }
}
```

We can now add our modifier to the call:

```Dart
final interactor = Wait3SecondsInteractor();
await interactor(nothing).receiveBusyStateChange((isBusy) {
    final message = 'Interactor ${isBusy ? 'started' : 'finished'}';
    print(message);
}).get();
```

### Using the `listenOnBusyState` method

This method takes in an implementation of `BusyStateListener`. There are already two implementations provided by the library.

| Type                          | Usage                                     |
| :---------------------------- | :---------------------------------------- |
| BusyStateConsumingListener    | When tracking **one** interactor          |
| BusyStateBufferingListener    | When tracking **multiple** interactors    |

---

### Rule of thumb

Use the `BusyStateBufferingListener` in case you need to track if any interactor is working. Otherwise use the `BusyStateConsumingListener` implementation.

---

### Example using `BusyStateConsumingListener`

```Dart
final interactor = ...
final listener = BusyStateConsumingListener();

// Listen on changes
final subscription = listener.isLoading.listen((isBusy) {
    // State changed.
});

await interactor(...).listenOnBusyState(listener).get();

// Cleanup
await subscription.cancel();
await listener.release();

```

### Example using `BusyStateBufferingListener`

```Dart
final interactors = { ... };
final listener = BusyStateBufferingListener();

// Listen on changes
final subscription = listener.isLoading.listen((isBusy) {
    // State changed.
});

for (final interactor in interactors) {
    interactor(...)
        .listenOnBusyState(listener)
        .configure(...)
        .run();
}

...

// Cleanup
await subscription.cancel();
await listener.release();

```

More examples can be found [here](./example/uic_interactor_busy_state_example.dart).

## Additional information

When using the listener it's required to cleanup the resources such as subscription and stream by yourself. This will most likely change in future.

If you've registered your own callback using the configure ([read this](../uic-interactor/README.md)) method, the isBusy-callback will always be invoked surrounding your callback (before onStart, after onSuccess/onFailure). This means that it will publish false when your callback has finished it's task too.
