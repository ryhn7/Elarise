import 'package:freezed_annotation/freezed_annotation.dart';

part 'talk_freely_response.freezed.dart';
part 'talk_freely_response.g.dart';

@freezed
class TalkFreelyResponse with _$TalkFreelyResponse {

  const factory TalkFreelyResponse({
    required String message,
    @Default(false) bool isUserMessage,
  }) = _TalkFreelyResponse;

  factory TalkFreelyResponse.fromJson(Map<String, dynamic> json) => _$TalkFreelyResponseFromJson(json);
}