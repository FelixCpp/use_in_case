import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/modifiers/profiler_modifier_builder.dart';

extension InvocationConfiguratorWithProfiler<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> profiler(
    InvocationEventProfiler profiler,
  ) {
    return modifier(ProfilerModifierBuilder(profiler: profiler));
  }
}
