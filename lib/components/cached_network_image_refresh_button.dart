import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/cached_network_image.dart';

class CachedNetworkImageRefreshMenuItem extends StatelessWidget {
  final GlobalKey<CachedNetworkImageState> widgetKey;

  const CachedNetworkImageRefreshMenuItem({super.key, required this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return RefreshWidgetButton(
      widgetKey: widgetKey,
      height: 40.0,
      backgroundColor: Styles.popupBackgrounColor,
      hoverBackgroundColor: Styles.hoverBackgroundColor,
      color: Styles.textColor,
      hoverColor: Styles.hoverTextColor,
      title: S.of(context).reload,
      beforeRefresh: Navigator.of(context).pop,
      refreshFunction: () {
        (widgetKey.currentState!).reload();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
