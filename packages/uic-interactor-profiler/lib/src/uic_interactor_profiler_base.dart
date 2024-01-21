import 'package:uic_interactor/uic_interactor.dart';

class ProfilerInvocationModifier<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    implements InvocationModifier<Input, Output> {
  final Modifier _modifier;
  final Stopwatch _stopwatch;

  ProfilerInvocationModifier({
    required Modifier modifier,
  })  : _modifier = modifier,
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
    event.map(
      onStart: (event) {
        _startProfiling(details);
        callback(event);
      },
      onSuccess: (event) {
        callback(event);
        _stopProfiling(details);
      },
      onFailure: (event) {
        callback(event);
        _stopProfiling(details);
      },
    );
  }

  void _startProfiling(InvocationDetails details) {
    assert(
      !_stopwatch.isRunning,
      'Cannot start profiling multiple times without stopping.',
    );

    _stopwatch
      ..reset()
      ..start();

    print('${details.jobName}.onStart()');
  }

  void _stopProfiling(InvocationDetails details) {
    assert(_stopwatch.isRunning, 'Cannot stop profiling without starting.');
    _stopwatch.stop();

    print('${details.jobName}.onStop() => ${_stopwatch.elapsed}');
  }
}

extension InvocationConfiguratorWithProfiler<Input, Output,
        Modifier extends InvocationModifier<Input, Output>>
    on InvocationConfigurator<Input, Output, Modifier> {
  InvocationConfigurator<Input, Output,
      ProfilerInvocationModifier<Input, Output, Modifier>> profiler() {
    return InvocationConfigurator(
      details: details,
      modifier: ProfilerInvocationModifier(modifier: modifier),
    );
  }
}
