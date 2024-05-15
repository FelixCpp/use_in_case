// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Event<Parameter, Result> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Parameter parameter) onStart,
    required TResult Function(Result result) onResult,
    required TResult Function(Exception exception) onException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Parameter parameter)? onStart,
    TResult? Function(Result result)? onResult,
    TResult? Function(Exception exception)? onException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Parameter parameter)? onStart,
    TResult Function(Result result)? onResult,
    TResult Function(Exception exception)? onException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Parameter, Result> value) onStart,
    required TResult Function(_OnResult<Parameter, Result> value) onResult,
    required TResult Function(_OnException<Parameter, Result> value) onException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Parameter, Result> value)? onStart,
    TResult? Function(_OnResult<Parameter, Result> value)? onResult,
    TResult? Function(_OnException<Parameter, Result> value)? onException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Parameter, Result> value)? onStart,
    TResult Function(_OnResult<Parameter, Result> value)? onResult,
    TResult Function(_OnException<Parameter, Result> value)? onException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<Parameter, Result, $Res> {
  factory $EventCopyWith(Event<Parameter, Result> value, $Res Function(Event<Parameter, Result>) then) =
      _$EventCopyWithImpl<Parameter, Result, $Res, Event<Parameter, Result>>;
}

/// @nodoc
class _$EventCopyWithImpl<Parameter, Result, $Res, $Val extends Event<Parameter, Result>>
    implements $EventCopyWith<Parameter, Result, $Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OnStartImplCopyWith<Parameter, Result, $Res> {
  factory _$$OnStartImplCopyWith(
          _$OnStartImpl<Parameter, Result> value, $Res Function(_$OnStartImpl<Parameter, Result>) then) =
      __$$OnStartImplCopyWithImpl<Parameter, Result, $Res>;
  @useResult
  $Res call({Parameter parameter});
}

/// @nodoc
class __$$OnStartImplCopyWithImpl<Parameter, Result, $Res>
    extends _$EventCopyWithImpl<Parameter, Result, $Res, _$OnStartImpl<Parameter, Result>>
    implements _$$OnStartImplCopyWith<Parameter, Result, $Res> {
  __$$OnStartImplCopyWithImpl(
      _$OnStartImpl<Parameter, Result> _value, $Res Function(_$OnStartImpl<Parameter, Result>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parameter = freezed,
  }) {
    return _then(_$OnStartImpl<Parameter, Result>(
      freezed == parameter
          ? _value.parameter
          : parameter // ignore: cast_nullable_to_non_nullable
              as Parameter,
    ));
  }
}

/// @nodoc

class _$OnStartImpl<Parameter, Result> implements _OnStart<Parameter, Result> {
  const _$OnStartImpl(this.parameter);

  @override
  final Parameter parameter;

  @override
  String toString() {
    return 'Event<$Parameter, $Result>.onStart(parameter: $parameter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnStartImpl<Parameter, Result> &&
            const DeepCollectionEquality().equals(other.parameter, parameter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(parameter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnStartImplCopyWith<Parameter, Result, _$OnStartImpl<Parameter, Result>> get copyWith =>
      __$$OnStartImplCopyWithImpl<Parameter, Result, _$OnStartImpl<Parameter, Result>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Parameter parameter) onStart,
    required TResult Function(Result result) onResult,
    required TResult Function(Exception exception) onException,
  }) {
    return onStart(parameter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Parameter parameter)? onStart,
    TResult? Function(Result result)? onResult,
    TResult? Function(Exception exception)? onException,
  }) {
    return onStart?.call(parameter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Parameter parameter)? onStart,
    TResult Function(Result result)? onResult,
    TResult Function(Exception exception)? onException,
    required TResult orElse(),
  }) {
    if (onStart != null) {
      return onStart(parameter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Parameter, Result> value) onStart,
    required TResult Function(_OnResult<Parameter, Result> value) onResult,
    required TResult Function(_OnException<Parameter, Result> value) onException,
  }) {
    return onStart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Parameter, Result> value)? onStart,
    TResult? Function(_OnResult<Parameter, Result> value)? onResult,
    TResult? Function(_OnException<Parameter, Result> value)? onException,
  }) {
    return onStart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Parameter, Result> value)? onStart,
    TResult Function(_OnResult<Parameter, Result> value)? onResult,
    TResult Function(_OnException<Parameter, Result> value)? onException,
    required TResult orElse(),
  }) {
    if (onStart != null) {
      return onStart(this);
    }
    return orElse();
  }
}

abstract class _OnStart<Parameter, Result> implements Event<Parameter, Result> {
  const factory _OnStart(final Parameter parameter) = _$OnStartImpl<Parameter, Result>;

  Parameter get parameter;
  @JsonKey(ignore: true)
  _$$OnStartImplCopyWith<Parameter, Result, _$OnStartImpl<Parameter, Result>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnResultImplCopyWith<Parameter, Result, $Res> {
  factory _$$OnResultImplCopyWith(
          _$OnResultImpl<Parameter, Result> value, $Res Function(_$OnResultImpl<Parameter, Result>) then) =
      __$$OnResultImplCopyWithImpl<Parameter, Result, $Res>;
  @useResult
  $Res call({Result result});
}

/// @nodoc
class __$$OnResultImplCopyWithImpl<Parameter, Result, $Res>
    extends _$EventCopyWithImpl<Parameter, Result, $Res, _$OnResultImpl<Parameter, Result>>
    implements _$$OnResultImplCopyWith<Parameter, Result, $Res> {
  __$$OnResultImplCopyWithImpl(
      _$OnResultImpl<Parameter, Result> _value, $Res Function(_$OnResultImpl<Parameter, Result>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_$OnResultImpl<Parameter, Result>(
      freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result,
    ));
  }
}

/// @nodoc

class _$OnResultImpl<Parameter, Result> implements _OnResult<Parameter, Result> {
  const _$OnResultImpl(this.result);

  @override
  final Result result;

  @override
  String toString() {
    return 'Event<$Parameter, $Result>.onResult(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnResultImpl<Parameter, Result> &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnResultImplCopyWith<Parameter, Result, _$OnResultImpl<Parameter, Result>> get copyWith =>
      __$$OnResultImplCopyWithImpl<Parameter, Result, _$OnResultImpl<Parameter, Result>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Parameter parameter) onStart,
    required TResult Function(Result result) onResult,
    required TResult Function(Exception exception) onException,
  }) {
    return onResult(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Parameter parameter)? onStart,
    TResult? Function(Result result)? onResult,
    TResult? Function(Exception exception)? onException,
  }) {
    return onResult?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Parameter parameter)? onStart,
    TResult Function(Result result)? onResult,
    TResult Function(Exception exception)? onException,
    required TResult orElse(),
  }) {
    if (onResult != null) {
      return onResult(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Parameter, Result> value) onStart,
    required TResult Function(_OnResult<Parameter, Result> value) onResult,
    required TResult Function(_OnException<Parameter, Result> value) onException,
  }) {
    return onResult(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Parameter, Result> value)? onStart,
    TResult? Function(_OnResult<Parameter, Result> value)? onResult,
    TResult? Function(_OnException<Parameter, Result> value)? onException,
  }) {
    return onResult?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Parameter, Result> value)? onStart,
    TResult Function(_OnResult<Parameter, Result> value)? onResult,
    TResult Function(_OnException<Parameter, Result> value)? onException,
    required TResult orElse(),
  }) {
    if (onResult != null) {
      return onResult(this);
    }
    return orElse();
  }
}

abstract class _OnResult<Parameter, Result> implements Event<Parameter, Result> {
  const factory _OnResult(final Result result) = _$OnResultImpl<Parameter, Result>;

  Result get result;
  @JsonKey(ignore: true)
  _$$OnResultImplCopyWith<Parameter, Result, _$OnResultImpl<Parameter, Result>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnExceptionImplCopyWith<Parameter, Result, $Res> {
  factory _$$OnExceptionImplCopyWith(
          _$OnExceptionImpl<Parameter, Result> value, $Res Function(_$OnExceptionImpl<Parameter, Result>) then) =
      __$$OnExceptionImplCopyWithImpl<Parameter, Result, $Res>;
  @useResult
  $Res call({Exception exception});
}

/// @nodoc
class __$$OnExceptionImplCopyWithImpl<Parameter, Result, $Res>
    extends _$EventCopyWithImpl<Parameter, Result, $Res, _$OnExceptionImpl<Parameter, Result>>
    implements _$$OnExceptionImplCopyWith<Parameter, Result, $Res> {
  __$$OnExceptionImplCopyWithImpl(
      _$OnExceptionImpl<Parameter, Result> _value, $Res Function(_$OnExceptionImpl<Parameter, Result>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$OnExceptionImpl<Parameter, Result>(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$OnExceptionImpl<Parameter, Result> implements _OnException<Parameter, Result> {
  const _$OnExceptionImpl(this.exception);

  @override
  final Exception exception;

  @override
  String toString() {
    return 'Event<$Parameter, $Result>.onException(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnExceptionImpl<Parameter, Result> &&
            (identical(other.exception, exception) || other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnExceptionImplCopyWith<Parameter, Result, _$OnExceptionImpl<Parameter, Result>> get copyWith =>
      __$$OnExceptionImplCopyWithImpl<Parameter, Result, _$OnExceptionImpl<Parameter, Result>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Parameter parameter) onStart,
    required TResult Function(Result result) onResult,
    required TResult Function(Exception exception) onException,
  }) {
    return onException(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Parameter parameter)? onStart,
    TResult? Function(Result result)? onResult,
    TResult? Function(Exception exception)? onException,
  }) {
    return onException?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Parameter parameter)? onStart,
    TResult Function(Result result)? onResult,
    TResult Function(Exception exception)? onException,
    required TResult orElse(),
  }) {
    if (onException != null) {
      return onException(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnStart<Parameter, Result> value) onStart,
    required TResult Function(_OnResult<Parameter, Result> value) onResult,
    required TResult Function(_OnException<Parameter, Result> value) onException,
  }) {
    return onException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnStart<Parameter, Result> value)? onStart,
    TResult? Function(_OnResult<Parameter, Result> value)? onResult,
    TResult? Function(_OnException<Parameter, Result> value)? onException,
  }) {
    return onException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnStart<Parameter, Result> value)? onStart,
    TResult Function(_OnResult<Parameter, Result> value)? onResult,
    TResult Function(_OnException<Parameter, Result> value)? onException,
    required TResult orElse(),
  }) {
    if (onException != null) {
      return onException(this);
    }
    return orElse();
  }
}

abstract class _OnException<Parameter, Result> implements Event<Parameter, Result> {
  const factory _OnException(final Exception exception) = _$OnExceptionImpl<Parameter, Result>;

  Exception get exception;
  @JsonKey(ignore: true)
  _$$OnExceptionImplCopyWith<Parameter, Result, _$OnExceptionImpl<Parameter, Result>> get copyWith =>
      throw _privateConstructorUsedError;
}
