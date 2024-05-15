## Use-In-Case Interactor Library

This package contains the implementation required to add interactors to your project.

### Dependency management

Here's a simple example on how to add a [git](https://git-scm.com/) dependency.
Read more about [dart packages](https://dart.dev/tools/pub/dependencies)

### Simple Usage

You can read about the usage in many examples inside the [examples](example/) folder. Here's a quick example on how to get started:

```dart
import 'package:use_in_case/use_in_case.dart';

final class Square extends PRInteractor<double, double> {
  const Square();

  @override
  Future<double> execute(double parameter) async {
    return parameter * parameter;
  }
}

void main() async {
  const square = Square();
  final result = await square(11).get();
  print(result);
}
```

This example shows an example implementation of a [ParameterizedResultInteractor / PRInteractor](lib/src/interactor.dart). The first generic type returns the parameter of *execute*, the second defines the result/return type.

### Modifiers usage

This library provides the ability to add highly customizable modifiers. There are some pre-defined modifiers such as [timeout](lib/src/modifiers/timeout_modifier.dart) or [busy state](lib/src/modifiers/busy_state_modifier.dart). More information on these modifiers can be read in their corresponding examples.

```dart
// ...

void main() async {
  const square = Square();
  final result = await square(11)
      .timeout(
        const Duration(seconds: 5),
        'Timeout because the computation took longer than 5 seconds.',
      )
      .receiveBusyState(
        (isBusy) => print('${isBusy ? 'start' : 'stop'} at ${DateTime.now()}'),
      )
      .get();

  print(result);
}
```

### Writing custom modifiers

Due to the limitations of my few implementations of modifiers provided by the library, i've designed the API publically extendable. For more details you may want to take a look into the implemenation of [timeout](lib/src/modifiers/timeout_modifier.dart) or [busy state](lib/src/modifiers/busy_state_modifier.dart) modifiers.

You can write your own modifier as follows:

```dart
final class CustomModifier<Parameter, Result>
    extends ChainedModifier<Parameter, Result> {
  const CustomModifier(super._modifier);

  @override
  EventHandler<Parameter, Result> buildEventHandler() {
    return super.buildEventHandler().after((details, event) {
      event.whenOrNull(
        onStart: (parameter) {
          print('${details.calleName} started with $parameter -->');
        },
        onResult: (result) =>
            print('<-- ${details.calleName} succeeded with $result'),
        onException: (exception) =>
            print('<-- ${details.calleName} failed with $exception'),
      );
    });
  }
}

// ...

void main() async {
    const interactor = // ...
    final result = await interactor()
        .modifier((modifier) => CustomModifier(modifier)).get();

    print(result);
}
```

**Note that this api will definitely change in future!**