import 'package:freezed_annotation/freezed_annotation.dart';

part 'invocation_completion_details.freezed.dart';

@freezed
class InvocationSuccessDetails<T> with _$InvocationSuccessDetails<T> {
  const factory InvocationSuccessDetails({
    required Duration elapsedTime,
    required T output,
  }) = _OnSuccessDetails;
}

@freezed
class InvocationFailureDetails with _$InvocationFailureDetails {
  const factory InvocationFailureDetails({
    required Duration elapsedTime,
    required Exception exception,
  }) = _OnFailureDetails;
}
