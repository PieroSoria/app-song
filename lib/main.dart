import 'package:audiojet/page_manager.dart';
import 'package:audiojet/screens/songlist_screen.dart';
import 'package:audiojet/screens/tab_window.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:audiojet/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/routes.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() async {
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    //after initalizing we will set a
    //listener to identify which song is playing and set the index accordingly
    PageManager().currentSongIndexNotifier.addListener(() {});
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Audio Jet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: const TabWindow(),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/song', page: () => const PlayerScreen()),
        GetPage(name: '/playlist', page: () => const PlayListShowScreen()),
      ],
    );
  }
}
