import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/services/app_service.dart';
import 'package:live2d_viewer/services/destiny_child/child_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class ChildTable extends StatelessWidget {
  final ChildTableSource source;
  const ChildTable({
    super.key,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: source,
      builder: (context, child) {
        final startIndex = (source.page - 1) * source.pageSize;
        final endIndex = source.page * source.pageSize - 1;
        final items = source.getRange(startIndex, endIndex);
        return SizedBox(
          height: 600,
          child: ListView.separated(
            itemBuilder: (context, index) => items[index],
            itemCount: items.length,
            separatorBuilder: (context, index) {
              return Container(
                height: 5,
              );
            },
          ),
        );
      },
    );
  }
}

class ChildTableSource extends ChangeNotifier {
  final List<Child> items;
  final int page;
  final int pageSize;
  final DestinyChildSettings destinyChildSettings;
  final ChildService childService;

  ChildTableSource({
    required this.items,
    this.page = 1,
    this.pageSize = 10,
    required this.destinyChildSettings,
  }) : childService = ChildService(destinyChildSettings);

  List<Widget> getRange(int startIndex, int endIndex) {
    final List<Widget> items = [];
    for (var index = startIndex; index < endIndex; index++) {
      final item = getRow(index);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }

  Widget? getRow(int index) {
    final item = items[index];
    final avatarPath = destinyChildSettings.childSettings!.avatarPath;
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: ExpansionTile(
          title: Row(
            children: [
              SizedBox(width: 100, child: Text(item.name)),
              Switch(
                  value: item.enable,
                  onChanged: (value) {
                    items[index].enable = value;
                    childService.save(items, backupBeforeSave: false);
                    notifyListeners();
                  }),
            ],
          ),
          leading: Image.file(File('$avatarPath/${item.avatar}')),
          trailing: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ImageButton(
                  icon: const Icon(Icons.search, size: 20),
                  onPressed: () {
                    ChildService.initViewWindow(item);
                    AppService.unextendSidebar();
                    DestinyChildService.closeItemsWindow();
                  },
                ),
              ),
            ],
          ),
          tilePadding: const EdgeInsets.all(5),
          children: [
            _buildSkinTable(item, index),
          ],
        ),
      ),
    );
  }

  Widget _buildSkinTable(Child item, int index) {
    final avatarPath = destinyChildSettings.childSettings!.avatarPath;
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: DataTable(
              border: TableBorder.all(color: Colors.white24),
              columns: [
                _buildHeaderCell('Index'),
                _buildHeaderCell('Avatar'),
                _buildHeaderCell('Name'),
                _buildHeaderCell('Enable'),
                _buildHeaderCell('Operations'),
              ],
              rows: item.skins.map((skin) {
                return DataRow(cells: [
                  DataCell(Center(child: Text('${index + 1}'))),
                  DataCell(Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                        child: Image.file(File('$avatarPath/${skin.avatar}'))),
                  )),
                  DataCell(Center(child: Text(skin.name))),
                  DataCell(Center(
                    child: Switch(
                      value: skin.enable,
                      onChanged: (value) {
                        final skinIndex = item.skins.indexOf(skin);
                        items[index].skins[skinIndex].enable = value;
                        items[index].avatar = item.skins
                            .firstWhere((element) => element.enable)
                            .avatar;
                        childService.save(items, backupBeforeSave: false);
                        notifyListeners();
                      },
                    ),
                  )),
                  DataCell(Center(
                    child: ButtonBar(
                      children: [
                        ImageButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            ChildService.initViewWindow(item,
                                skinIndex: item.skins.indexOf(skin));
                            AppService.unextendSidebar();
                            DestinyChildService.closeItemsWindow();
                          },
                        )
                      ],
                    ),
                  ))
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  DataColumn _buildHeaderCell(String label) {
    return DataColumn(
      label: Expanded(
        child: Center(child: Text(label)),
      ),
    );
  }
}
