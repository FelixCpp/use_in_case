import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';
import 'package:uic_interactor_profiler/src/modifiers/profiler_modifier.dart';

///
/// TODO(Felix): Add generic modifier ".modifier"
///

extension InvocationConfiguratorWithProfiler<Input, Output>
    on InvocationConfigurator<Input, Output> {
  InvocationConfigurator<Input, Output> profiler(
    InvocationEventProfiler profiler,
  ) {
    return apply(
      (modifier) => ProfilerInvocationModifier(
        logger: profiler,
        modifier: modifier,
      ),
    );
  }
}
