import 'package:audiojet/page_manager.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class CurrentSongTitle extends StatefulWidget {
  bool? isMinimized;
  CurrentSongTitle({Key? key, this.isMinimized}) : super(key: key);

  @override
  State<CurrentSongTitle> createState() => _CurrentSongTitleState();
}

class _CurrentSongTitleState extends State<CurrentSongTitle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isMinimized ??= false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return SizedBox(
          height: widget.isMinimized! ? 20 : 50,
          width: size.width / 1.2,
          child: Marquee(
            text: title,
            startAfter: const Duration(seconds: 3),
            style: TextStyle(
                fontSize: widget.isMinimized! ? 14 : 24,
                fontWeight: FontWeight.bold),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 80.0,
            pauseAfterRound: const Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        );
      },
    );
  }
}
