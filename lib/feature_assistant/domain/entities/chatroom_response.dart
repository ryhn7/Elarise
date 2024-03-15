import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom_response.freezed.dart';
part 'chatroom_response.g.dart';

@freezed
class ChatRoomResponse with _$ChatRoomResponse {
  const factory ChatRoomResponse({
    required String chatRoomId,
    required String chatRoomName,
    required String type,
    required String message,
  }) = _ChatRoomResponse;

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);
}
