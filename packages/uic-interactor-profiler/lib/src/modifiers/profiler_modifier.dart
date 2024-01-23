import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';

class ProfilerInvocationModifier<Input, Output>
    extends ForwardingInvocationModifier<Input, Output> {
  final InvocationEventProfiler _logger;
  final Stopwatch _stopwatch;

  ProfilerInvocationModifier({
    required InvocationEventProfiler logger,
    required super.modifier,
  })  : _logger = logger,
        _stopwatch = Stopwatch();

  @override
  InvocationEventHandler<Input, Output> buildEventHandler(
    InvocationEventHandler<Input, Output> callback,
  ) {
    return modifier.buildEventHandler(
      (event, details) {
        event.map(
          onStart: (event) {
            _stopwatch
              ..reset()
              ..start();
            _logger.onInvocationStart(details: details, input: event.input);
            callback(event, details);
          },
          onSuccess: (event) {
            callback(event, details);
            _stopwatch.stop();
            _logger.onInvocationSuccess(
              details: details,
              elapsedTime: _stopwatch.elapsed,
              output: event.output,
            );
          },
          onFailure: (event) {
            callback(event, details);
            _stopwatch.stop();
            _logger.onInvocationFailure(
              details: details,
              elapsedTime: _stopwatch.elapsed,
              exception: event.exception,
            );
          },
        );
      },
    );
  }
}
