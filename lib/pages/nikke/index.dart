import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/pages/nikke/components/character_view.dart';
import 'package:live2d_viewer/pages/nikke/components/item_list.dart';

class NikkePage extends StatefulWidget {
  const NikkePage({super.key});

  @override
  State<StatefulWidget> createState() => NikkePageState();
}

class NikkePageState extends State<NikkePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedBuilder(
              animation: NikkeConstants.itemListController,
              builder: (context, _) {
                return NikkeConstants.itemListController.visible
                    ? ItemList()
                    : CharacterView();
              }),
        ),
      ],
    );
  }
}
