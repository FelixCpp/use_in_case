import 'package:uic_interactor/uic_interactor.dart';

abstract class InvocationEventProfiler {
  void onInvocationStart<T>({
    required InvocationDetails details,
    required T input,
  }) {}

  void onInvocationSuccess<T>({
    required InvocationDetails details,
    required Duration elapsedTime,
    required T output,
  }) {}

  void onInvocationFailure({
    required InvocationDetails details,
    required Duration elapsedTime,
    required Exception exception,
  }) {}
}
