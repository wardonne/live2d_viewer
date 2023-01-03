import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/nikki.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/widget/toolbar.dart';

class NikkiPage extends StatefulWidget {
  const NikkiPage({super.key});

  @override
  State<StatefulWidget> createState() => NikkiPageState();
}

class NikkiPageState extends State<NikkiPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Visibility(
            child: Column(
              children: [
                Toolbar.header(
                  height: headerBarHeight,
                  color: barColor,
                  title: const Center(
                    child: Text(NikkiConstants.menuName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
