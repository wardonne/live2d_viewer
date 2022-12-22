import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/constants/controllers.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/services/destiny_child/child_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class ChildGrid extends StatelessWidget {
  final List<Child> children;
  final DestinyChildSettings destinyChildSettings;
  const ChildGrid({
    super.key,
    required this.children,
    required this.destinyChildSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children.map((item) {
        return Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(5),
          child: ImageButton.fromFile(
            filepath:
                '${destinyChildSettings.childSettings!.avatarPath}/${item.avatar}',
            onPressed: () {
              ChildService.initViewWindow(item);
              sideBarController.setExtended(false);
              DestinyChildService.closeItemsWindow();
            },
          ),
        );
      }).toList(),
    );
  }
}
