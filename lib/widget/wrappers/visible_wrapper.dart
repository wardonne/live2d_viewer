import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';

class VisibleWrapper extends StatelessWidget {
  final VisibleController controller;
  final Widget child;

  const VisibleWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => AnimatedOpacity(
        opacity: controller.visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Visibility(visible: controller.visible, child: child),
      ),
    );
  }
}
