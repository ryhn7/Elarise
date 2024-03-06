// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'talk_freely_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TalkFreelyResponse _$TalkFreelyResponseFromJson(Map<String, dynamic> json) {
  return _TalkFreelyResponse.fromJson(json);
}

/// @nodoc
mixin _$TalkFreelyResponse {
  String get message => throw _privateConstructorUsedError;
  bool get isUserMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TalkFreelyResponseCopyWith<TalkFreelyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkFreelyResponseCopyWith<$Res> {
  factory $TalkFreelyResponseCopyWith(
          TalkFreelyResponse value, $Res Function(TalkFreelyResponse) then) =
      _$TalkFreelyResponseCopyWithImpl<$Res, TalkFreelyResponse>;
  @useResult
  $Res call({String message, bool isUserMessage});
}

/// @nodoc
class _$TalkFreelyResponseCopyWithImpl<$Res, $Val extends TalkFreelyResponse>
    implements $TalkFreelyResponseCopyWith<$Res> {
  _$TalkFreelyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isUserMessage = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalkFreelyResponseImplCopyWith<$Res>
    implements $TalkFreelyResponseCopyWith<$Res> {
  factory _$$TalkFreelyResponseImplCopyWith(_$TalkFreelyResponseImpl value,
          $Res Function(_$TalkFreelyResponseImpl) then) =
      __$$TalkFreelyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool isUserMessage});
}

/// @nodoc
class __$$TalkFreelyResponseImplCopyWithImpl<$Res>
    extends _$TalkFreelyResponseCopyWithImpl<$Res, _$TalkFreelyResponseImpl>
    implements _$$TalkFreelyResponseImplCopyWith<$Res> {
  __$$TalkFreelyResponseImplCopyWithImpl(_$TalkFreelyResponseImpl _value,
      $Res Function(_$TalkFreelyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isUserMessage = null,
  }) {
    return _then(_$TalkFreelyResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isUserMessage: null == isUserMessage
          ? _value.isUserMessage
          : isUserMessage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TalkFreelyResponseImpl implements _TalkFreelyResponse {
  const _$TalkFreelyResponseImpl(
      {required this.message, this.isUserMessage = false});

  factory _$TalkFreelyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TalkFreelyResponseImplFromJson(json);

  @override
  final String message;
  @override
  @JsonKey()
  final bool isUserMessage;

  @override
  String toString() {
    return 'TalkFreelyResponse(message: $message, isUserMessage: $isUserMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalkFreelyResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isUserMessage, isUserMessage) ||
                other.isUserMessage == isUserMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, isUserMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TalkFreelyResponseImplCopyWith<_$TalkFreelyResponseImpl> get copyWith =>
      __$$TalkFreelyResponseImplCopyWithImpl<_$TalkFreelyResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TalkFreelyResponseImplToJson(
      this,
    );
  }
}

abstract class _TalkFreelyResponse implements TalkFreelyResponse {
  const factory _TalkFreelyResponse(
      {required final String message,
      final bool isUserMessage}) = _$TalkFreelyResponseImpl;

  factory _TalkFreelyResponse.fromJson(Map<String, dynamic> json) =
      _$TalkFreelyResponseImpl.fromJson;

  @override
  String get message;
  @override
  bool get isUserMessage;
  @override
  @JsonKey(ignore: true)
  _$$TalkFreelyResponseImplCopyWith<_$TalkFreelyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
