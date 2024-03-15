// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elara_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ElaraResponse _$ElaraResponseFromJson(Map<String, dynamic> json) {
  return _ElaraResponse.fromJson(json);
}

/// @nodoc
mixin _$ElaraResponse {
  String get message => throw _privateConstructorUsedError;
  bool get isUserMessage => throw _privateConstructorUsedError;
  bool get isPlaceholder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ElaraResponseCopyWith<ElaraResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElaraResponseCopyWith<$Res> {
  factory $ElaraResponseCopyWith(
          ElaraResponse value, $Res Function(ElaraResponse) then) =
      _$ElaraResponseCopyWithImpl<$Res, ElaraResponse>;
  @useResult
  $Res call({String message, bool isUserMessage, bool isPlaceholder});
}

/// @nodoc
class _$ElaraResponseCopyWithImpl<$Res, $Val extends ElaraResponse>
    implements $ElaraResponseCopyWith<$Res> {
  _$ElaraResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isUserMessage = null,
    Object? isPlaceholder = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isUserMessage: null == isUserMessage
          ? _value.isUserMessage
          : isUserMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaceholder: null == isPlaceholder
          ? _value.isPlaceholder
          : isPlaceholder // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElaraResponseImplCopyWith<$Res>
    implements $ElaraResponseCopyWith<$Res> {
  factory _$$ElaraResponseImplCopyWith(
          _$ElaraResponseImpl value, $Res Function(_$ElaraResponseImpl) then) =
      __$$ElaraResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool isUserMessage, bool isPlaceholder});
}

/// @nodoc
class __$$ElaraResponseImplCopyWithImpl<$Res>
    extends _$ElaraResponseCopyWithImpl<$Res, _$ElaraResponseImpl>
    implements _$$ElaraResponseImplCopyWith<$Res> {
  __$$ElaraResponseImplCopyWithImpl(
      _$ElaraResponseImpl _value, $Res Function(_$ElaraResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isUserMessage = null,
    Object? isPlaceholder = null,
  }) {
    return _then(_$ElaraResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isUserMessage: null == isUserMessage
          ? _value.isUserMessage
          : isUserMessage // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaceholder: null == isPlaceholder
          ? _value.isPlaceholder
          : isPlaceholder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElaraResponseImpl implements _ElaraResponse {
  const _$ElaraResponseImpl(
      {required this.message,
      this.isUserMessage = false,
      this.isPlaceholder = false});

  factory _$ElaraResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElaraResponseImplFromJson(json);

  @override
  final String message;
  @override
  @JsonKey()
  final bool isUserMessage;
  @override
  @JsonKey()
  final bool isPlaceholder;

  @override
  String toString() {
    return 'ElaraResponse(message: $message, isUserMessage: $isUserMessage, isPlaceholder: $isPlaceholder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElaraResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isUserMessage, isUserMessage) ||
                other.isUserMessage == isUserMessage) &&
            (identical(other.isPlaceholder, isPlaceholder) ||
                other.isPlaceholder == isPlaceholder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, message, isUserMessage, isPlaceholder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElaraResponseImplCopyWith<_$ElaraResponseImpl> get copyWith =>
      __$$ElaraResponseImplCopyWithImpl<_$ElaraResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElaraResponseImplToJson(
      this,
    );
  }
}

abstract class _ElaraResponse implements ElaraResponse {
  const factory _ElaraResponse(
      {required final String message,
      final bool isUserMessage,
      final bool isPlaceholder}) = _$ElaraResponseImpl;

  factory _ElaraResponse.fromJson(Map<String, dynamic> json) =
      _$ElaraResponseImpl.fromJson;

  @override
  String get message;
  @override
  bool get isUserMessage;
  @override
  bool get isPlaceholder;
  @override
  @JsonKey(ignore: true)
  _$$ElaraResponseImplCopyWith<_$ElaraResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
