import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_chatroom_response.freezed.dart';
part 'get_all_chatroom_response.g.dart';

@freezed
class GetAllChatroomResponse with _$GetAllChatroomResponse {
  const factory GetAllChatroomResponse({
    required List<ChatRoom> data,
  }) = _GetAllChatroomResponse;

  factory GetAllChatroomResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllChatroomResponseFromJson(json);
}

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String idUser,
    required DateTime createdAt,
    required String chatRoomName,
    required String type,
    String? lastAIMessageText,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
