import 'dart:web_gl';

import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_completion_details.dart';
import 'package:uic_interactor_profiler/src/invocation_profiler_logger.dart';

class ProfilerInvocationModifier<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    implements InvocationModifier<Input, Output> {
  final InvocationProfilerLogger _logger;
  final Modifier _modifier;
  final Stopwatch _stopwatch;

  ProfilerInvocationModifier({
    required InvocationProfilerLogger logger,
    required Modifier modifier,
  })  : _logger = logger,
        _modifier = modifier,
        _stopwatch = Stopwatch();

  @override
  Stream<InvocationEvent<Input, Output>> buildStream() {
    return _modifier.buildStream();
  }

  @override
  void notify(
    InvocationDetails details,
    InvocationEvent<Input, Output> event,
    void Function(InvocationEvent<Input, Output>) callback,
  ) {
    _modifier.notify(details, event, (event) {
      event.map(
        onStart: (event) {
          _startProfiling(details);
          _logger.onInvocationStart(details);
          callback(event);
        },
        onSuccess: (event) {
          callback(event);
          _stopProfiling(details);
          _logger.onInvocationSuccess(
            details,
            InvocationSuccessDetails(
              elapsedTime: _stopwatch.elapsed,
              output: event.output,
            ),
          );
        },
        onFailure: (event) {
          callback(event);
          _stopProfiling(details);
          _logger.onInvocationFailure(
            details,
            InvocationFailureDetails(
              elapsedTime: _stopwatch.elapsed,
              exception: event.exception,
            ),
          );
        },
      );
    });
  }

  void _startProfiling(InvocationDetails details) {
    assert(
      !_stopwatch.isRunning,
      'Cannot start profiling multiple times without stopping.',
    );

    _stopwatch
      ..reset()
      ..start();
  }

  void _stopProfiling(InvocationDetails details) {
    assert(_stopwatch.isRunning, 'Cannot stop profiling without starting.');
    _stopwatch.stop();
  }
}

extension InvocationConfiguratorWithProfiler<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    on InvocationConfigurator<Input, Output, Modifier> {
  InvocationConfigurator<Input, Output,
      ProfilerInvocationModifier<Input, Output, Modifier>> profiler(
    InvocationProfilerLogger logger,
  ) {
    return InvocationConfigurator(
      details: details,
      modifier: ProfilerInvocationModifier(
        logger: logger,
        modifier: modifier,
      ),
    );
  }
}
