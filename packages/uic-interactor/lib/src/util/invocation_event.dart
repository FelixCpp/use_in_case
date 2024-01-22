import 'package:freezed_annotation/freezed_annotation.dart';

part 'invocation_event.freezed.dart';

@freezed
class InvocationEvent<Input, Output> with _$InvocationEvent<Input, Output> {
  const factory InvocationEvent.onStart(Input input) = _OnStart;
  const factory InvocationEvent.onSuccess(Output output) = _OnSuccess;
  const factory InvocationEvent.onFailure(Exception exception) = _OnFailure;
}
