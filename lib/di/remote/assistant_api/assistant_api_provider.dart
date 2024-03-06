import 'package:elarise/di/remote/api_config/api_config_provider.dart';
import 'package:elarise/feature_assistant/data/remote/assistant_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assistant_api_provider.g.dart';

@riverpod
AssistantApi assistantApi(AssistantApiRef ref) => AssistantApi(apiConfig: ref.watch(apiConfigProvider));