// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomResponseImpl _$$ChatRoomResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomResponseImpl(
      chatRoomId: json['chatRoomId'] as String,
      chatRoomName: json['chatRoomName'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ChatRoomResponseImplToJson(
        _$ChatRoomResponseImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'type': instance.type,
      'message': instance.message,
    };
