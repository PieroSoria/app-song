import 'package:audiojet/constants.dart';
import 'package:audiojet/utils.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            // backgroundImage: NetworkImage(
            //     'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg'),
            backgroundImage: AssetImage(playerScreenIcon),
          ),
        );
      },

      appearance: CircularSliderAppearance(
          size: 330,
          angleRange: 300,
          startAngle: 300,
          customColors: CustomSliderColors(
              progressBarColor: const Color.fromARGB(255, 121, 74, 232),
              dotColor: Colors.deepPurple.shade300,
              trackColor: Colors.grey.withOpacity(.4)),
          customWidths: CustomSliderWidths(
              trackWidth: 6, handlerSize: 8, progressBarWidth: 7)),
    );
  }
}
