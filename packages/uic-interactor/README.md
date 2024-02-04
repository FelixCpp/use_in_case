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
  onStart: (input) {},
  onSuccess: (message) { print(message); },
  onFailure: (exception) { print(exception.toString()); },
  run: true,
);
```

## Advanced Topics

Since this module is written to be extendable there is a simple api to add an extension that hooks itself into the invocation flow and potentially modifies the behavior & outcome of an interactor.

### Writing a custom extension

```Dart
class CustomExtension<In, Out> extends ForwardingInvocationModifier<In, Out> {
    const CustomExtension({required super.modifier});

    @override
    InvocationEventHandler<In, Out> buildEventHandler(
        InvocationEventHandler<In, Out> callback,
    ) {
        return modifier.buildEventHandler((event, details) {
            callback(event, details);
        });
    }
}
```

In order to register the extension in our call chain we must define an extension builder.

### Writing a custom extension builder

```Dart
class CustomExtensionBuilder<In, Out> implements InvocationModifierBuilder<In, Out> {
    const CustomExtensionBuilder();

    @override
    InvocationModifier<In, Out> build(
        InvocationModifier<In, Out> modifier,
    ) {
        return CustomExtension(modifier: modifier);
    }
}
```

Now we're finally ready to register our extension builder into the call chain.

```Dart
final interactor = GreetingProducerInteractor();
final message = await interactor('Felix')
    .modifier(const CustomExtensionBuilder()) //< Registration
    .get();

print(message);
```

### Using pre-registered extensions

Each interactor is able to overwrite the `modifierBuilders` property. This getter must return a list of [modifier builders](#Writing%20a%20custom%20extension%20builder). Each one is going to be registered and automatically applied when invoking the interactor.

Let's write an extension for our showcase.

```Dart
class PrintExtension<In, Out> extends ForwardingInvocationModifier<In, Out> {
    const PrintExtension({required super.modifier});
    
    @override
    InvocationEventHandler<In, Out> buildEventHandler(
        InvocationEventHandler<In, Out> callback,
    ) {
        return modifier.buildEventHandler((event, details) {
            final message = event.when(
                onStart: (input) => 'Invocation started',
                onSuccess: (output) => output,
                onFailure: (exception) => exception.toString(),
            );

            print(message);
            callback(event, details);
        });
    }
}
```

As you should know by now, each extension needs a corresponding builder.

```Dart
class PrintExtensionBuilder<In, Out> implements InvocationModifierBuilder<In, Out> {
    const PrintExtensionBuilder();

    @override
    InvocationModifier<In, Out> build(
        InvocationModifier<In, Out> modifier,
    ) {
        return CustomExtension(modifier: modifier);
    }
}
```

For this example i've decided to extend the [StringProducerInteractor](#implementation-of-a-resultinteractor)

```Dart
class StringProducerInteractor extends ResultInteractor<String> {
    @override
    Future<String> execute(Nothing _) async {
        return 'Hello World';
    }

    @override
    List<InvocationModifierBuilder<Nothing, String>> get modifierBuilders {
        return [
            const PrintExtensionBuilder<Nothing, String>(),
        ];
    }
}
```

When invoking the `StringProducerInteractor`, each event is being printed automatically without writing `.modifier(const PrintExtensionBuilder())` on each invocation.

```Dart
final interactor = StringProducerInteractor();
final message = await interactor(nothing).get();
print(message); 
```

## More on extensions

If you're interested and want to take a closer look on how to implement extensions you can find examples inside the [uic-interactor-timeout](../uic-interactor-timeout) or [uic-interactor-busy-state](../uic-interactor-busy-state) module.
Besides these submodules you can always take a look into the [examples](./example/) folder. Specifically [this file](example/uic_interactor_modifier_example.dart) revisits the previous steps on how to register a custom extension.

## Contribution

I'm sure there are many things that could be added using extensions and modification of invocation flows. If you find yourself implementing a feature that needs to should be part of the base library i'd love to review your **merge request** or discuss the feature inside **issue** tab.
