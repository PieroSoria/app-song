import 'package:on_audio_query/on_audio_query.dart';

class MySongModel extends SongModel {
  bool isFav = false;
  SongModel songModel;
  MySongModel(
    this.isFav,
    this.songModel,
  ) : super(songModel.getMap);
}
