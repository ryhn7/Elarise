// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatroom_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) {
  return _ChatRoomResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomResponse {
  String get chatRoomId => throw _privateConstructorUsedError;
  String get chatRoomName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomResponseCopyWith<ChatRoomResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomResponseCopyWith<$Res> {
  factory $ChatRoomResponseCopyWith(
          ChatRoomResponse value, $Res Function(ChatRoomResponse) then) =
      _$ChatRoomResponseCopyWithImpl<$Res, ChatRoomResponse>;
  @useResult
  $Res call(
      {String chatRoomId, String chatRoomName, String type, String message});
}

/// @nodoc
class _$ChatRoomResponseCopyWithImpl<$Res, $Val extends ChatRoomResponse>
    implements $ChatRoomResponseCopyWith<$Res> {
  _$ChatRoomResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? chatRoomName = null,
    Object? type = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomName: null == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomResponseImplCopyWith<$Res>
    implements $ChatRoomResponseCopyWith<$Res> {
  factory _$$ChatRoomResponseImplCopyWith(_$ChatRoomResponseImpl value,
          $Res Function(_$ChatRoomResponseImpl) then) =
      __$$ChatRoomResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chatRoomId, String chatRoomName, String type, String message});
}

/// @nodoc
class __$$ChatRoomResponseImplCopyWithImpl<$Res>
    extends _$ChatRoomResponseCopyWithImpl<$Res, _$ChatRoomResponseImpl>
    implements _$$ChatRoomResponseImplCopyWith<$Res> {
  __$$ChatRoomResponseImplCopyWithImpl(_$ChatRoomResponseImpl _value,
      $Res Function(_$ChatRoomResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? chatRoomName = null,
    Object? type = null,
    Object? message = null,
  }) {
    return _then(_$ChatRoomResponseImpl(
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomName: null == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomResponseImpl implements _ChatRoomResponse {
  const _$ChatRoomResponseImpl(
      {required this.chatRoomId,
      required this.chatRoomName,
      required this.type,
      required this.message});

  factory _$ChatRoomResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomResponseImplFromJson(json);

  @override
  final String chatRoomId;
  @override
  final String chatRoomName;
  @override
  final String type;
  @override
  final String message;

  @override
  String toString() {
    return 'ChatRoomResponse(chatRoomId: $chatRoomId, chatRoomName: $chatRoomName, type: $type, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomResponseImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.chatRoomName, chatRoomName) ||
                other.chatRoomName == chatRoomName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, chatRoomId, chatRoomName, type, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomResponseImplCopyWith<_$ChatRoomResponseImpl> get copyWith =>
      __$$ChatRoomResponseImplCopyWithImpl<_$ChatRoomResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomResponse implements ChatRoomResponse {
  const factory _ChatRoomResponse(
      {required final String chatRoomId,
      required final String chatRoomName,
      required final String type,
      required final String message}) = _$ChatRoomResponseImpl;

  factory _ChatRoomResponse.fromJson(Map<String, dynamic> json) =
      _$ChatRoomResponseImpl.fromJson;

  @override
  String get chatRoomId;
  @override
  String get chatRoomName;
  @override
  String get type;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomResponseImplCopyWith<_$ChatRoomResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
