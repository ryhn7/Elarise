import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_talk_freely_response.freezed.dart';
part 'get_all_talk_freely_response.g.dart';

@freezed
class GetAllTalkFreelyResponse with _$GetAllTalkFreelyResponse {
  const factory GetAllTalkFreelyResponse({
    required List<TalkFreelyChatRoom> data,
  }) = _GetAllTalkFreelyResponse;

  factory GetAllTalkFreelyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllTalkFreelyResponseFromJson(json);
}

@freezed
class TalkFreelyChatRoom with _$TalkFreelyChatRoom {
  const factory TalkFreelyChatRoom({
    required String id,
    required String idUser,
    required DateTime createdAt,
    required String chatRoomName,
    required String type,
    String? lastAIMessageText,
  }) = _TalkFreelyChatRoom;

  factory TalkFreelyChatRoom.fromJson(Map<String, dynamic> json) =>
      _$TalkFreelyChatRoomFromJson(json);
}
