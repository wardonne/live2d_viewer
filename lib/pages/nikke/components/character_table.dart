import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/paginator_controller.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';
import 'package:live2d_viewer/services/app_service.dart';
import 'package:live2d_viewer/services/nikke/character_service.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/editable_cell.dart';
import 'package:live2d_viewer/widget/paginator.dart';

class CharacterTable extends StatelessWidget {
  final CharacterTableSource source;
  const CharacterTable({super.key, required this.source});

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
                separatorBuilder: (context, index) => Container(height: 5),
                itemCount: items.length,
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
  final NikkeSettings nikkeSettings;
  final CharacterService characterService;

  CharacterTableSource({
    required super.items,
    super.page = 1,
    super.pageSize = 8,
    required this.nikkeSettings,
  }) : characterService = CharacterService(nikkeSettings);

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
    final avatarPath = nikkeSettings.characterSettings!.avatarPath;
    final EditableCellInputController controller =
        EditableCellInputController(readOnly: true);
    final TextEditingController textEditingController =
        TextEditingController.fromValue(TextEditingValue(text: item.name));
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus &&
          textEditingController.value.text != item.name) {
        items[index].name = textEditingController.value.text;
        characterService.save(items, backupBeforeSave: false);
        notifyListeners();
      }
    });
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: ExpansionTile(
          title: Row(
            children: [
              SizedBox(
                width: 100,
                child: EditableCellInput(
                  controller: controller,
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  textAlign: TextAlign.left,
                ),
              ),
              ImageButton(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
                onPressed: () {
                  controller.setReadOnly(!controller.readOnly);
                  if (!controller.readOnly) {
                    focusNode.requestFocus();
                  }
                },
              ),
              Switch(
                value: item.enable,
                onChanged: (value) {
                  items[index].enable = value;
                  characterService.save(items, backupBeforeSave: false);
                  notifyListeners();
                },
              ),
            ],
          ),
          leading: SizedBox(
              width: 80,
              child: Center(
                  child: Image.file(File('$avatarPath/${item.avatar}')))),
          trailing: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ImageButton(
                  icon: const Icon(Icons.search, size: 20),
                  onPressed: () {
                    CharacterService.initViewWindow(item);
                    AppService.unextendSidebar();
                    NikkeService.closeItemsWindow();
                  },
                ),
              )
            ],
          ),
          tilePadding: const EdgeInsets.all(5),
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                    ),
                    child: DataTable(
                      border: TableBorder.all(color: Colors.white24),
                      columns: [
                        _buildHeaderCell("Index"),
                        _buildHeaderCell("Avatar"),
                        _buildHeaderCell("Name"),
                        _buildHeaderCell("Enable"),
                        _buildHeaderCell("Operations"),
                      ],
                      rows: item.skins
                          .map((skin) => _buildRow(item, skin))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataColumn _buildHeaderCell(String label) {
    return DataColumn(
      label: Expanded(
        child: Center(child: Text(label)),
      ),
    );
  }

  DataRow _buildRow(Character character, Skin skin) {
    final avatarPath = nikkeSettings.characterSettings!.avatarPath;
    final controller = EditableCellInputController(readOnly: true);
    final TextEditingController textEditingController = TextEditingController();
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus &&
          textEditingController.value.text != skin.name) {
        skin.name = textEditingController.value.text;
        characterService.save(items, backupBeforeSave: false);
        notifyListeners();
      }
    });
    return DataRow(cells: [
      DataCell(Center(
        child: Text('${character.skins.indexOf(skin) + 1}'),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(2),
        child: Center(child: Image.file(File('$avatarPath/${skin.avatar}'))),
      )),
      DataCell(
        EditableCellInput(
          controller: controller,
          textEditingController: textEditingController,
          textAlign: TextAlign.center,
          focusNode: focusNode,
        ),
        showEditIcon: true,
        onTap: () {
          controller.setReadOnly(!controller.readOnly);
          if (!controller.readOnly) {
            focusNode.requestFocus();
          }
        },
      ),
      DataCell(Center(
        child: Switch(
          value: skin.enable,
          onChanged: (value) {
            bool allSkinDisabled = false;
            final skinIndex = character.skins.indexOf(skin);
            character.skins[skinIndex].enable = value;
            character.avatar = character.skins.firstWhere(
              (element) => element.enable,
              orElse: () {
                allSkinDisabled = true;
                return character.skins.first;
              },
            ).avatar;
            if (allSkinDisabled) {
              character.enable = false;
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
                CharacterService.initViewWindow(character,
                    skinIndex: character.skins.indexOf(skin));
                AppService.unextendSidebar();
                NikkeService.closeItemsWindow();
              },
            ),
          ],
        ),
      )),
    ]);
  }
}
