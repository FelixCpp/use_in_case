# Use-In-Case: Interactor

This package provides extendable functionality to execute interactors (usecases) with additional modifiers that change its behavior.

## Why would I need this library?

Using this library allows you to write your own interactors/usecases and configure them individually to fit your needs. It's heavily written to be extendable. This means you can write your own extensions and customizations that control the invocation flow of each interactor.

## What does this library provide?

The API gives you the base class for all interactors/usecases named `ParameterizedResultInteractor`. This class takes in two generic type parameters `Input` and `Output`. An example implementation of an interactor can be seen [here](#Getting-started).

## Getting started

Before writing your interactors/usecases you need to depend on this library.

```Yaml
dependencies:
  uic_interactor:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor
```

## Writing interactors/usecases

There are four different types of interactors.

| Type                          | Parameterzed  | Produces Output  |
| :---------------------------- | ------------: | ---------------: |
| Interactor                    | No            | No               |
| ResultInteractor              | No            | Yes              |
| ParameterizedInteractor       | Yes           | No               |
| ParameterizedResultInteractor | Yes           | Yes              |

### Implementation of an Interactor

```Dart
class PrintInteractor extends Interactor {
    @override
    Future<void> execute(Nothing _) async {
        print('Hello World');
    }
}
```

### Implementation of a ResultInteractor

```Dart
class StringProducerInteractor extends ResultInteractor<String> {
    @override
    Future<String> execute(Nothing _) async {
        return 'Hello World';
    }
}
```

### Implementation of a ParameterizedInteractor

```Dart
class StringPrinterInteractor extends ParameterizedInteractor<String> {
    @override
    Future<void> execute(String input) async {
        print(input);
    }
}
```

### Implementation of a ParameterizedResultInteractor

```Dart
class GreetingProducerInteractor extends ParameterizedResultInteractor<String, String> {
    @override
    Future<void> execute(String name) async {
        return 'Hello $input!';
    }
}
```

## Running an interactor

To run an interactor there are a couple of methods you can call. Each method either handles exceptions thrown inside the `execute` method or not.

| Method            | Handles Error | Behavior          |
| :---------------- | :------------ | :---------------- |
| get               | No            | Throws            |
| getOrNull         | Yes           | Returns null      |
| getOrElse         | Yes           | Returns fallback  |
| configure (+ run) | Yes           | Invokes callback  |

### Invoking an interactor using `get`

```Dart
/// Would throw if `execute` throws an exception.
final interactor = StringProducerInteractor();
final message = await interactor(nothing).get();
print(message); // Prints 'Hello World'
```

### Invoking an interactor using `getOrNull`

```Dart
/// Would return null if `execute` throws an exception.

final interactor = StringProducerInteractor();
final message = await interactor(nothing).getOrNull();
print(message); // Prints 'Hello World'
```

### Invoking an interactor using `getOrElse`

```Dart
/// Would return 'Error' if `execute` throws an exception.

final interactor = GreetingProducerInteractor();
final message = await interactor('Felix').getOrElse(fallback: 'Error');
print(message); // Prints 'Hello, Felix!'
```

### Invoking an interactor using `configure (+ run)`

```Dart
/// Would invoke onFailure if `execute` throws an exception.

final interactor = StringProducerInteractor();

interactor(nothing).configure(
    (event) {
        event.when(
            onStart: (input) {},
            onSuccess: (message) { print(message); },
            onFailure: (exception) { print(exception.toString()); }
        );
    }
).run(); //< Don't forget the `.run()`!
```
