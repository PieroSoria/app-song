import 'package:audiojet/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:math';

Random random = Random();

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

String getRandomImage() {
  int randomNumber = 0 + random.nextInt(2);
  return defaultImages[randomNumber];
}
