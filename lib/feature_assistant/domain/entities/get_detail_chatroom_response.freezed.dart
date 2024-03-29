// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_detail_chatroom_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetDetailChatroomResponse _$GetDetailChatroomResponseFromJson(
    Map<String, dynamic> json) {
  return _GetDetailChatroomResponse.fromJson(json);
}

/// @nodoc
mixin _$GetDetailChatroomResponse {
  String get chatRoomId => throw _privateConstructorUsedError;
  List<ElaraResponse> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetDetailChatroomResponseCopyWith<GetDetailChatroomResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetDetailChatroomResponseCopyWith<$Res> {
  factory $GetDetailChatroomResponseCopyWith(GetDetailChatroomResponse value,
          $Res Function(GetDetailChatroomResponse) then) =
      _$GetDetailChatroomResponseCopyWithImpl<$Res, GetDetailChatroomResponse>;
  @useResult
  $Res call({String chatRoomId, List<ElaraResponse> data});
}

/// @nodoc
class _$GetDetailChatroomResponseCopyWithImpl<$Res,
        $Val extends GetDetailChatroomResponse>
    implements $GetDetailChatroomResponseCopyWith<$Res> {
  _$GetDetailChatroomResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ElaraResponse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetDetailChatroomResponseImplCopyWith<$Res>
    implements $GetDetailChatroomResponseCopyWith<$Res> {
  factory _$$GetDetailChatroomResponseImplCopyWith(
          _$GetDetailChatroomResponseImpl value,
          $Res Function(_$GetDetailChatroomResponseImpl) then) =
      __$$GetDetailChatroomResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chatRoomId, List<ElaraResponse> data});
}

/// @nodoc
class __$$GetDetailChatroomResponseImplCopyWithImpl<$Res>
    extends _$GetDetailChatroomResponseCopyWithImpl<$Res,
        _$GetDetailChatroomResponseImpl>
    implements _$$GetDetailChatroomResponseImplCopyWith<$Res> {
  __$$GetDetailChatroomResponseImplCopyWithImpl(
      _$GetDetailChatroomResponseImpl _value,
      $Res Function(_$GetDetailChatroomResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? data = null,
  }) {
    return _then(_$GetDetailChatroomResponseImpl(
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ElaraResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetDetailChatroomResponseImpl implements _GetDetailChatroomResponse {
  const _$GetDetailChatroomResponseImpl(
      {required this.chatRoomId, required final List<ElaraResponse> data})
      : _data = data;

  factory _$GetDetailChatroomResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetDetailChatroomResponseImplFromJson(json);

  @override
  final String chatRoomId;
  final List<ElaraResponse> _data;
  @override
  List<ElaraResponse> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'GetDetailChatroomResponse(chatRoomId: $chatRoomId, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDetailChatroomResponseImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, chatRoomId, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDetailChatroomResponseImplCopyWith<_$GetDetailChatroomResponseImpl>
      get copyWith => __$$GetDetailChatroomResponseImplCopyWithImpl<
          _$GetDetailChatroomResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetDetailChatroomResponseImplToJson(
      this,
    );
  }
}

abstract class _GetDetailChatroomResponse implements GetDetailChatroomResponse {
  const factory _GetDetailChatroomResponse(
          {required final String chatRoomId,
          required final List<ElaraResponse> data}) =
      _$GetDetailChatroomResponseImpl;

  factory _GetDetailChatroomResponse.fromJson(Map<String, dynamic> json) =
      _$GetDetailChatroomResponseImpl.fromJson;

  @override
  String get chatRoomId;
  @override
  List<ElaraResponse> get data;
  @override
  @JsonKey(ignore: true)
  _$$GetDetailChatroomResponseImplCopyWith<_$GetDetailChatroomResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
