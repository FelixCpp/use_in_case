// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invocation_completion_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvocationSuccessDetails<T> {
  Duration get elapsedTime => throw _privateConstructorUsedError;
  T get output => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvocationSuccessDetailsCopyWith<T, InvocationSuccessDetails<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvocationSuccessDetailsCopyWith<T, $Res> {
  factory $InvocationSuccessDetailsCopyWith(InvocationSuccessDetails<T> value,
          $Res Function(InvocationSuccessDetails<T>) then) =
      _$InvocationSuccessDetailsCopyWithImpl<T, $Res,
          InvocationSuccessDetails<T>>;
  @useResult
  $Res call({Duration elapsedTime, T output});
}

/// @nodoc
class _$InvocationSuccessDetailsCopyWithImpl<T, $Res,
        $Val extends InvocationSuccessDetails<T>>
    implements $InvocationSuccessDetailsCopyWith<T, $Res> {
  _$InvocationSuccessDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsedTime = null,
    Object? output = freezed,
  }) {
    return _then(_value.copyWith(
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnSuccessDetailsImplCopyWith<T, $Res>
    implements $InvocationSuccessDetailsCopyWith<T, $Res> {
  factory _$$OnSuccessDetailsImplCopyWith(_$OnSuccessDetailsImpl<T> value,
          $Res Function(_$OnSuccessDetailsImpl<T>) then) =
      __$$OnSuccessDetailsImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({Duration elapsedTime, T output});
}

/// @nodoc
class __$$OnSuccessDetailsImplCopyWithImpl<T, $Res>
    extends _$InvocationSuccessDetailsCopyWithImpl<T, $Res,
        _$OnSuccessDetailsImpl<T>>
    implements _$$OnSuccessDetailsImplCopyWith<T, $Res> {
  __$$OnSuccessDetailsImplCopyWithImpl(_$OnSuccessDetailsImpl<T> _value,
      $Res Function(_$OnSuccessDetailsImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsedTime = null,
    Object? output = freezed,
  }) {
    return _then(_$OnSuccessDetailsImpl<T>(
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$OnSuccessDetailsImpl<T> implements _OnSuccessDetails<T> {
  const _$OnSuccessDetailsImpl(
      {required this.elapsedTime, required this.output});

  @override
  final Duration elapsedTime;
  @override
  final T output;

  @override
  String toString() {
    return 'InvocationSuccessDetails<$T>(elapsedTime: $elapsedTime, output: $output)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnSuccessDetailsImpl<T> &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime) &&
            const DeepCollectionEquality().equals(other.output, output));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, elapsedTime, const DeepCollectionEquality().hash(output));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnSuccessDetailsImplCopyWith<T, _$OnSuccessDetailsImpl<T>> get copyWith =>
      __$$OnSuccessDetailsImplCopyWithImpl<T, _$OnSuccessDetailsImpl<T>>(
          this, _$identity);
}

abstract class _OnSuccessDetails<T> implements InvocationSuccessDetails<T> {
  const factory _OnSuccessDetails(
      {required final Duration elapsedTime,
      required final T output}) = _$OnSuccessDetailsImpl<T>;

  @override
  Duration get elapsedTime;
  @override
  T get output;
  @override
  @JsonKey(ignore: true)
  _$$OnSuccessDetailsImplCopyWith<T, _$OnSuccessDetailsImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InvocationFailureDetails {
  Duration get elapsedTime => throw _privateConstructorUsedError;
  Exception get exception => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvocationFailureDetailsCopyWith<InvocationFailureDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvocationFailureDetailsCopyWith<$Res> {
  factory $InvocationFailureDetailsCopyWith(InvocationFailureDetails value,
          $Res Function(InvocationFailureDetails) then) =
      _$InvocationFailureDetailsCopyWithImpl<$Res, InvocationFailureDetails>;
  @useResult
  $Res call({Duration elapsedTime, Exception exception});
}

/// @nodoc
class _$InvocationFailureDetailsCopyWithImpl<$Res,
        $Val extends InvocationFailureDetails>
    implements $InvocationFailureDetailsCopyWith<$Res> {
  _$InvocationFailureDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsedTime = null,
    Object? exception = null,
  }) {
    return _then(_value.copyWith(
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnFailureDetailsImplCopyWith<$Res>
    implements $InvocationFailureDetailsCopyWith<$Res> {
  factory _$$OnFailureDetailsImplCopyWith(_$OnFailureDetailsImpl value,
          $Res Function(_$OnFailureDetailsImpl) then) =
      __$$OnFailureDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration elapsedTime, Exception exception});
}

/// @nodoc
class __$$OnFailureDetailsImplCopyWithImpl<$Res>
    extends _$InvocationFailureDetailsCopyWithImpl<$Res, _$OnFailureDetailsImpl>
    implements _$$OnFailureDetailsImplCopyWith<$Res> {
  __$$OnFailureDetailsImplCopyWithImpl(_$OnFailureDetailsImpl _value,
      $Res Function(_$OnFailureDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsedTime = null,
    Object? exception = null,
  }) {
    return _then(_$OnFailureDetailsImpl(
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$OnFailureDetailsImpl implements _OnFailureDetails {
  const _$OnFailureDetailsImpl(
      {required this.elapsedTime, required this.exception});

  @override
  final Duration elapsedTime;
  @override
  final Exception exception;

  @override
  String toString() {
    return 'InvocationFailureDetails(elapsedTime: $elapsedTime, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnFailureDetailsImpl &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime) &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, elapsedTime, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnFailureDetailsImplCopyWith<_$OnFailureDetailsImpl> get copyWith =>
      __$$OnFailureDetailsImplCopyWithImpl<_$OnFailureDetailsImpl>(
          this, _$identity);
}

abstract class _OnFailureDetails implements InvocationFailureDetails {
  const factory _OnFailureDetails(
      {required final Duration elapsedTime,
      required final Exception exception}) = _$OnFailureDetailsImpl;

  @override
  Duration get elapsedTime;
  @override
  Exception get exception;
  @override
  @JsonKey(ignore: true)
  _$$OnFailureDetailsImplCopyWith<_$OnFailureDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
