## Package uic-interactor

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

## Additional information

When you take a closer look into the implementation of this module, you will see that basically everything is an extension. I've designed it to be extensible for basically every feature that you'd like to implement. The Timeout extension is a good example on how to do that. Basically an implementation of *InvocationModifier*  is needed in order to get information about the execution flow.
