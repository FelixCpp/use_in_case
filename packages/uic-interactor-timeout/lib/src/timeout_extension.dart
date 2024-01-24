import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_timeout/src/modifier/timeout_modifier_builder.dart';

extension InvocationConfiguratorWithTimeout<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> timeout(
    Duration timeoutDuration, {
    String? message,
  }) {
    return modifier(
      TimeoutInvocationModiferBuilder(
        timeoutDuration: timeoutDuration,
        message: message,
      ),
    );
  }
}
