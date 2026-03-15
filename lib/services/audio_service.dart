import 'package:just_audio/just_audio.dart';

/// Singleton audio service backed by just_audio.
/// Wire up UI streams via [positionStream], [durationStream],
/// and [playerStateStream].
class MantrasAudioService {
  MantrasAudioService._();
  static final instance = MantrasAudioService._();

  final AudioPlayer player = AudioPlayer();

  bool get isPlaying => player.playing;

  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;
  Stream<PlayerState> get playerStateStream => player.playerStateStream;

  Future<void> playAsset(String assetPath) async {
    await player.setAsset(assetPath);
    await player.play();
  }

  Future<void> playUrl(String url) async {
    await player.setUrl(url);
    await player.play();
  }

  Future<void> pause() async => player.pause();
  Future<void> resume() async => player.play();
  Future<void> stop() async => player.stop();
  Future<void> seek(Duration position) async => player.seek(position);

  Future<void> setLoopMode(LoopMode mode) async => player.setLoopMode(mode);
  Future<void> setVolume(double volume) async => player.setVolume(volume);

  void dispose() => player.dispose();
}
