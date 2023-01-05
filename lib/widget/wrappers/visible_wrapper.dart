import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';

class VisibleWrapper extends StatelessWidget {
  final VisibleController _controller;
  final Widget child;

  const VisibleWrapper({
    super.key,
    required VisibleController controller,
    required this.child,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          Visibility(visible: _controller.visible, child: this.child),
    );
  }
}
