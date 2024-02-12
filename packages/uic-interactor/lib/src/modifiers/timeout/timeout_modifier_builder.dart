import 'package:uic_interactor/src/modifiers/timeout/timeout_modifier.dart';
import 'package:uic_interactor/uic_interactor.dart';

class TimeoutModiferBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final Duration timeoutDuration;
  final String? message;

  const TimeoutModiferBuilder({
    required this.timeoutDuration,
    this.message,
  });

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return TimeoutModifier(
      modifier: modifier,
      timeoutDuration: timeoutDuration,
      message: message,
    );
  }
}

extension InvocationConfiguratorWithTimeout<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> timeout(
    Duration timeoutDuration, {
    String? message,
  }) {
    return modifier(
      TimeoutModiferBuilder(
        timeoutDuration: timeoutDuration,
        message: message,
      ),
    );
  }
}
