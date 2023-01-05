import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

class SpeedPopupMenu extends StatelessWidget {
  final List<String> speeds = [
    '0.5',
    '1.0',
    '1.25',
    '1.5',
    '2.0',
  ];
  final WebviewController controller;

  SpeedPopupMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: 20,
      tooltip: 'speed',
      child: const Icon(Icons.double_arrow_rounded, size: 20),
      itemBuilder: (context) => speeds
          .map((speed) => PopupMenuItem(
                height: 15,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text('${speed}x'),
                ),
                onTap: () async =>
                    await controller.executeScript('speedPlay($speed)'),
              ))
          .toList(),
    );
  }
}
