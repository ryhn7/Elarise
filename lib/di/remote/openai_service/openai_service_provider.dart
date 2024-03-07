import 'package:elarise/feature_assistant/data/remote/openai_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_config/api_config_provider.dart';

part 'openai_service_provider.g.dart';

@riverpod
OpenAIService openAIService(OpenAIServiceRef ref) =>
    OpenAIService(apiConfig: ref.watch(apiConfigProvider));
