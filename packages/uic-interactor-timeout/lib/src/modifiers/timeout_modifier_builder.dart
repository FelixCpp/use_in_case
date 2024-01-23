import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_timeout/src/modifiers/timeout_modifier.dart';

class TimeoutInvocationModiferBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final Duration timeoutDuration;
  final String? message;

  const TimeoutInvocationModiferBuilder({
    required this.timeoutDuration,
    this.message,
  });

  @override
  InvocationModifier<Input, Output> build(
      InvocationModifier<Input, Output> modifier) {
    return TimeoutInvocationModifier(
      modifier: modifier,
      timeoutDuration: timeoutDuration,
      message: message,
    );
  }
}
