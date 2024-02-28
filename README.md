# Use-In-Case: Overview

A library that provides a **simple** API to write **highly customizable** usecases.

## Main Module

This library consists out of three submodules where [uic-interactor](packages/uic-interactor) is the base module for each extension.

## Submodules and Extensions

| Module                                        | Functionality                                                               |
| :-------------------------------------------- | :-------------------------------------------------------------------------- |
| [uic-interactor](packages/uic-common/)        | Base module providing shared classes & functionality for both submodules.   |
| [uic-interactor](packages/uic-interactor/)    | Base module for interactors implementing the base functionality to extend.  |
| [uic-observer](packages/uic-observer/)        | Module providing a base class for observers.                                |

---

## Implementing a full example

The following example is a combination of all default extensions provided by the library. For more details on how each component works, it's worth taking a look into each extension module listed above.

### Logging-Profiler extension

I'm going to start with a logging profiler which profiles the duration of an interactor and prints them to the console. For some pretty output i'm using the [logger](https://pub.dev/packages/logger) package by [Simon Choi](https://github.com/simc).

```Dart
class LoggingProfilerExtension<Input, Output> extends ForwardingInvocationModifier<Input, Output> {
  final Logger _logger;
  final Stopwatch _watch;

  LoggingProfilerExtension({
    required super.modifier,
    required Logger logger,
  })  : _logger = logger,
        _watch = Stopwatch();

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      final name = details.jobName;

      final _ = event.when(
        onStart: (input) {
          _watch
            ..reset()
            ..start();

          _logger.i('$name started executing with $input as parameter.');
        },
        onSuccess: (output) {
          final elapsedTime = (_watch..stop()).elapsed;
          _logger.i(
            '$name succeeded after $elapsedTime with $output as result.',
          );
        },
        onFailure: (exception) {
          final elapsedTime = (_watch..stop()).elapsed;
          _logger.e('$name failed after $elapsedTime due to $exception');
        },
      );

      return callback(event, details);
    });
  }
}
```

### Logging-Profiler extension builder

Each extension needs a builder in order to get registered inside the call chain.

```Dart
class LoggingProfilerExtensionBuilder<Input, Output> implements InvocationModifierBuilder<Input, Output> {
  final Logger _logger;

  const LoggingProfilerExtensionBuilder({
    required Logger logger,
  }) : _logger = logger;

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return LoggingProfilerExtension(modifier: modifier, logger: _logger);
  }
}
```

### Logging-Profiler convenience modifier

Now let's write an extension that can be used when invoking an interactor.
This is for convenience only. We could also write `.modifier(const LoggingProfilerExtensionBuilder())` instead. This extension allows us to write `.logger()` instead.

```Dart
extension LoggingProfilerModifierExtension<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> logger({
    Logger? logger,
  }) {
    return modifier(
      LoggingProfilerExtensionBuilder(
        logger: logger ?? Logger(),
      ),
    );
  }
}
```

### Calculator interactor example

Now let's write an interactor.

```Dart
class Calculator extends ResultInteractor<int> {
  const Calculator();

  @override
  Future<int> execute(Nothing _) async {
    return 6 * 7;
  }

  @override
  List<InvocationModifierBuilder<Nothing, int>> get modifierBuilders {
    return [
      const TimeoutExtensionBuilder(Duration(minutes: 3)),
    ];
  }
}
```

### Calculator invocation example

Invoking this interactor may look like this:

```Dart
const calculator = Calculator();

final result = await calculator(nothing)
    .logger()
    .receiveBusyStateChange((isBusy) => print('IsBusy: $isBusy'))
    .getOrElse(fallback: -1);

print('Result: $result');
```

| Library / Modifier                              | Customized  |
| :---------------------------------------------- | :---------- |
| [Interactor Module](./packages/uic-interactor/) | No          |
| [Observer Module](./packages/uic-observer/)     | No          |
| [Profiler Logger](#logging-profiler-extension)  | Yes         |
