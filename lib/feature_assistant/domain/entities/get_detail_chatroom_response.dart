import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_detail_chatroom_response.freezed.dart';
part 'get_detail_chatroom_response.g.dart';

@freezed
class GetDetailChatroomResponse with _$GetDetailChatroomResponse {
  const factory GetDetailChatroomResponse({
    required String chatRoomId,
    required List<ElaraResponse> data,
  }) = _GetDetailChatroomResponse;

  factory GetDetailChatroomResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDetailChatroomResponseFromJson(json);
}

