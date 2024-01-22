// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invocation_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvocationDetails {
  String get jobName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvocationDetailsCopyWith<InvocationDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvocationDetailsCopyWith<$Res> {
  factory $InvocationDetailsCopyWith(
          InvocationDetails value, $Res Function(InvocationDetails) then) =
      _$InvocationDetailsCopyWithImpl<$Res, InvocationDetails>;
  @useResult
  $Res call({String jobName});
}

/// @nodoc
class _$InvocationDetailsCopyWithImpl<$Res, $Val extends InvocationDetails>
    implements $InvocationDetailsCopyWith<$Res> {
  _$InvocationDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobName = null,
  }) {
    return _then(_value.copyWith(
      jobName: null == jobName
          ? _value.jobName
          : jobName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvocationDetailsImplCopyWith<$Res>
    implements $InvocationDetailsCopyWith<$Res> {
  factory _$$InvocationDetailsImplCopyWith(_$InvocationDetailsImpl value,
          $Res Function(_$InvocationDetailsImpl) then) =
      __$$InvocationDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String jobName});
}

/// @nodoc
class __$$InvocationDetailsImplCopyWithImpl<$Res>
    extends _$InvocationDetailsCopyWithImpl<$Res, _$InvocationDetailsImpl>
    implements _$$InvocationDetailsImplCopyWith<$Res> {
  __$$InvocationDetailsImplCopyWithImpl(_$InvocationDetailsImpl _value,
      $Res Function(_$InvocationDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobName = null,
  }) {
    return _then(_$InvocationDetailsImpl(
      jobName: null == jobName
          ? _value.jobName
          : jobName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvocationDetailsImpl implements _InvocationDetails {
  const _$InvocationDetailsImpl({required this.jobName});

  @override
  final String jobName;

  @override
  String toString() {
    return 'InvocationDetails(jobName: $jobName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvocationDetailsImpl &&
            (identical(other.jobName, jobName) || other.jobName == jobName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, jobName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvocationDetailsImplCopyWith<_$InvocationDetailsImpl> get copyWith =>
      __$$InvocationDetailsImplCopyWithImpl<_$InvocationDetailsImpl>(
          this, _$identity);
}

abstract class _InvocationDetails implements InvocationDetails {
  const factory _InvocationDetails({required final String jobName}) =
      _$InvocationDetailsImpl;

  @override
  String get jobName;
  @override
  @JsonKey(ignore: true)
  _$$InvocationDetailsImplCopyWith<_$InvocationDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
