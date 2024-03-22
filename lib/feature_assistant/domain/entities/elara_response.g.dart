// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elara_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElaraResponseImpl _$$ElaraResponseImplFromJson(Map<String, dynamic> json) =>
    _$ElaraResponseImpl(
      idMessage: json['idMessage'] as String? ?? '',
      idAIMessage: json['idAIMessage'] as String? ?? '',
      message: json['message'] as String,
      isUserMessage: json['isUserMessage'] as bool? ?? false,
      isPlaceholder: json['isPlaceholder'] as bool? ?? false,
    );

Map<String, dynamic> _$$ElaraResponseImplToJson(_$ElaraResponseImpl instance) =>
    <String, dynamic>{
      'idMessage': instance.idMessage,
      'idAIMessage': instance.idAIMessage,
      'message': instance.message,
      'isUserMessage': instance.isUserMessage,
      'isPlaceholder': instance.isPlaceholder,
    };
