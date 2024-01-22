## Package uic-interactor-timeout

This module allows you to add a time limit for interactors. If the usecase takes too long, a TimeoutException is thrown resulting in a call to onFailure.

## Getting started

In order to use this library you must add it to the dependency in your pubspec.yaml file.

```yaml
dependencies:
  uic_interactor_timeout:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor-timeout
```

## Usage

Since this module only provides an extension, the usage is basically the same in reference to the [uic-interactor](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor) module. Using this dependency enables a new method called "timeout" which can be inserted into the call-hiarchy.

To demonstrate the usage of this module we assume you have implemented something heavy we want to profile. For this example I've implemented an interactor that takes a given amount of time and returns pi when the time elapsed.

```dart
class ReturnPiAfterDelayInteractor implements ParameterizedResultInteractor<Duration, double> {
  const ReturnPiAfterDelayInteractor();

  @override
  Future<double> execute(Duration delay) {
    return Future.delayed(delay, () => math.pi);
  }
}
```

Now we can simply add the *timeout* call anywhere in our invocation call.

```dart
const heavyMath = ReturnPiAfterDelayInteractor();

final result = await heavyMath(Duration(milliseconds: 750))
  .timeout(Duration(milliseconds: 100))
  .getOrNull(); //< returns null due to TimeoutException

print("Result: $result"); // "Result: null"
```

## Additional information

Be careful when adding multiple timeout modifiers in one invocation (see example below). Since the internals of this library does not use lists
of modifiers but stores them as a call-chain it won't timeout after the last given amount of milliseconds (150). Instead it will raise a TimeoutException when the action takes longer than the lowest value provided (100 in this case).

```dart
const heavyMath = ReturnPiAfterDelayInteractor();

final result = await heavyMath(Duration(milliseconds: 750))
  .timeout(Duration(milliseconds: 100))
  .timeout(Duration(milliseconds: 130))
  .timeout(Duration(milliseconds: 150))
  .getOrNull(); //< returns null due to TimeoutException

print("Result: $result"); // "Result: null"
```
