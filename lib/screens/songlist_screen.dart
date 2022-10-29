import 'dart:async';

import 'package:audiojet/page_manager.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/current_song_artist.dart';
import 'package:audiojet/widgets/current_song_title.dart';
import 'package:audiojet/widgets/player_buttons.dart';
import 'package:audiojet/widgets/song_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class SongListScreen extends StatefulWidget {
  SongListScreen({this.isFavourite, super.key});
  bool? isFavourite;

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  @override
  void initState() {
    super.initState();
    stream();
  }

  void stream() {
    Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) => {
              if (allSongs.isNotEmpty) {setState(() {}), t.cancel()}
            });
  }

  @override
  Widget build(BuildContext context) {
    widget.isFavourite ??= false;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.isFavourite! ? "Favourites" : 'Songs'),
          centerTitle: true,
        ),
        body: allSongs.isEmpty
            ? const Center(
                child: Text("Loading"),
              )
            : Stack(
                children: [
                  SongCard(),
                  Positioned(
                      bottom: 15,
                      child: Container(
                          height: 80,
                          width: size.width,
                          child: const MusicCardMinimised()))
                ],
              ),
      ),
    );
  }
}

class MusicCardMinimised extends StatelessWidget {
  const MusicCardMinimised({super.key});

  Future<PaletteGenerator> getImageColors() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      const AssetImage('assets/image.png'),
    );
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(
          '/song',
        )
       },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 84, 76, 76),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg',
                  fit: BoxFit.fill,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentSongTitle(
                    isMinimized: true,
                  ),
                  const CurrentSongArtist()
                ],
              ),
            ),
            Expanded(
              child: PlayerButtons(
                isMinimized: true,
              ),
            )
          ],
        ),
      ),
    );

    //  ListTile(
    //   leading: ,
    //   title: const ,
    //   subtitle: const CurrentSongArtist(),
    //   trailing: ,
    // );
  }
}
