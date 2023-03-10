import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/models/destiny_child/models.dart';
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
  final visibleController = VisibleController(visible: false);
  final filterController = ValueNotifyWrapper(FilterFormModel.init());
  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  void showFilter() => visibleController.toggle();

  @override
  void dispose() {
    visibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VisibleWrapper(
          controller: visibleController,
          child: FilterForm(
            visibleController: visibleController,
            filterController: filterController,
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: filterController,
            builder: (context, _) {
              return FutureBuilder(
                future: DestinyChildService().characters(
                    filter: filterController.value, reload: _reload),
                builder: (context, snapshot) {
                  const loading = LoadingAnimation(size: 30.0);
                  if (snapshot.connectionState != ConnectionState.done) {
                    return loading;
                  }
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    return ListContainer(
                      itemWidth: 100,
                      itemHeight: 240,
                      items: items.where((item) => item.enable).map((item) {
                        return CharacterCard(character: item);
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorDialog(message: snapshot.error.toString());
                  } else {
                    return loading;
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
