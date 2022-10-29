import 'package:audiojet/utils.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class PlaylistRepository {
  Future<List<SongModel>> fetchInitialPlaylist();
}

class DemoPlaylist extends PlaylistRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Future<List<SongModel>> fetchInitialPlaylist() async {
    return _audioQuery.querySongs();
  }
}
