import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/widget.dart';

import 'components/components.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() => CharacterListState();
}

class CharacterListState extends RefreshableState<CharacterList> {
  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DestinyChildService().characters(reload: _reload),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListContainer(
            width: 100,
            height: 240,
            items: items.where((item) => item.enable).map((item) {
              return CharacterCard(character: item);
            }).toList(),
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
