import 'package:elarise/core/data/remote/api_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_config_provider.g.dart';

@riverpod
ApiConfig apiConfig(ApiConfigRef ref) => ApiConfig();