import 'package:audiojet/screens/playlist_screen.dart';
import 'package:audiojet/screens/routes.dart';
import 'package:audiojet/screens/songlist_screen.dart';
import 'package:flutter/material.dart';

//Colors
var primaryColor = const Color.fromARGB(228, 48, 49, 80);
var cardColor = const Color.fromARGB(227, 61, 63, 103);
var appBarColor = Color.fromARGB(245, 35, 35, 56);

//playerScreenIcon
String playerScreenIcon = defaultImages[0];
//currentSongIndex
int currentSongIndex = 0;
List<String> defaultImages = [
  'assets/iimg1.jpg',
  // 'assets/iimg2.jpg',
  'assets/iimg3.jpg'
];

List<Widget> screensList = [
  const HomeScreen(),
  SongListScreen(),
  SongListScreen(
    isFavourite: true,
  ),
  const PlayListScreen()
];
