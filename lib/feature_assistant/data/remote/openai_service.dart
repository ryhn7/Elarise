import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:elarise/core/utils/config.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/data/remote/api_config.dart';

class OpenAIService {
  final ApiConfig apiConfig;
  late AudioPlayer audioPlayer = AudioPlayer();

  OpenAIService({required this.apiConfig}) {
    audioPlayer = AudioPlayer();
  }

  Future<String?> fetchAndPlaySpeechAudio(String inputText,
      {String model = 'tts-1', String voice = 'nova'}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final data = jsonEncode({
        'model': model,
        'input': inputText,
        'voice': voice,
        'response_format': 'mp3',
      });

      final response = await apiConfig.fetchBinaryData(Configuration.speechUrl,
          headers: headers, body: data);

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/tts.mp3');

        await file.writeAsBytes(bytes);

        await audioPlayer.play(DeviceFileSource(file.path));

        audioPlayer.onPlayerComplete.listen(((event) {
          file.delete().then((_) {
            log('Temporary File deleted');
          }).catchError((error) {
            log('Error while deleting temporary file : $error');
          });
        }));

        return file.path;
      } else {
        log('Failed to load speech audio: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching speech audio: $e');
    }
    return null;
  }

  Future<void> dispose() async {
    await audioPlayer.release();
    await audioPlayer.dispose();
  }
}
