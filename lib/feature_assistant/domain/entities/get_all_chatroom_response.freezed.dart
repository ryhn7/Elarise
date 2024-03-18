// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_chatroom_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetAllChatroomResponse _$GetAllChatroomResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllChatroomResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllChatroomResponse {
  List<ChatRoom> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAllChatroomResponseCopyWith<GetAllChatroomResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllChatroomResponseCopyWith<$Res> {
  factory $GetAllChatroomResponseCopyWith(GetAllChatroomResponse value,
          $Res Function(GetAllChatroomResponse) then) =
      _$GetAllChatroomResponseCopyWithImpl<$Res, GetAllChatroomResponse>;
  @useResult
  $Res call({List<ChatRoom> data});
}

/// @nodoc
class _$GetAllChatroomResponseCopyWithImpl<$Res,
        $Val extends GetAllChatroomResponse>
    implements $GetAllChatroomResponseCopyWith<$Res> {
  _$GetAllChatroomResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAllChatroomResponseImplCopyWith<$Res>
    implements $GetAllChatroomResponseCopyWith<$Res> {
  factory _$$GetAllChatroomResponseImplCopyWith(
          _$GetAllChatroomResponseImpl value,
          $Res Function(_$GetAllChatroomResponseImpl) then) =
      __$$GetAllChatroomResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatRoom> data});
}

/// @nodoc
class __$$GetAllChatroomResponseImplCopyWithImpl<$Res>
    extends _$GetAllChatroomResponseCopyWithImpl<$Res,
        _$GetAllChatroomResponseImpl>
    implements _$$GetAllChatroomResponseImplCopyWith<$Res> {
  __$$GetAllChatroomResponseImplCopyWithImpl(
      _$GetAllChatroomResponseImpl _value,
      $Res Function(_$GetAllChatroomResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$GetAllChatroomResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllChatroomResponseImpl implements _GetAllChatroomResponse {
  const _$GetAllChatroomResponseImpl({required final List<ChatRoom> data})
      : _data = data;

  factory _$GetAllChatroomResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetAllChatroomResponseImplFromJson(json);

  final List<ChatRoom> _data;
  @override
  List<ChatRoom> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'GetAllChatroomResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllChatroomResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllChatroomResponseImplCopyWith<_$GetAllChatroomResponseImpl>
      get copyWith => __$$GetAllChatroomResponseImplCopyWithImpl<
          _$GetAllChatroomResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllChatroomResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllChatroomResponse implements GetAllChatroomResponse {
  const factory _GetAllChatroomResponse({required final List<ChatRoom> data}) =
      _$GetAllChatroomResponseImpl;

  factory _GetAllChatroomResponse.fromJson(Map<String, dynamic> json) =
      _$GetAllChatroomResponseImpl.fromJson;

  @override
  List<ChatRoom> get data;
  @override
  @JsonKey(ignore: true)
  _$$GetAllChatroomResponseImplCopyWith<_$GetAllChatroomResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get id => throw _privateConstructorUsedError;
  String get idUser => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get chatRoomName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get lastAIMessageText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {String id,
      String idUser,
      DateTime createdAt,
      String chatRoomName,
      String type,
      String? lastAIMessageText});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idUser = null,
    Object? createdAt = null,
    Object? chatRoomName = null,
    Object? type = null,
    Object? lastAIMessageText = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatRoomName: null == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastAIMessageText: freezed == lastAIMessageText
          ? _value.lastAIMessageText
          : lastAIMessageText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
          _$ChatRoomImpl value, $Res Function(_$ChatRoomImpl) then) =
      __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String idUser,
      DateTime createdAt,
      String chatRoomName,
      String type,
      String? lastAIMessageText});
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
      _$ChatRoomImpl _value, $Res Function(_$ChatRoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idUser = null,
    Object? createdAt = null,
    Object? chatRoomName = null,
    Object? type = null,
    Object? lastAIMessageText = freezed,
  }) {
    return _then(_$ChatRoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatRoomName: null == chatRoomName
          ? _value.chatRoomName
          : chatRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastAIMessageText: freezed == lastAIMessageText
          ? _value.lastAIMessageText
          : lastAIMessageText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl(
      {required this.id,
      required this.idUser,
      required this.createdAt,
      required this.chatRoomName,
      required this.type,
      this.lastAIMessageText});

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final String id;
  @override
  final String idUser;
  @override
  final DateTime createdAt;
  @override
  final String chatRoomName;
  @override
  final String type;
  @override
  final String? lastAIMessageText;

  @override
  String toString() {
    return 'ChatRoom(id: $id, idUser: $idUser, createdAt: $createdAt, chatRoomName: $chatRoomName, type: $type, lastAIMessageText: $lastAIMessageText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idUser, idUser) || other.idUser == idUser) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.chatRoomName, chatRoomName) ||
                other.chatRoomName == chatRoomName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastAIMessageText, lastAIMessageText) ||
                other.lastAIMessageText == lastAIMessageText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, idUser, createdAt,
      chatRoomName, type, lastAIMessageText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(
      this,
    );
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom(
      {required final String id,
      required final String idUser,
      required final DateTime createdAt,
      required final String chatRoomName,
      required final String type,
      final String? lastAIMessageText}) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  String get id;
  @override
  String get idUser;
  @override
  DateTime get createdAt;
  @override
  String get chatRoomName;
  @override
  String get type;
  @override
  String? get lastAIMessageText;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
