// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elara_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElaraResponseImpl _$$ElaraResponseImplFromJson(Map<String, dynamic> json) =>
    _$ElaraResponseImpl(
      message: json['message'] as String,
      isUserMessage: json['isUserMessage'] as bool? ?? false,
      isPlaceholder: json['isPlaceholder'] as bool? ?? false,
    );

Map<String, dynamic> _$$ElaraResponseImplToJson(_$ElaraResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'isUserMessage': instance.isUserMessage,
      'isPlaceholder': instance.isPlaceholder,
    };
