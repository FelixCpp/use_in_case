## Package uic-interactor-profiler

This module provides an extension into the workflow of an interactor. The extension measures the elapsed it tool for the usecase to finish and provides callbacks that are invoked when certain events are triggered.

## Getting started

In order to use this library you must add it to the dependency in your pubspec.yaml file.

```yaml
dependencies:
  uic_interactor_profiler:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor-profiler
```

## Usage

Since this module only provides an extension, the usage is basically the same in reference to the [uic-interactor](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor) module. Using this dependency enables a new method called "profiler" which can be inserted into the call-hiarchy.

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

Now we can simply add the *profiler* call anywhere in our invocation call.

```dart
const logger = TestLogger();
const heavyMath = ReturnPiAfterDelayInteractor();

final result = await heavyMath(Duration(milliseconds: 750))
  .timeout(Duration(milliseconds: 100))
  .profiler(logger)
  .getOrNull();

print("Result: $result");
```

The last step is to implement the `TestLogger` class. Here's probably the simplest profiler you'd wanna write.
To do that simply inherit from the `InteractorEventProfiler` and implement the required methods.

## Additional information

When you take a closer look into the implementation of this module, you will see that basically everything is an extension. I've designed it to be extensible for basically every feature that you'd like to implement. The Timeout extension is a good example on how to do that. Basically an implementation of *InvocationModifier*  is needed in order to get information about the execution flow.
