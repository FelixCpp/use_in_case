
[![pub.dev version](https://img.shields.io/pub/v/use_in_case.svg)](https://pub.dev/packages/use_in_case)
[![pub points](https://img.shields.io/pub/points/use_in_case)](https://pub.dev/packages/use_in_case/score)
![Github Workflow](https://github.com/FelixCpp/use_in_case/actions/workflows/dart.yml/badge.svg)
[![Test coverage](https://codecov.io/github/FelixCpp/use_in_case/graph/badge.svg?token=KZHYCQGVC0)](https://codecov.io/github/FelixCpp/use_in_case)

---


# Use-In-Case (UIC) Interactor

This library declares a base interactor interface aswell as a corresponding progress-interactor class. In order to use them there are quiet a lot of modifiers that can be used to do actions inside the invocation-flow of an interactor.


## Interactor Types

| Type name                     | Parameterized | Resulting |
| ----------------------------- | ------------- | --------- |
| ParameterizedResultInteractor | Yes           | Yes       |
| ParameterizedInteractor       | Yes           | No        |
| ResultInteractor              | No            | Yes       |
| Interactor                    | No            | No        |

## Usage

How to call an interactor in your code:

```dart
// Define an interactor that does something. He must extend/implement a type mentioned above.
final class StringToIntConverter implements ParameterizedResultInteractor<String, int> {
    @override
    Future<int> runUnsafe(String input) async {
        return int.parse(input);
    }
}

/// ...

// Create an instance of the interactor
final converter = StringToIntConverter();

/// ...

Future<int>  _ = converter.getOrThrow("123"); // Outputs: 123
Future<int?> _ = converter.getOrNull("not-a-number"); // Outputs: null
Future<int>  _ = converter.getOrElse("word", (_) => -1); // Outputs: -1
Future<void> _ = converter.run("123"); // Outputs: Nothing (void)
Future<void> _ = converter.run("word"); // Doesn't throw & returns void
Future<void> _ = converter.runUnsafe("123"); // Outputs: Nothing (void)
Future<void> _ = converter.runUnsafe("word"); // Throws exception
```

| Method name  | Description                                                                                  |
| ------------ | -------------------------------------------------------------------------------------------- |
| `getOrThrow` | Calls the interactor and throws an exception if the interactor fails.                        |
| `getOrNull`  | Calls the interactor and returns `null` if the interactor fails.                             |
| `getOrElse`  | Calls the interactor and returns a fallback value if the interactor fails.                   |
| `run`        | Calls the interactor and ignores the result. Also this method does not throw.                |
| `runUnsafe`  | Calls the interactor and throws an exception in case of a failure. The return type is void.  |

## Customization

The core feature of uic-interactor is the ability to customize the invocation-flow of an interactor.
This can be achieved by chaining multiple decorators to the interactor.

In the end your invocation-flow might look like this:

```dart
final result = stringToIntConverter
    .timeout(const Duration(seconds: 5))
    .before((input) => print("Trying to convert $input to string."))
    .after((output) => print("Successfully converted number to string. Result: $output"))
    .intercept((exception) => print("Failed to convert number to string. Exception caught: $exception"))
    .getOrNull("123") // Call the interactor with a parameter

// ...
```

Right now there are couple of decorators available:

| Decorator name      | Description                                                                                                   | Workflow                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| `after`             | Adds a hook that is called after the interactor is executed.                                                  | ![after](./doc/after.drawio.svg)          |
| `before`            | Adds a hook that is called before the interactor is executed.                                                 | ![before](./doc/before.drawio.svg)        |
| `busyStateChange`    | Adds a hook that is called when the interactor starts & ends.                                                 | ![busystate](./doc/busystate.drawio.svg)  |
| `eventually`        | Adds a hook that is called when the interactor finishes.                                                      | ![finally](./doc/eventually.drawio.svg)   |
| `intercept`         | Adds a hook that is called when the interactor fails.                                                         | ![catch](./doc/intercept.drawio.svg)      |
| `typedIntercept`    | Adds a hook that is called when the interactor fails with a specific exception type.                          | ![catch](./doc/intercept.drawio.svg)      |
| `checkedIntercept`  | Adds a hook that is called when the interactor fails and a given predicate returns true.                      | ![catch](./doc/intercept.drawio.svg)      |
| `log`               | Times the operation and produces a message that can be displayed through logging library.                     | ![log](./doc/log.drawio.svg)              |
| `map`               | Converts the output of the interactor.                                                                        | ![map](./doc/map.drawio.svg)              |
| `recover`           | Calls a given callback when an exception has been thrown. The callback must return a fallback output.         | ![recover](./doc/recover.drawio.svg)      |
| `typedRecover`      | Calls a given callback when a specific exception has been thrown. The callback must return a fallback output. | ![recover](./doc/recover.drawio.svg)      |
| `checkedRecover`    | Calls a given callback when the given predicate returns true. The callback must return a fallback output.     | ![recover](./doc/recover.drawio.svg)      |
| `timeout`           | Adds a timeout to the interactor.                                                                             | ![timeout](./doc/timeout.drawio.svg)      |

## Order Matters

The graphic below shows in which order each decorator is going to append itself around the execution.

<table>
<td>
<img src="./doc/chained.drawio.svg" alt="workflow visualization" style="width: 400px;">
</td>
<td style="vertical-align: top;">

```dart
myInteractor
    .intercept((exception) => print("Exception caught: $exception"))
    .before((input) => print("Interactor called with parameter = $input"))
    .after((output) => println("Output produced: $output"))
    .busyStateChange((isBusy) => println("Busy State: $isBusy"))
```
</td>
</table>
</p>

## Declaring your own customizations

It is possible to write custom decorators that modify that invocation-flow of the interactor.

Examples can be found [here](lib/src/).

```dart
extension CustomModifier<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> customModifier() {
    return InlinedParameterizedResultInteractor((input) {
      print("I am here!")
      return await runUnsafe(input);
    });
  }
}
```

## Progress Interactors

In some cases the interactor might need to publish progress information.
Given a `FileDownloadInteractor` that downloads a file from the internet, it might look like this:

```dart
typedef SourceUrl = String;
typedef DestinationFilepath = String;
typedef Parameter = ({
  SourceUrl sourceUrl,
  DestinationFilepath destinationFilepath
});

typedef DownloadedBytes = int;
typedef DownloadProgress = int;

final class FileDownloadInteractor extends ParameterizedResultProgressInteractor<
    Parameter, DownloadedBytes, DownloadProgress> {
  @override
  Future<DownloadedBytes> runUnsafe(Parameter input) async {
    // TODO: Implement your file download here

    await emitProgress(0);

    // Download ...

    await emitProgress(100);
  }
}

// ...

void main() {
    final downloadService = FileDownloadInteractor();

    final result = await downloadService
      .receiveProgress((progress) async {
        print('Download-Progress: $progress%');
      })
      .getOrThrow((
        sourceUrl: 'https://example.com/image.jpg',
        destinationFilepath: 'image.jpg'
      ));

    print(result);
}
```

Just like the default interactor types written above, the ProgressInteractor provides a single method called `onProgress` which must be called before all other decorators. It gets called whenever the interactor wants to publish a progress-value to the caller. Due to API limitations it can only be registerd once in the method-pipe.

The naming-convention mirrors the previously declared interactors from above.

| Type name                             | Parameterized | Resulting |
| ------------------------------------- | ------------- | --------- |
| ParameterizedResultProgressInteractor | Yes           | Yes       |
| ParameterizedProgressInteractor       | Yes           | No        |
| ResultProgressInteractor              | No            | Yes       |
| ProgressInteractor                    | No            | No        |

---

An example might look like this:

```dart
myFileDownloadInteractor
    .receiveProgress((progress) => println("Downloaded ${progress}% of the file."))
    .timeout(const Duration(seconds: 30))
    .before((input) => println("Downloading file from ${input.sourceUrl} to ${input.destinationFilepath}."))
    .after((_) => println("Successfully downloaded file."))
    .intercept((exception) => println("Failed to download file. Exception caught: $it"))
    .eventually(() => println("Finished downloading file from."))
    .getOrNull(FileDownloadInteractorInput("https://example.com/file.txt", "/path/to/file.txt"))
```

# Examples of all available modifiers

The following section contains a bunch of examples covering all available modifiers provided by this library.

To avoid defining the interactor's used across all examples, they'll be defined in a code-block underneith the examples.

### before
```dart
final greetings = await greetName
  .before((name) => 'Called with $name')
  .getOrThrow('John');
```

### after
```dart
await greetName
  .after((output) => print(output))
  .run('Barney');
```

### busy-state-change
```dart
await greetName
  .busyStateChange((isBusy) => print('IsBusy: $isBusy'))
  .run('Josh');
```

### emit-busy-state-change
```dart
await synchronizeData
  .emitBusyStateChange(isSyncingStreamController)
  .run();
```

### eventually
```dart
await stringToInt
  .eventually(() => print('Conversion done'))
  .run('10283');
```

### intercept
```dart
await stringToInt
  .intercept((exception) => print('Exception: $exception'))
  .run('not-a-number');
```

### typed-intercept
```dart
final result = await stringToInt
  .typedIntercept<FormatException>((exception) => -1)
  .typedIntercept<OverflowException>((exception) => 0)
  .getOrNull('not-a-number');
```

### checked-intercept
```dart
final result = await stringToInt
  .checkedIntercept((exception) {
    if (exception.message.contains('42')) {
      return true;
    }

    return false;
  })
  .getOrNull('not-a-number');
```

### log
```dart
await stringToInt
  .log(
    tag: 'String-To-Int',
    logBefore: printInfo,
    logAfter: printSuccess,
    logError: printError
  )
  .run('12');
```

### map
```dart
final pi = await stringToInt
  .map((output) => output + 0.1415)
  .getOrThrow('3');
```

### measure
```dart
final result = await stringToInt
  .measure((duration) => print('Conversion took $duration'))
  .getOrThrow('19272');
```

### recover
```dart
final result = await stringToInt
  .recover((exception) => -1)
  .getOrThrow('not-a-number');
```

### typed-recover
```dart
final result = await stringToInt
  .typedRecover<FormatException>((exception) => -1)
  .typedRecover<OverflowException>((exception) => 0)
  .getOrThrow('not-a-number');
```

### checked-recover
```dart
final result = await stringToInt
  .checkedRecover((exception) {
    if (exception.message.contains('42')) {
      return true;
    }

    return false;
  })
  .getOrThrow('not-a-number');
```

### run-at-least
```dart
await synchronizeData
  .runAtLeast(const Duration(seconds: 3))
  .run();
```

### timeout
```dart
await synchronizeData
  .timeout(const Duration(seconds: 10))
  .run();
```

## Interactors used in the examples above.

### GreetName
```dart
final class GreetName implements ParameterizedResultInteractor<String, String> {
  @override
  FutureOr<String> runUnsafe(String input) async {
    return 'Hello, $input';
  }
}
```

### StringToInt
```dart
final class StringToInt implements ParameterizedResultInteractor<String, int> {
  @override
  FutureOr<int> runUnsafe(String input) async {
    return int.parse(input);
  }
}
```

### SynchronizeData
```dart
final class SynchronizeData implements Interactor {
  @override
  FutureOr<Unit> runUnsafe(Unit input) async {
    // Perform sync ...
    return Future.delayed(const Duration(seconds: 1), () => unit);
  }
}
```
