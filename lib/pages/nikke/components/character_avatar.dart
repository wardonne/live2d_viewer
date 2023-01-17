import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/widget.dart';

class CharacterAvatar extends StatelessWidget {
  final String avatar;
  CharacterAvatar({super.key, required this.avatar});

  final _imageKey = GlobalKey<CachedNetworkImageState>();

  Widget _refreshMenuItem(BuildContext context) {
    return RefreshWidgetButton(
      widgetKey: _imageKey,
      height: 40,
      color: Styles.textColor,
      hoverColor: Styles.hoverTextColor,
      backgroundColor: Styles.popupBackgrounColor,
      hoverBackgroundColor: Styles.hoverBackgroundColor,
      title: S.of(context).reload,
      beforeRefresh: Navigator.of(context).pop,
      refreshFunction: _imageKey.currentState?.reload,
      child: Container(
        width: 30,
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 160,
        child: ContextMenuWrapper(
          itemBuilder: (context) => [
            _refreshMenuItem(context),
          ],
          child: CachedNetworkImage(
            key: _imageKey,
            width: 100,
            height: 180,
            path: avatar,
            placeholder: ResourceConstants.nikkeCharacterDefaultAvatar,
          ),
        ),
      ),
    );
  }
}
