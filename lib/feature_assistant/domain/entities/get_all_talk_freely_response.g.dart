// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_talk_freely_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAllTalkFreelyResponseImpl _$$GetAllTalkFreelyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAllTalkFreelyResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => TalkFreelyChatRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetAllTalkFreelyResponseImplToJson(
        _$GetAllTalkFreelyResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$TalkFreelyChatRoomImpl _$$TalkFreelyChatRoomImplFromJson(
        Map<String, dynamic> json) =>
    _$TalkFreelyChatRoomImpl(
      id: json['id'] as String,
      idUser: json['idUser'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      chatRoomName: json['chatRoomName'] as String,
      type: json['type'] as String,
      lastAIMessageText: json['lastAIMessageText'] as String?,
    );

Map<String, dynamic> _$$TalkFreelyChatRoomImplToJson(
        _$TalkFreelyChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idUser': instance.idUser,
      'createdAt': instance.createdAt.toIso8601String(),
      'chatRoomName': instance.chatRoomName,
      'type': instance.type,
      'lastAIMessageText': instance.lastAIMessageText,
    };
