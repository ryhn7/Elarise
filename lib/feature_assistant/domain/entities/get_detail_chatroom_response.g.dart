// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetDetailChatroomResponseImpl _$$GetDetailChatroomResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetDetailChatroomResponseImpl(
      chatRoomId: json['chatRoomId'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ElaraResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetDetailChatroomResponseImplToJson(
        _$GetDetailChatroomResponseImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'data': instance.data,
    };
