import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_timeout/src/modifiers/timeout_modifier.dart';

extension InvocationConfiguratorWithTimeout<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> timeout(
    Duration timeoutDuration, {
    String? message,
  }) {
    return apply(
      (modifier) => TimeoutInvocationModifier(
        timeoutDuration: timeoutDuration,
        modifier: modifier,
        message: message,
      ),
    );
  }
}
