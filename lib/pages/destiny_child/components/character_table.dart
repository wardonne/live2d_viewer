import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/paginator_controller.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/services/destiny_child/character_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/paginator.dart';

class CharacterTable extends StatelessWidget {
  final PaginatorController source;
  const CharacterTable({
    super.key,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: source,
      builder: (context, child) {
        final startIndex = (source.page - 1) * source.pageSize;
        var endIndex = source.page * source.pageSize - 1;
        endIndex = endIndex > (source.total - 1) ? source.total - 1 : endIndex;
        final items = source.getRange(startIndex, endIndex);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 540,
              child: ListView.separated(
                itemBuilder: (context, index) => items[index],
                itemCount: items.length,
                separatorBuilder: (context, index) {
                  return Container(
                    height: 5,
                  );
                },
              ),
            ),
            Paginator(
              controller: source,
              startIndex: startIndex,
              endIndex: endIndex,
            ),
          ],
        );
      },
    );
  }
}

class CharacterTableSource extends PaginatorController<Character> {
  final DestinyChildSettings destinyChildSettings;
  final CharacterService characterService;

  CharacterTableSource({
    required super.items,
    super.page = 1,
    super.pageSize = 8,
    required this.destinyChildSettings,
  }) : characterService = CharacterService(destinyChildSettings);

  @override
  int get total => items.length;

  @override
  List<Widget> getRange(int startIndex, int endIndex) {
    final List<Widget> items = [];
    for (var index = startIndex; index <= endIndex; index++) {
      final item = getRow(index);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }

  @override
  Widget? getRow(int index) {
    final item = items[index];
    final avatarPath = destinyChildSettings.characterSettings!.avatarPath;
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
                    characterService.save(items, backupBeforeSave: false);
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
                    CharacterService.initViewWindow(item);
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

  Widget _buildSkinTable(Character item, int index) {
    final avatarPath = destinyChildSettings.characterSettings!.avatarPath;
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
                  DataCell(
                      Center(child: Text('${item.skins.indexOf(skin) + 1}'))),
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
                        bool allSkinDisabled = false;
                        final skinIndex = item.skins.indexOf(skin);
                        items[index].skins[skinIndex].enable = value;
                        items[index].avatar = item.skins.firstWhere(
                          (element) => element.enable,
                          orElse: () {
                            allSkinDisabled = true;
                            return item.skins.first;
                          },
                        ).avatar;
                        if (allSkinDisabled) {
                          items[index].enable = true;
                        }
                        characterService.save(items, backupBeforeSave: false);
                        notifyListeners();
                      },
                    ),
                  )),
                  DataCell(Center(
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ImageButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            CharacterService.initViewWindow(item,
                                skinIndex: item.skins.indexOf(skin));
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
