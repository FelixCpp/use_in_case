# Use-In-Case: Timeout Extension

This library is an extension on the [uic-interactor](../uic-interactor/) module. It provides a new modifier named `timeout`. This modifier limits the amount of time an interactor is allowed to run.

## Before diving into the Code

I recommended reading and understanding [this](../uic-interactor/README.md) README before using this extension. It provides a lot more information about how to write interactors as well as extensions.

## Getting started

Assuming you've understood the basic functionality of the [uic-interactor](../uic-interactor/) module we can now start depending on this module.

```Yaml
dependencies:
  uic_interactor:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor-timeout
```

## Code-example

Here's a quick and easy to understand example.</br>
For this example i've implemented an interactor that literally does nothing except waiting three seconds before returning.

```Dart
class Wait3SecondsInteractor implements Interactor {
    @override
    Future<void> execute(Nothing _) {
        return Future.delayed(const Duration(seconds: 3));
    }
}
```

Using this interactor in addition to the new `timeout` modifier may look like this:

```Dart
final interactor = Wait3SecondsInteractor();
interactor(nothing)
    .timeout(const Duration(seconds: 1))
    .configure((event) {
        event.whenOrNull(
            onSuccess: (_) { print('Succeeded'); }
            onFailure: (exception) { print('Failed: $exception'); }
        );
    })
    .run();
```

This example will fail due to the time limit provided inside the `timeout` modifier. Therefor the `onFailure` is called which prints the timeout exception.

## Additional information

Due to the implementation of this library it doesn't matter how many timeout modifiers you add to the call. The modifier with the least amount of duration "wins".

If you want to learn more about the package you may want to take a look into the [tests](./test/timeout_test.dart) or [examples](./example/uic_interactor_timeout_example.dart).
