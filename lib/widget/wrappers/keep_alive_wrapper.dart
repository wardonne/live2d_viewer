import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final bool keepAlive;
  final Widget child;
  const KeepAliveWrapper(
      {super.key, this.keepAlive = true, required this.child});
  @override
  State<StatefulWidget> createState() {
    return _KeepAliveWrapperState();
  }
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }
}
