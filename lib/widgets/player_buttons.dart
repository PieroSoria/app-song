import 'package:audiojet/notifiers/play_button_notifier.dart';
import 'package:audiojet/page_manager.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:flutter/material.dart';

class PlayerButtons extends StatefulWidget {
  bool? isMinimized;

  PlayerButtons({Key? key, this.isMinimized}) : super(key: key);

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    widget.isMinimized ??= false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PreviousSongButton(isMinimized: widget.isMinimized!),
        PlayButton(isMinimized: widget.isMinimized!),
        NextSongButton(isMinimized: widget.isMinimized!)
      ],
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  final bool isMinimized;
  const PreviousSongButton({Key? key, required this.isMinimized})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          iconSize: isMinimized ? 35 : 45,
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  final bool isMinimized;
  const PlayButton({Key? key, required this.isMinimized}) : super(key: key);

  Icon getIcon(iconData) {
    return Icon(
      iconData,
      // size: isMinimized ? 35 : 75,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return IconButton(
              iconSize: isMinimized ? 35 : 75,
              icon: getIcon(Icons.pause_circle),
              onPressed: pageManager.play,
            );
          case ButtonState.paused:
            return IconButton(
              iconSize: isMinimized ? 35 : 75,
              icon: getIcon(Icons.play_circle),
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              iconSize: isMinimized ? 35 : 75,
              icon: getIcon(Icons.pause_circle),
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  final bool isMinimized;
  const NextSongButton({Key? key, required this.isMinimized}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
            iconSize: isMinimized ? 35 : 45,
            onPressed: (isLast) ? null : pageManager.next,
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
            ));
      },
    );
  }
}
