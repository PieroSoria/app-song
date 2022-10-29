import 'package:on_audio_query/on_audio_query.dart';

//List of all the songs in device
List<SongModel> allSongs = List.empty(growable: true);

//List of all the playLists in device
List<PlaylistModel> playList = List.empty(growable: true);

String formatDuration(Duration? duration) {
  if (duration == null) {
    return '--:--';
  } else {
    String min = duration.inMinutes.toString().padLeft(2, "0");
    String sec = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$min:$sec";
  }
}
