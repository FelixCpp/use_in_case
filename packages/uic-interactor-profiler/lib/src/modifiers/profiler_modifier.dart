import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';

class ProfilerModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final InvocationEventProfiler profiler;
  final Stopwatch stopwatch;

  ProfilerModifier({
    required super.modifier,
    required this.profiler,
  }) : stopwatch = Stopwatch();

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler(
      (event, details) {
        event.map(
          onStart: (event) {
            stopwatch
              ..reset()
              ..start();
            profiler.onInvocationStart(details: details, input: event.input);
            callback(event, details);
          },
          onSuccess: (event) {
            callback(event, details);
            stopwatch.stop();
            profiler.onInvocationSuccess(
              details: details,
              elapsedTime: stopwatch.elapsed,
              output: event.output,
            );
          },
          onFailure: (event) {
            callback(event, details);
            stopwatch.stop();
            profiler.onInvocationFailure(
              details: details,
              elapsedTime: stopwatch.elapsed,
              exception: event.exception,
            );
          },
        );
      },
    );
  }
}
