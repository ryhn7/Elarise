// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_voice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomVoiceResponseImpl _$$ChatRoomVoiceResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomVoiceResponseImpl(
      chatRoomId: json['chatRoomId'] as String,
      chatRoomName: json['chatRoomName'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ChatRoomVoiceResponseImplToJson(
        _$ChatRoomVoiceResponseImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'type': instance.type,
      'message': instance.message,
    };
