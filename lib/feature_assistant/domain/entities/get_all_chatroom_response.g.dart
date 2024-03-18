// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAllChatroomResponseImpl _$$GetAllChatroomResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAllChatroomResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetAllChatroomResponseImplToJson(
        _$GetAllChatroomResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      id: json['id'] as String,
      idUser: json['idUser'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      chatRoomName: json['chatRoomName'] as String,
      type: json['type'] as String,
      lastAIMessageText: json['lastAIMessageText'] as String?,
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idUser': instance.idUser,
      'createdAt': instance.createdAt.toIso8601String(),
      'chatRoomName': instance.chatRoomName,
      'type': instance.type,
      'lastAIMessageText': instance.lastAIMessageText,
    };
