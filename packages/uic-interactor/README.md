# Package uic-interactor

This library provides the base class **ParameterizedResultInteractor** as well as functions to invoke the operation implemented by the interactor.

## Getting started

Before writing your first interactor, it is required to add this package to your dependencies.

```yaml
dependencies:
  uic_interactor:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-interactor
```

## Usage

### Implementing an Interactor

Using this package allows you to implement your own interactor. The interface **ParameterizedResultInteractor** requires you to implement the <u>*execute*</u> method. The parameter as well as the return type can be modified by specifying different generic types for the base class.

```dart
class DivideByTwoInteractor implements ParameterizedResultInteractor<int, int> {
  const DivideByTwoInteractor();

  @override
  Future<int> execute(int input) async {
    return input ~/ 2;
  }
}
```

Another example can be seen here. In this case we receive a String that is written to a *.txt* file called "example_file". Additionally we do not return anything from it.

```dart
class SaveToFileInteractor implements ParameterizedResultInteractor<String, void> {
  const SaveToFileInteractor();

  @override
  Future<void> execute(String content) async {
    final file = File('example_file.txt');
    await file.writeAsString(content);
  }
}
```

### Invoking an Interactor

To use these classes we can execute them using a method called "get". If there are any exception that we want to handle with fallback values, there are convenience methods defined called "getOrNull" as well as "getOrElse"

```dart
const value = 502;
const divideByTwo = DivideByTwoInteractor();
final result1 = await divideByTwo(value).get(); // returns value but throws exception on failure
final result2 = await divideByTwo(value).getOrNull(); // returns value or null instead of throwing
final result3 = await divideByTwo(value).getOrElse(fallback: -1); // returns value or fallback instead of throwing 

print({result1, result2, result3});
```

To get full control of the flow, you can provide callbacks for invocation events using the following code:

```dart
const saveToFile = SaveToFileInteractor();
saveToFile("502 / 2 = 251").configure((event) {
  event.whenOrNull(
    onStart: (input) {
      print('Saving process started.');
    },
    onSuccess: (result) {
      print('Content has been saved successfully.');
    },
    onFailure: (exception) {
      print('Could not save content to file. Exception: $exception');
    },
  );
}).run(); //< Don't forget to call run at the end!
```

### Implementing an Extension

Since this library is heavily based on extensions and external modifiers, it is possible to register custom extensions into the invocation flow.
First thing that's required is to extend an base class called `ForwardInvocationModifier`.
Here's an example on how to do that:

```Dart
class CustomExtension<Input, Output> extends ForwardingInvocationModifier<Input, Output> {
  final String name;
  const CustomExtension({
    required super.modifier,
    required this.name,
  });

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      print('$name: $event');
      callback(event, details);
    });
  }
}
```

This extension prints it's name and the event that has been published by the underlying invocation flow. Running the callback is essential to the behavior of this method chaining algorithm. A details example on how to handle the callback can found [here](https://github.com/FelixCpp/use_in_case/blob/main/packages/uic-interactor-profiler/lib/src/modifiers/profiler_modifier.dart).

Extensions can also control the invocation flow by overriding the `buildStream` method. The following example shows how to modify the invocation flow by skipping the first event (`onStart`):

```Dart
class SkipExtension<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  const SkipExtension({required super.modifier});

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return modifier.buildStream().skip(1);
  }
}
```

A more detailed example can be seen [here](https://github.com/FelixCpp/use_in_case/blob/main/packages/uic-interactor-timeout/lib/src/modifiers/timeout_modifier.dart).

### Registering an Extension

In order to register an Extension, a builder is required. The implementation of a builder must implement the `InvocationModifierBuilder` interface. To get you started i've written an example below. A detailed example can be seen [here](https://github.com/FelixCpp/use_in_case/blob/main/packages/uic-interactor-timeout/lib/src/modifiers/timeout_modifier_builder.dart).

```Dart
class SkipExtensionBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  const SkipExtensionBuilder();

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return SkipExtension(modifier: modifier);
  }
}
```

Extensions can be registered using the `apply` method.

```Dart
final _ = await interactor(nothing)
  .modifier(const SkipExtensionBuilder())
  .modifier(const CustomExtensionBuilder(name: 'Hello'))
  .get();
```

### Pre-Registered modifier

Each implementation of an Interactor can override the `modifierBuilders` getter property. This property automatically registeres the returned list of builders on invocation. To wrap things up i've written a full example below.

```Dart
/// Extension/Modifier
class PrintExtension<Input, Output> extends ForwardingInvocationModifier<Input, Output> {
  final String name;

  const PrintExtension({
    required super.modifier,
    required this.name,
  });

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler((event, details) {
      print(name);
      callback(event, details);
    });
  }
}

/// Extension/Modifier Builder
class PrintExtensionBuilder<Input, Output> implements InvocationModifierBuilder<Input, Output> {
  final String name;
  const PrintExtensionBuilder(this.name);

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return PrintExtension(modifier: modifier, name: name);
  }
}

/// Interactor
class MyInteractor extends Interactor {
  const MyInteractor();

  @override
  Future<void> execute(Nothing input) async {}

  @override
  List<InvocationModifierBuilder<Nothing, void>> get modifierBuilders => [
        PrintExtensionBuilder('Test 1'),
        PrintExtensionBuilder('Test 2'),
      ];
}

void main() {
  const interactor = MyInteractor();
  final _ = await interactor(nothing).get();
}
```

## Additional information

When you take a closer look into the implementation of this module, you will see that basically everything is an extension. I've designed it to be extensible for basically every feature that you'd like to implement. The Timeout extension is a good example on how to do that. Basically an implementation of *InvocationModifier* is needed in order to get information about the execution flow.
