import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final double? size;
  const LoadingAnimation({super.key, this.size = Styles.iconSize});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Styles.iconColor,
          size: Styles.iconSize,
        ),
      ),
    );
  }
}
