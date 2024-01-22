import 'package:freezed_annotation/freezed_annotation.dart';

part 'invocation_details.freezed.dart';

@freezed
class InvocationDetails with _$InvocationDetails {
  const factory InvocationDetails({
    required final String jobName,
  }) = _InvocationDetails;
}
