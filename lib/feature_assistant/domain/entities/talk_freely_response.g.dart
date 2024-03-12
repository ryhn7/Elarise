// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_freely_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TalkFreelyResponseImpl _$$TalkFreelyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TalkFreelyResponseImpl(
      message: json['message'] as String,
      isUserMessage: json['isUserMessage'] as bool? ?? false,
      isPlaceholder: json['isPlaceholder'] as bool? ?? false,
    );

Map<String, dynamic> _$$TalkFreelyResponseImplToJson(
        _$TalkFreelyResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'isUserMessage': instance.isUserMessage,
      'isPlaceholder': instance.isPlaceholder,
    };
