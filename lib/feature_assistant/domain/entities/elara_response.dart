import 'package:freezed_annotation/freezed_annotation.dart';

part 'elara_response.freezed.dart';
part 'elara_response.g.dart';

@freezed
class ElaraResponse with _$ElaraResponse {

  const factory ElaraResponse({
    required String message,
    @Default(false) bool isUserMessage,
    @Default(false) bool isPlaceholder,
  }) = _ElaraResponse;

  factory ElaraResponse.fromJson(Map<String, dynamic> json) => _$ElaraResponseFromJson(json);
}