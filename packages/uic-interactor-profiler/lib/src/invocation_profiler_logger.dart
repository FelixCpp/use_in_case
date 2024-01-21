import 'package:uic_interactor/uic_interactor.dart';
import 'package:uic_interactor_profiler/src/invocation_completion_details.dart';

abstract interface class InvocationProfilerLogger {
  void onInvocationStart(InvocationDetails details);

  void onInvocationSuccess<T>(
    InvocationDetails details,
    InvocationSuccessDetails<T> invocation,
  );

  void onInvocationFailure(
    InvocationDetails details,
    InvocationFailureDetails invocation,
  );
}
