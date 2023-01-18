import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';

class SoulCartaList extends StatefulWidget {
  const SoulCartaList({super.key});

  @override
  State<StatefulWidget> createState() {
    return SoulCartaListState();
  }
}

class SoulCartaListState extends State<SoulCartaList> {
  final service = DestinyChildService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListContainer(
            items: items
                .where((item) => item.enable)
                .map((item) => SoulCartaCard(soulCarta: item))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          return const LoadingAnimation(size: 30);
        }
      },
      future: service.soulCartas(),
    );
  }
}
