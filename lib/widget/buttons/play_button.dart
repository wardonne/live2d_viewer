import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class PlayButton extends StatefulWidget {
  final bool paused;
  final dynamic Function() play;
  final dynamic Function() pause;

  const PlayButton({
    super.key,
    this.paused = false,
    required this.play,
    required this.pause,
  });

  @override
  State<StatefulWidget> createState() {
    return PlayButtonState();
  }
}

class PlayButtonState extends State<PlayButton> {
  late bool paused;

  @override
  void initState() {
    paused = widget.paused;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageButton(
      icon: Icon(paused ? Icons.play_arrow_rounded : Icons.pause),
      onPressed: () {
        paused ? widget.play() : widget.pause();
        setState(() {
          paused = !paused;
        });
      },
    );
  }
}
