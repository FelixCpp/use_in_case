import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';

class ProfilerInvocationModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final InvocationEventProfiler logger;
  final Stopwatch stopwatch;

  ProfilerInvocationModifier({
    required super.modifier,
    required this.logger,
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
            logger.onInvocationStart(details: details, input: event.input);
            callback(event, details);
          },
          onSuccess: (event) {
            callback(event, details);
            stopwatch.stop();
            logger.onInvocationSuccess(
              details: details,
              elapsedTime: stopwatch.elapsed,
              output: event.output,
            );
          },
          onFailure: (event) {
            callback(event, details);
            stopwatch.stop();
            logger.onInvocationFailure(
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
