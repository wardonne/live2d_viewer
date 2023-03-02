import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/models.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/services/girl_frontline_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/wrappers/wrapper.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends RefreshableState<CharacterList> {
  final visibleController = VisibleController(visible: false);
  final filterController = ValueNotifyWrapper(FilterFormModel.init());
  final service = GirlFrontlineService();

  bool _reload = false;

  @override
  void initState() {
    super.initState();
    hotKeyManager.register(
      HotKeys.find,
      keyDownHandler: (hotKey) {
        if (ModalRoute.of(context)!.isCurrent) {
          visibleController.toggle();
        }
      },
    );
  }

  @override
  void dispose() {
    hotKeyManager.unregister(HotKeys.find);
    visibleController.dispose();
    filterController.dispose();
    super.dispose();
  }

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).girlFrontline),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ImageButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => visibleController.toggle(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ToolbarRefreshButton(widgetState: this),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          )
        ],
      ),
      body: Column(
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
                    future: service.characters(
                      filter: filterController.value,
                      reload: _reload,
                    ),
                    builder: (context, snapshot) {
                      const loading = LoadingAnimation(size: 30);
                      if (snapshot.connectionState != ConnectionState.done) {
                        return loading;
                      }
                      if (snapshot.hasData) {
                        final items = snapshot.data!;
                        return ListContainer(
                          itemWidth: 170,
                          itemHeight: 320,
                          items: items.map((item) {
                            return CharacterCard(
                              character: item,
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        final error = snapshot.error;
                        debugPrint('$error');
                        return ErrorDialog(
                            message: '${S.of(context).requestError}: $error');
                      } else {
                        return loading;
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
