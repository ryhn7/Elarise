import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom_voice_response.freezed.dart';
part 'chatroom_voice_response.g.dart';

@freezed
class ChatRoomVoiceResponse with _$ChatRoomVoiceResponse {
  const factory ChatRoomVoiceResponse({
    required String chatRoomId,
    required String chatRoomName,
    required String type,
    required String message,
  }) = _ChatRoomVoiceResponse;

  factory ChatRoomVoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomVoiceResponseFromJson(json);
}
