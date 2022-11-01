import 'dart:async';

import 'package:audiojet/constants.dart';
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
  bool _isClosing = false;
  @override
  void initState() {
    super.initState();
    stream();
  }

  @override
  void dispose() {
    _isClosing = true;
    super.dispose();
  }

  void stream() {
    Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) => {
              if (allSongs.isNotEmpty)
                {if (!_isClosing) setState(() {}), t.cancel()}
            });
  }

  @override
  Widget build(BuildContext context) {
    widget.isFavourite ??= false;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(90),
          ),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(widget.isFavourite! ? "Favourites" : 'Songs'),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: allSongs.isEmpty
          ? const Center(
              child: Text("Loading"),
            )
          : SongCard(),
    );
  }
}
