import 'dart:math';

import 'package:audiojet/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;
  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  ValueChanged<Duration>? onChanged;
  ValueChanged<Duration>? onChangedEnd;

  SeekBar(
      {required this.position,
      required this.duration,
      this.onChanged,
      this.onChangedEnd,
      super.key});

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? dragValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                        disabledThumbRadius: 4, enabledThumbRadius: 4),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 10),
                    activeTrackColor: Colors.white.withOpacity(0.2),
                    inactiveTrackColor: Colors.white,
                    thumbColor: Colors.white,
                    overlayColor: Colors.white),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(
                    dragValue ?? widget.position.inMilliseconds.toDouble(),
                    widget.position.inMilliseconds.toDouble(),
                  ),
                  // value: dragValue != null
                  //     ? dragValue!
                  //     : widget.position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangedEnd != null) {
                      widget
                          .onChangedEnd!(Duration(milliseconds: value.round()));
                    }
                    dragValue = null;
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatDuration(widget.position)),
                    Text(formatDuration(widget.duration)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
