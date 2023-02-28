import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends RefreshableState<CharacterList> {
  FilterFormModel filterFormModel = FilterFormModel();

  final service = AzurlaneService();

  bool _reload = false;

  @override
  void initState() {
    super.initState();
    hotKeyManager.register(
      HotKey(
        KeyCode.keyF,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        _showFilter(context);
      },
    );
  }

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  _showFilter(BuildContext context) {
    Navigator.push<FilterFormModel>(
      context,
      DialogRoute(
        context: context,
        builder: (context) => FilterForm(model: filterFormModel),
      ),
    ).then((value) {
      if (value == null) return;
      setState(() {
        filterFormModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).azurlane),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ImageButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilter(context);
              },
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
      body: FutureBuilder(
        future: service.characters(filter: filterFormModel, reload: _reload),
        builder: (context, snapshot) {
          final size = MediaQuery.of(context).size;
          final loading = SizedBox(
            width: size.width,
            height: size.height,
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Styles.iconColor,
              size: 30,
            ),
          );
          if (snapshot.connectionState != ConnectionState.done) {
            return loading;
          }
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListContainer(
              itemWidth: 120,
              itemHeight: 220,
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
      ),
    );
  }
}
