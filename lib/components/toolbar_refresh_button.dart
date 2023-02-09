import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/wrappers/context_menu_wrapper.dart';

class ToolbarRefreshButton extends StatelessWidget {
  final GlobalKey<RefreshableState<StatefulWidget>>? widgetKey;
  final RefreshableState<StatefulWidget>? widgetState;
  const ToolbarRefreshButton({
    super.key,
    this.widgetKey,
    this.widgetState,
  }) : assert(
            (widgetKey != null && widgetState == null) ||
                (widgetKey == null && widgetState != null),
            'widgetKey and widgetState can\'t be set at the same time');

  @override
  Widget build(BuildContext context) {
    return ContextMenuWrapper(
      child: ImageButton.fromIcon(
        icon: Icons.refresh,
        tooltip: S.of(context).reload,
        onPressed: () {
          if (widgetKey != null) {
            widgetKey!.currentState?.reload();
          } else {
            widgetState!.reload();
          }
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
            if (widgetKey != null) {
              widgetKey!.currentState?.reload(forceReload: true);
            } else {
              widgetState!.reload(forceReload: true);
            }
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
