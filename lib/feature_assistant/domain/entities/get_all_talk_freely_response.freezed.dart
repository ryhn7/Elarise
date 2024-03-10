// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_talk_freely_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetAllTalkFreelyResponse _$GetAllTalkFreelyResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllTalkFreelyResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllTalkFreelyResponse {
  List<TalkFreelyChatRoom> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAllTalkFreelyResponseCopyWith<GetAllTalkFreelyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllTalkFreelyResponseCopyWith<$Res> {
  factory $GetAllTalkFreelyResponseCopyWith(GetAllTalkFreelyResponse value,
          $Res Function(GetAllTalkFreelyResponse) then) =
      _$GetAllTalkFreelyResponseCopyWithImpl<$Res, GetAllTalkFreelyResponse>;
  @useResult
  $Res call({List<TalkFreelyChatRoom> data});
}

/// @nodoc
class _$GetAllTalkFreelyResponseCopyWithImpl<$Res,
        $Val extends GetAllTalkFreelyResponse>
    implements $GetAllTalkFreelyResponseCopyWith<$Res> {
  _$GetAllTalkFreelyResponseCopyWithImpl(this._value, this._then);

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
              as List<TalkFreelyChatRoom>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAllTalkFreelyResponseImplCopyWith<$Res>
    implements $GetAllTalkFreelyResponseCopyWith<$Res> {
  factory _$$GetAllTalkFreelyResponseImplCopyWith(
          _$GetAllTalkFreelyResponseImpl value,
          $Res Function(_$GetAllTalkFreelyResponseImpl) then) =
      __$$GetAllTalkFreelyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TalkFreelyChatRoom> data});
}

/// @nodoc
class __$$GetAllTalkFreelyResponseImplCopyWithImpl<$Res>
    extends _$GetAllTalkFreelyResponseCopyWithImpl<$Res,
        _$GetAllTalkFreelyResponseImpl>
    implements _$$GetAllTalkFreelyResponseImplCopyWith<$Res> {
  __$$GetAllTalkFreelyResponseImplCopyWithImpl(
      _$GetAllTalkFreelyResponseImpl _value,
      $Res Function(_$GetAllTalkFreelyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$GetAllTalkFreelyResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TalkFreelyChatRoom>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllTalkFreelyResponseImpl implements _GetAllTalkFreelyResponse {
  const _$GetAllTalkFreelyResponseImpl(
      {required final List<TalkFreelyChatRoom> data})
      : _data = data;

  factory _$GetAllTalkFreelyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetAllTalkFreelyResponseImplFromJson(json);

  final List<TalkFreelyChatRoom> _data;
  @override
  List<TalkFreelyChatRoom> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'GetAllTalkFreelyResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllTalkFreelyResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllTalkFreelyResponseImplCopyWith<_$GetAllTalkFreelyResponseImpl>
      get copyWith => __$$GetAllTalkFreelyResponseImplCopyWithImpl<
          _$GetAllTalkFreelyResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllTalkFreelyResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllTalkFreelyResponse implements GetAllTalkFreelyResponse {
  const factory _GetAllTalkFreelyResponse(
          {required final List<TalkFreelyChatRoom> data}) =
      _$GetAllTalkFreelyResponseImpl;

  factory _GetAllTalkFreelyResponse.fromJson(Map<String, dynamic> json) =
      _$GetAllTalkFreelyResponseImpl.fromJson;

  @override
  List<TalkFreelyChatRoom> get data;
  @override
  @JsonKey(ignore: true)
  _$$GetAllTalkFreelyResponseImplCopyWith<_$GetAllTalkFreelyResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TalkFreelyChatRoom _$TalkFreelyChatRoomFromJson(Map<String, dynamic> json) {
  return _TalkFreelyChatRoom.fromJson(json);
}

/// @nodoc
mixin _$TalkFreelyChatRoom {
  String get id => throw _privateConstructorUsedError;
  String get idUser => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get chatRoomName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TalkFreelyChatRoomCopyWith<TalkFreelyChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkFreelyChatRoomCopyWith<$Res> {
  factory $TalkFreelyChatRoomCopyWith(
          TalkFreelyChatRoom value, $Res Function(TalkFreelyChatRoom) then) =
      _$TalkFreelyChatRoomCopyWithImpl<$Res, TalkFreelyChatRoom>;
  @useResult
  $Res call(
      {String id,
      String idUser,
      DateTime createdAt,
      String chatRoomName,
      String type});
}

/// @nodoc
class _$TalkFreelyChatRoomCopyWithImpl<$Res, $Val extends TalkFreelyChatRoom>
    implements $TalkFreelyChatRoomCopyWith<$Res> {
  _$TalkFreelyChatRoomCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalkFreelyChatRoomImplCopyWith<$Res>
    implements $TalkFreelyChatRoomCopyWith<$Res> {
  factory _$$TalkFreelyChatRoomImplCopyWith(_$TalkFreelyChatRoomImpl value,
          $Res Function(_$TalkFreelyChatRoomImpl) then) =
      __$$TalkFreelyChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String idUser,
      DateTime createdAt,
      String chatRoomName,
      String type});
}

/// @nodoc
class __$$TalkFreelyChatRoomImplCopyWithImpl<$Res>
    extends _$TalkFreelyChatRoomCopyWithImpl<$Res, _$TalkFreelyChatRoomImpl>
    implements _$$TalkFreelyChatRoomImplCopyWith<$Res> {
  __$$TalkFreelyChatRoomImplCopyWithImpl(_$TalkFreelyChatRoomImpl _value,
      $Res Function(_$TalkFreelyChatRoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idUser = null,
    Object? createdAt = null,
    Object? chatRoomName = null,
    Object? type = null,
  }) {
    return _then(_$TalkFreelyChatRoomImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TalkFreelyChatRoomImpl implements _TalkFreelyChatRoom {
  const _$TalkFreelyChatRoomImpl(
      {required this.id,
      required this.idUser,
      required this.createdAt,
      required this.chatRoomName,
      required this.type});

  factory _$TalkFreelyChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$TalkFreelyChatRoomImplFromJson(json);

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
  String toString() {
    return 'TalkFreelyChatRoom(id: $id, idUser: $idUser, createdAt: $createdAt, chatRoomName: $chatRoomName, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalkFreelyChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idUser, idUser) || other.idUser == idUser) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.chatRoomName, chatRoomName) ||
                other.chatRoomName == chatRoomName) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, idUser, createdAt, chatRoomName, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TalkFreelyChatRoomImplCopyWith<_$TalkFreelyChatRoomImpl> get copyWith =>
      __$$TalkFreelyChatRoomImplCopyWithImpl<_$TalkFreelyChatRoomImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TalkFreelyChatRoomImplToJson(
      this,
    );
  }
}

abstract class _TalkFreelyChatRoom implements TalkFreelyChatRoom {
  const factory _TalkFreelyChatRoom(
      {required final String id,
      required final String idUser,
      required final DateTime createdAt,
      required final String chatRoomName,
      required final String type}) = _$TalkFreelyChatRoomImpl;

  factory _TalkFreelyChatRoom.fromJson(Map<String, dynamic> json) =
      _$TalkFreelyChatRoomImpl.fromJson;

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
  @JsonKey(ignore: true)
  _$$TalkFreelyChatRoomImplCopyWith<_$TalkFreelyChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
