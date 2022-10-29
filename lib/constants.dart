import 'package:audiojet/screens/routes.dart';
import 'package:audiojet/screens/songlist_screen.dart';
import 'package:flutter/material.dart';

List<Widget> screensList = [
  const HomeScreen(),
  SongListScreen(),
  SongListScreen(
    isFavourite: true,
  ),
  const PlayListScreen()
];
