import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/pages/nikke/components/character_card.dart';
import 'package:live2d_viewer/pages/nikke/components/filter_form.dart';
import 'package:live2d_viewer/services/nikke_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends RefreshableState<CharacterList> {
  final visibleController = VisibleController(visible: false);
  final filterController = ValueNotifyWrapper<String>('');
  final service = NikkeService();

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
        title: Text(S.of(context).nikke),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ImageButton(
              icon: const Icon(Icons.search),
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
              filterController: filterController,
              visibleController: visibleController,
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
                animation: filterController,
                builder: (context, _) {
                  return FutureBuilder(
                    future: service.characters(
                      name: filterController.value,
                      reload: _reload,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final items = snapshot.data!;
                        return ListContainer(
                          items: items.map((character) {
                            return CharacterCard(character: character);
                          }).toList(),
                          itemWidth: 100,
                          itemHeight: 270,
                        );
                      } else if (snapshot.hasError) {
                        final error = snapshot.error;
                        debugPrint('$error');
                        return ErrorDialog(
                            message: '${S.of(context).requestError}: $error');
                      } else {
                        final size = MediaQuery.of(context).size;
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: LoadingAnimationWidget.threeArchedCircle(
                            color: Styles.iconColor,
                            size: 30,
                          ),
                        );
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget characterAvatar(CharacterModel character) {
    final cachedNetworkImageKey = GlobalKey<CachedNetworkImageState>();
    return Center(
      child: SizedBox(
        width: 100,
        height: 200,
        child: ContextMenuWrapper(
          itemBuilder: (context) => [
            RefreshWidgetButton(
              widgetKey: cachedNetworkImageKey,
              title: S.of(context).reload,
              height: 40,
              color: Styles.textColor,
              hoverColor: Styles.hoverTextColor,
              backgroundColor: Styles.popupBackgrounColor,
              hoverBackgroundColor: Styles.hoverBackgroundColor,
              child: Container(
                width: 30,
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: const Icon(Icons.refresh),
              ),
              refreshFunction: () {
                Navigator.of(context).pop(context);
                cachedNetworkImageKey.currentState?.reload();
              },
            ),
          ],
          child: CachedNetworkImage(
            key: cachedNetworkImageKey,
            width: 100,
            height: 200,
            path: character.avatarURL,
            placeholder: ResourceConstants.nikkeCharacterDefaultAvatar,
          ),
        ),
      ),
    );
  }
}
