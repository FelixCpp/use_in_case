import 'dart:async';

import 'package:use_in_case/src/interactor.dart';

/// This extension provides a method to execute a callback before the interactor
///
/// Provided methods:
///  - [before]
extension BeforeExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  /// This method hangs itself in front of the interactor and calls
  /// the given [callback] before executing the previous interactor.
  ///
  /// The [callback] will be called with the input of the interactor.
  ///
  /// Example:
  /// ```dart
  /// final interactor = MyInteractor();
  /// await interactor
  ///   .before((input) => print('Interactor will be called with: $input'))
  ///   .run(input);
  /// ```
  ///
  /// This method is useful for logging or debugging. In some cases
  /// you might want to reset a certain state before executing the
  /// interactor. For example, you could reset the login-error of
  /// your application before calling the login interactor to ensure
  /// that the user does not see the old error message during the
  /// login process.
  ///
  /// An example of this login process:
  /// ```dart
  /// final loginInteractor = LoginInteractor();
  /// await loginInteractor
  ///   .before((_) => resetLoginError())
  ///   .busyStateChange((isLoggingIn) {
  ///       setLoadingIndicatorVisible(isLoggingIn);
  ///   })
  ///   .run(accountCredentials);
  /// ```
  ///
  /// Throwing an exception inside of [callback] will prevent
  /// the interactor from being executed.
  ///
  /// To execute code when the interactor finishes, you can use the
  /// [after] method. In case the outcome is not important, you can
  /// use the [eventually] method.
  ///
  /// see [after], [eventually]
  ParameterizedResultInteractor<Input, Output> before(
      FutureOr<void> Function(Input) callback) {
    return InlinedParameterizedResultInteractor((input) async {
      await callback(input);
      return getOrThrow(input);
    });
  }
}
