import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/wrappers/context_menu_wrapper.dart';

class ToolbarRefreshButton extends StatelessWidget {
  final GlobalKey<RefreshableState<StatefulWidget>> widgetKey;
  const ToolbarRefreshButton({
    super.key,
    required this.widgetKey,
  });

  @override
  Widget build(BuildContext context) {
    return ContextMenuWrapper(
      child: ImageButton.fromIcon(
        icon: Icons.refresh,
        tooltip: S.of(context).reload,
        onPressed: () {
          widgetKey.currentState?.reload();
        },
      ),
      itemBuilder: (context) => [
        RefreshWidgetButton(
          widgetKey: widgetKey,
          height: 40.0,
          backgroundColor: Styles.popupBackgrounColor,
          hoverBackgroundColor: Styles.hoverBackgroundColor,
          color: Styles.textColor,
          hoverColor: Styles.hoverTextColor,
          title: S.of(context).forceReload,
          beforeRefresh: Navigator.of(context).pop,
          refreshFunction: () {
            (widgetKey.currentState!).reload(forceReload: true);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }
}
