import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/modifiers/profiler_modifier.dart';

class ProfilerModifierBuilder<Input, Output>
    implements InvocationModifierBuilder<Input, Output> {
  final InvocationEventProfiler profiler;
  const ProfilerModifierBuilder({required this.profiler});

  @override
  InvocationModifier<Input, Output> build(
    InvocationModifier<Input, Output> modifier,
  ) {
    return ProfilerModifier(
      modifier: modifier,
      profiler: profiler,
    );
  }
}
