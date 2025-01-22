import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

/// Extension that adds the `logEvents` and `log` methods to the [ParameterizedResultInteractor] class.
/// These methods allow you to log the start, success, and error events of the interactor.
/// You can specify custom log messages for each event.
/// The `logEvents` method allows you to specify a different log message for each event.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///  .logEvents(
///     logStart: (input) => print('MyInteractor started with $input'),
///     logSuccess: (duration, output) => print('MyInteractor completed after $duration with $output'),
///     logError: (duration, exception) => print('MyInteractor failed after $duration with $exception'),
///   )
///   .run(input);
/// ```
///
/// The `log` method allows you to specify a tag for the log messages.
/// The tag will be prepended to the log messages.
/// This could be useful if you want to differentiate between different events produced by the interactor.
/// For example, you could log all errors produced by the interactor into a file rather than the console.
///
/// Example:
/// ```dart
/// final interactor = MyInteractor();
/// await interactor
///   .log(
///     tag: 'MyInteractor',
///     logStart: (message) => stdout.writeln(message),
///     logSuccess: (message) => stdout.writeln(message),
///     logError: (message) => stderr.writeln(message),
///   )
///   .run(input);
extension Log<Input, Output> on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> logEvents({
    required FutureOr<void> Function(Input) logStart,
    required FutureOr<void> Function(Duration, Output) logSuccess,
    required FutureOr<void> Function(Duration, Exception) logError,
  }) {
    return InlinedParameterizedResultInteractor((input) async {
      final stopwatch = Stopwatch();
      try {
        await logStart(input);

        stopwatch.start();
        final output = await runUnsafe(input);

        await logSuccess(stopwatch.elapsed, output);

        return output;
      } on Exception catch (exception) {
        await logError(stopwatch.elapsed, exception);
        rethrow;
      }
    });
  }

  ParameterizedResultInteractor<Input, Output> log({
    required String tag,
    required FutureOr<void> Function(String) logStart,
    required FutureOr<void> Function(String) logSuccess,
    required FutureOr<void> Function(String) logError,
  }) {
    return logEvents(
      logStart: (input) => logStart('$tag started with $input'),
      logSuccess: (duration, output) => logSuccess('$tag completed after $duration with $output'),
      logError: (duration, exception) => logError('$tag failed after $duration with $exception'),
    );
  }
}
