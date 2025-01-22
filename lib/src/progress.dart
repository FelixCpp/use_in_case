import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:use_in_case/src/interactor.dart';

/// Defines the interface for an interactor that emits progress.
/// This interface should be used when you want to emit progress events during the execution of the interactor.
/// The [Input] type is the type of the input that the interactor will receive.
/// The [Output] type is the type of the output that the interactor will return.
/// The [Progress] type is the type of the progress event that will be emitted.
///
/// Implementing this interface will allow you to use the [emitProgress] method to emit progress events.
///
/// Example:
/// ```dart
/// final class DownloadInteractor extends ParameterizedResultProgressInteractor<int, String, int> {
///   @override
///   FutureOr<String> runUnsafe(int input) async {
///     for (var i = 0; i < input; i++) {
///     await Future.delayed(Duration(seconds: 1));
///     emitProgress(i);
///   }
///
///   return 'Download complete!';
/// }
/// ```
abstract base class ParameterizedResultProgressInteractor<Input, Output, Progress> {
  late final FutureOr<void> Function(Progress progress) callback;
  FutureOr<Output> runUnsafe(Input input);
  Future<void> emitProgress(Progress progress) => Future(() => callback(progress));
}

typedef ParameterizedProgressInteractor<Input, Progress> = ParameterizedResultProgressInteractor<Input, void, Progress>;
typedef ResultProgressInteractor<Output, Progress> = ParameterizedResultProgressInteractor<Unit, Output, Progress>;
typedef ProgressInteractor<Progress> = ParameterizedResultProgressInteractor<Unit, void, Progress>;

/// Extension that adds the `receiveProgress` method to the [ParameterizedResultProgressInteractor] class.
/// This method allows you to receive progress events emitted by the interactor.
/// The callback will be called with the progress event that was emitted.
///
/// Example:
/// ```dart
/// final interactor = DownloadInteractor();
/// await interactor
///   .receiveProgress((progress) => print('Progress: $progress'))
///   .run(10);
/// ```
extension ReceiveProgressExtension<Input, Output, Progress> on ParameterizedResultProgressInteractor<Input, Output, Progress> {
  ParameterizedResultInteractor<Input, Output> receiveProgress(FutureOr<void> Function(Progress) callback) {
    this.callback = callback;

    return InlinedParameterizedResultInteractor<Input, Output>((input) => runUnsafe(input));
  }
}
