import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';

class SoulCartaList extends StatefulWidget {
  const SoulCartaList({super.key});

  @override
  State<StatefulWidget> createState() {
    return SoulCartaListState();
  }
}

class SoulCartaListState extends RefreshableState<SoulCartaList> {
  final service = DestinyChildService();

  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    if (forceReload) {
      setState(() {
        _reload = true;
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.soulCartas(reload: _reload),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _reload = false;
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
    );
  }
}
