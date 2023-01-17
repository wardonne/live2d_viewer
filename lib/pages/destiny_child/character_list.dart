import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/loading_animation.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';

import 'components/components.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() => CharacterListState();
}

class CharacterListState extends State<CharacterList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DestinyChildService().characters(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: items.where((item) => item.enable).map((item) {
                  return CharacterCard(character: item);
                }).toList(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          return const LoadingAnimation(size: 30.0);
        }
      },
    );
  }
}
