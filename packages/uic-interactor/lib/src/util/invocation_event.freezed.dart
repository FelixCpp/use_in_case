// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invocation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvocationEvent<Input, Output> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Input input) onStart,
    required TResult Function(Output output) onSuccess,
    required TResult Function(Exception exception) onFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Input input)? onStart,
    TResult? Function(Output output)? onSuccess,
    TResult? Function(Exception exception)? onFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Input input)? onStart,
    TResult Function(Output output)? onSuccess,
    TResult Function(Exception exception)? onFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Input, Output> value) onStart,
    required TResult Function(_OnSuccess<Input, Output> value) onSuccess,
    required TResult Function(_OnFailure<Input, Output> value) onFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Input, Output> value)? onStart,
    TResult? Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult? Function(_OnFailure<Input, Output> value)? onFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Input, Output> value)? onStart,
    TResult Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult Function(_OnFailure<Input, Output> value)? onFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvocationEventCopyWith<Input, Output, $Res> {
  factory $InvocationEventCopyWith(InvocationEvent<Input, Output> value,
          $Res Function(InvocationEvent<Input, Output>) then) =
      _$InvocationEventCopyWithImpl<Input, Output, $Res,
          InvocationEvent<Input, Output>>;
}

/// @nodoc
class _$InvocationEventCopyWithImpl<Input, Output, $Res,
        $Val extends InvocationEvent<Input, Output>>
    implements $InvocationEventCopyWith<Input, Output, $Res> {
  _$InvocationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OnStartImplCopyWith<Input, Output, $Res> {
  factory _$$OnStartImplCopyWith(_$OnStartImpl<Input, Output> value,
          $Res Function(_$OnStartImpl<Input, Output>) then) =
      __$$OnStartImplCopyWithImpl<Input, Output, $Res>;
  @useResult
  $Res call({Input input});
}

/// @nodoc
class __$$OnStartImplCopyWithImpl<Input, Output, $Res>
    extends _$InvocationEventCopyWithImpl<Input, Output, $Res,
        _$OnStartImpl<Input, Output>>
    implements _$$OnStartImplCopyWith<Input, Output, $Res> {
  __$$OnStartImplCopyWithImpl(_$OnStartImpl<Input, Output> _value,
      $Res Function(_$OnStartImpl<Input, Output>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$OnStartImpl<Input, Output>(
      freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as Input,
    ));
  }
}

/// @nodoc

class _$OnStartImpl<Input, Output> implements _OnStart<Input, Output> {
  const _$OnStartImpl(this.input);

  @override
  final Input input;

  @override
  String toString() {
    return 'InvocationEvent<$Input, $Output>.onStart(input: $input)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnStartImpl<Input, Output> &&
            const DeepCollectionEquality().equals(other.input, input));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(input));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnStartImplCopyWith<Input, Output, _$OnStartImpl<Input, Output>>
      get copyWith => __$$OnStartImplCopyWithImpl<Input, Output,
          _$OnStartImpl<Input, Output>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Input input) onStart,
    required TResult Function(Output output) onSuccess,
    required TResult Function(Exception exception) onFailure,
  }) {
    return onStart(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Input input)? onStart,
    TResult? Function(Output output)? onSuccess,
    TResult? Function(Exception exception)? onFailure,
  }) {
    return onStart?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Input input)? onStart,
    TResult Function(Output output)? onSuccess,
    TResult Function(Exception exception)? onFailure,
    required TResult orElse(),
  }) {
    if (onStart != null) {
      return onStart(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Input, Output> value) onStart,
    required TResult Function(_OnSuccess<Input, Output> value) onSuccess,
    required TResult Function(_OnFailure<Input, Output> value) onFailure,
  }) {
    return onStart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Input, Output> value)? onStart,
    TResult? Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult? Function(_OnFailure<Input, Output> value)? onFailure,
  }) {
    return onStart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Input, Output> value)? onStart,
    TResult Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult Function(_OnFailure<Input, Output> value)? onFailure,
    required TResult orElse(),
  }) {
    if (onStart != null) {
      return onStart(this);
    }
    return orElse();
  }
}

abstract class _OnStart<Input, Output>
    implements InvocationEvent<Input, Output> {
  const factory _OnStart(final Input input) = _$OnStartImpl<Input, Output>;

  Input get input;
  @JsonKey(ignore: true)
  _$$OnStartImplCopyWith<Input, Output, _$OnStartImpl<Input, Output>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnSuccessImplCopyWith<Input, Output, $Res> {
  factory _$$OnSuccessImplCopyWith(_$OnSuccessImpl<Input, Output> value,
          $Res Function(_$OnSuccessImpl<Input, Output>) then) =
      __$$OnSuccessImplCopyWithImpl<Input, Output, $Res>;
  @useResult
  $Res call({Output output});
}

/// @nodoc
class __$$OnSuccessImplCopyWithImpl<Input, Output, $Res>
    extends _$InvocationEventCopyWithImpl<Input, Output, $Res,
        _$OnSuccessImpl<Input, Output>>
    implements _$$OnSuccessImplCopyWith<Input, Output, $Res> {
  __$$OnSuccessImplCopyWithImpl(_$OnSuccessImpl<Input, Output> _value,
      $Res Function(_$OnSuccessImpl<Input, Output>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = freezed,
  }) {
    return _then(_$OnSuccessImpl<Input, Output>(
      freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Output,
    ));
  }
}

/// @nodoc

class _$OnSuccessImpl<Input, Output> implements _OnSuccess<Input, Output> {
  const _$OnSuccessImpl(this.output);

  @override
  final Output output;

  @override
  String toString() {
    return 'InvocationEvent<$Input, $Output>.onSuccess(output: $output)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnSuccessImpl<Input, Output> &&
            const DeepCollectionEquality().equals(other.output, output));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(output));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnSuccessImplCopyWith<Input, Output, _$OnSuccessImpl<Input, Output>>
      get copyWith => __$$OnSuccessImplCopyWithImpl<Input, Output,
          _$OnSuccessImpl<Input, Output>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Input input) onStart,
    required TResult Function(Output output) onSuccess,
    required TResult Function(Exception exception) onFailure,
  }) {
    return onSuccess(output);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Input input)? onStart,
    TResult? Function(Output output)? onSuccess,
    TResult? Function(Exception exception)? onFailure,
  }) {
    return onSuccess?.call(output);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Input input)? onStart,
    TResult Function(Output output)? onSuccess,
    TResult Function(Exception exception)? onFailure,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess(output);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Input, Output> value) onStart,
    required TResult Function(_OnSuccess<Input, Output> value) onSuccess,
    required TResult Function(_OnFailure<Input, Output> value) onFailure,
  }) {
    return onSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Input, Output> value)? onStart,
    TResult? Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult? Function(_OnFailure<Input, Output> value)? onFailure,
  }) {
    return onSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Input, Output> value)? onStart,
    TResult Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult Function(_OnFailure<Input, Output> value)? onFailure,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess(this);
    }
    return orElse();
  }
}

abstract class _OnSuccess<Input, Output>
    implements InvocationEvent<Input, Output> {
  const factory _OnSuccess(final Output output) =
      _$OnSuccessImpl<Input, Output>;

  Output get output;
  @JsonKey(ignore: true)
  _$$OnSuccessImplCopyWith<Input, Output, _$OnSuccessImpl<Input, Output>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnFailureImplCopyWith<Input, Output, $Res> {
  factory _$$OnFailureImplCopyWith(_$OnFailureImpl<Input, Output> value,
          $Res Function(_$OnFailureImpl<Input, Output>) then) =
      __$$OnFailureImplCopyWithImpl<Input, Output, $Res>;
  @useResult
  $Res call({Exception exception});
}

/// @nodoc
class __$$OnFailureImplCopyWithImpl<Input, Output, $Res>
    extends _$InvocationEventCopyWithImpl<Input, Output, $Res,
        _$OnFailureImpl<Input, Output>>
    implements _$$OnFailureImplCopyWith<Input, Output, $Res> {
  __$$OnFailureImplCopyWithImpl(_$OnFailureImpl<Input, Output> _value,
      $Res Function(_$OnFailureImpl<Input, Output>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$OnFailureImpl<Input, Output>(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$OnFailureImpl<Input, Output> implements _OnFailure<Input, Output> {
  const _$OnFailureImpl(this.exception);

  @override
  final Exception exception;

  @override
  String toString() {
    return 'InvocationEvent<$Input, $Output>.onFailure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnFailureImpl<Input, Output> &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnFailureImplCopyWith<Input, Output, _$OnFailureImpl<Input, Output>>
      get copyWith => __$$OnFailureImplCopyWithImpl<Input, Output,
          _$OnFailureImpl<Input, Output>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Input input) onStart,
    required TResult Function(Output output) onSuccess,
    required TResult Function(Exception exception) onFailure,
  }) {
    return onFailure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Input input)? onStart,
    TResult? Function(Output output)? onSuccess,
    TResult? Function(Exception exception)? onFailure,
  }) {
    return onFailure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Input input)? onStart,
    TResult Function(Output output)? onSuccess,
    TResult Function(Exception exception)? onFailure,
    required TResult orElse(),
  }) {
    if (onFailure != null) {
      return onFailure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Input, Output> value) onStart,
    required TResult Function(_OnSuccess<Input, Output> value) onSuccess,
    required TResult Function(_OnFailure<Input, Output> value) onFailure,
  }) {
    return onFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Input, Output> value)? onStart,
    TResult? Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult? Function(_OnFailure<Input, Output> value)? onFailure,
  }) {
    return onFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Input, Output> value)? onStart,
    TResult Function(_OnSuccess<Input, Output> value)? onSuccess,
    TResult Function(_OnFailure<Input, Output> value)? onFailure,
    required TResult orElse(),
  }) {
    if (onFailure != null) {
      return onFailure(this);
    }
    return orElse();
  }
}

abstract class _OnFailure<Input, Output>
    implements InvocationEvent<Input, Output> {
  const factory _OnFailure(final Exception exception) =
      _$OnFailureImpl<Input, Output>;

  Exception get exception;
  @JsonKey(ignore: true)
  _$$OnFailureImplCopyWith<Input, Output, _$OnFailureImpl<Input, Output>>
      get copyWith => throw _privateConstructorUsedError;
}
