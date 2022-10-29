import 'package:audiojet/page_manager.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:flutter/material.dart';

class CurrentSongArtist extends StatelessWidget {
  const CurrentSongArtist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongArtistNotifier,
      builder: (_, title, __) {
        return Text(title == "" ? "Unknown Artist" : title);
      },
    );
  }
}
