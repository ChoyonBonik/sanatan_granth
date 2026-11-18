import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused }

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _state = TtsState.stopped;

  TtsState get state => _state;

  Future<void> initialize() async {
    await _flutterTts.setSpeechRate(0.45); // Slower, solemn pace for sacred verses
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);

    _flutterTts.setStartHandler(() {
      _state = TtsState.playing;
    });

    _flutterTts.setCompletionHandler(() {
      _state = TtsState.stopped;
    });

    _flutterTts.setErrorHandler((dynamic msg) {
      _state = TtsState.stopped;
    });
  }

  Future<void> speak({
    required String text,
    String languageCode = 'sa-IN', // Defaults to Sanskrit/Hindi
  }) async {
    // Select best speech language
    if (languageCode == 'bn' || languageCode == 'bn-IN' || languageCode == 'bn-BD') {
      await _flutterTts.setLanguage('bn-IN');
    } else if (languageCode == 'sa' || languageCode == 'sa-IN' || languageCode == 'hi-IN') {
      await _flutterTts.setLanguage('hi-IN');
    } else {
      await _flutterTts.setLanguage('en-US');
    }

    _state = TtsState.playing;
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    _state = TtsState.stopped;
    await _flutterTts.stop();
  }

  Future<void> pause() async {
    _state = TtsState.paused;
    await _flutterTts.pause();
  }

  void setCompletionHandler(void Function() handler) {
    _flutterTts.setCompletionHandler(handler);
  }

  void setProgressHandler(void Function(String text, int start, int end, String word) handler) {
    _flutterTts.setProgressHandler(handler);
  }
}
