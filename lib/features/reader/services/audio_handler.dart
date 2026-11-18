import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class SanatanAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  SanatanAudioHandler() {
    _init();
  }

  AudioPlayer get player => _player;

  void _init() {
    // Broadcast player state changes to audio service
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final bool playing = _player.playing;
      playbackState.add(
        playbackState.value.copyWith(
          controls: <MediaControl>[
            MediaControl.rewind,
            if (playing) MediaControl.pause else MediaControl.play,
            MediaControl.fastForward,
          ],
          systemActions: const <MediaAction>{
            MediaAction.seek,
            MediaAction.seekForward,
            MediaAction.seekBackward,
          },
          androidCompactActionIndices: const <int>[0, 1, 2],
          processingState: const <ProcessingState, AudioProcessingState>{
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
          playing: playing,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
          queueIndex: event.currentIndex,
        ),
      );
    });
  }

  Future<void> setAudioSource(String url, {required String title, required String author}) async {
    mediaItem.add(
      MediaItem(
        id: url,
        title: title,
        artist: author,
        artUri: Uri.parse('https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=400'),
      ),
    );
    try {
      await _player.setUrl(url);
    } catch (_) {}
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }
}
