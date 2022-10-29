import 'dart:developer';

import 'package:audiojet/notifiers/progress_notifier.dart';
import 'package:audiojet/notifiers/repeat_button_notifier.dart';
import 'package:audiojet/page_manager.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/current_song_artist.dart';
import 'package:audiojet/widgets/current_song_title.dart';
import 'package:audiojet/widgets/player_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../services/service_locator.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // bool isPlaying = true;
  // SongModel song = SongModel({});
  // AudioPlayer audioPlayer = AudioPlayer();

  var data = Get.arguments;
  //Song Related info
  // String songName = 'Iraady';
  // String artistName = 'Abdul Hannan & Rovalio';
  // List<AudioSource> audioSource = [];
  @override
  void initState() {
    super.initState();
    final pageManager = getIt<PageManager>();
    if (data != null) {
      pageManager.listenToPlayCurrentSong(data);
      pageManager.play();
    }

    // audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
    //   // AudioSource.uri(Uri.file(
    //   //     '/storage/emulated/0/Youthoob/Alan Walker & Ava Max - Alone, Pt.2.m4a')),
    //   AudioSource.uri(Uri.file(
    //       '/storage/emulated/0/Youthoob/Asim Azhar - Jo Tu Na Mila.m4a')),
    //   AudioSource.uri(Uri.file(
    //       '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a')),
    // ]));
    // songName = allSongs[data].displayNameWOExt;
    // artistName = allSongs[data].artist!;
    // audioPlayer.setFilePath(allSongs[data].data);
    // audioPlayer.play();
  }

  // void addInPlayList() async {
  //   allSongs.forEach((element) {
  //     audioSource.add(AudioSource.uri(Uri.file(element.data)));
  //   });
  //   setState(() {});
  // }

  // get song cover image colors
  Future<PaletteGenerator> getImageColors() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      const AssetImage('assets/image.png'),
    );
    return paletteGenerator;
  }

  // Stream<SeekBarData> get _seekBarDataStream =>
  //     rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
  //         audioPlayer.positionStream, audioPlayer.durationStream,
  //         (Duration position, Duration? duration) {
  //       return SeekBarData(position, duration ?? Duration.zero);
  //     });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            FutureBuilder<PaletteGenerator>(
              future: getImageColors(),
              builder: (context, snapshot) {
                return Container(
                  color: snapshot.data?.mutedColor?.color,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.7)
                    ])),
              ),
            ),
            Positioned(
              height: size.height / 1.5,
              child: Column(
                children: [
                  CurrentSongTitle(),
                  const SizedBox(
                    height: 5,
                  ),
                  const CurrentSongArtist(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                ],
              ),
            ),
            const Center(
              child: AudioProgressBar(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.3,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Center(
                    child: PlayerButtons(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        RepeatButton(),
                        ShuffleButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? const Icon(Icons.shuffle, size: 30, color: Colors.white)
              : const Icon(Icons.shuffle, size: 30, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, size: 30, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one, size: 30, color: Colors.white);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat, size: 30, color: Colors.white);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatDuration(value.total),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const VerticalDivider(
                    color: Colors.white54,
                    thickness: 2,
                    width: 25,
                    indent: 2,
                    endIndent: 2,
                  ),
                  Text(
                    formatDuration(value.current),
                  )
                ],
              ),
            ),
            CircularSlider(
              position: value.current,
              duration: value.total,
              onChanged: pageManager.seek,
            ),
          ],
        );
      },
    );
  }
}

class CircularSlider extends StatefulWidget {
  CircularSlider({
    Key? key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangedEnd,
  }) : super(key: key);

  final Duration position;
  final Duration duration;
  ValueChanged<Duration>? onChanged;
  ValueChanged<Duration>? onChangedEnd;

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  double? dragValue;

  _decideValue() {
    var tempPositionValue = widget.position.inMilliseconds.toDouble();
    var tempDurationValue = widget.duration.inMilliseconds.toDouble();
    if (tempPositionValue >= 0.0) {
      if (tempPositionValue <= tempDurationValue) {
        return tempPositionValue;
      }
      return tempPositionValue = tempDurationValue;
    }
    return tempPositionValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0.0,
      max: widget.duration.inMilliseconds.toDouble(),
      // initialValue: min(
      //   dragValue ?? widget.position.inMilliseconds.toDouble(),
      //   widget.position.inMilliseconds.toDouble(),
      // ),
      initialValue: dragValue ?? _decideValue(),
      onChange: (value) {
        setState(() {
          dragValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(Duration(milliseconds: value.round()));
        }
      },
      onChangeEnd: (value) {
        if (widget.onChangedEnd != null) {
          widget.onChangedEnd!(Duration(milliseconds: value.round()));
        }
        dragValue = null;
      },
      innerWidget: (percentage) {
        return const Padding(
          padding: EdgeInsets.all(25.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
                'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg'),
          ),
        );
      },
      appearance: CircularSliderAppearance(
          size: 330,
          angleRange: 300,
          startAngle: 300,
          customColors: CustomSliderColors(
              progressBarColor: Colors.deepPurple.shade700,
              dotColor: Colors.deepPurple.shade300,
              trackColor: Colors.grey.withOpacity(.4)),
          customWidths: CustomSliderWidths(
              trackWidth: 6, handlerSize: 10, progressBarWidth: 6)),
    );
  }
}
