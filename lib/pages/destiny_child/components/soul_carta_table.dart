import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/services/destiny_child/soul_carta_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/editable_cell.dart';

class SoulCartaTable extends StatefulWidget {
  final List<SoulCarta> soulCartas;
  final DestinyChildSettings destinyChildSettings;

  const SoulCartaTable({
    super.key,
    required this.soulCartas,
    required this.destinyChildSettings,
  });

  @override
  createState() => SoulCartaTableState();
}

class SoulCartaTableState extends State<SoulCartaTable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var columns = _buildHeaders();
    return PaginatedDataTable(
      columns: columns,
      source: SoulCartaTableSource(
        context,
        items: widget.soulCartas,
        destinyChildSettings: widget.destinyChildSettings,
      ),
      showFirstLastButtons: true,
    );
  }

  _buildHeaders() {
    return <DataColumn>[
      _buildHeaderCell('Index'),
      _buildHeaderCell('Avatar'),
      _buildHeaderCell('Name'),
      _buildHeaderCell('Enable'),
      _buildHeaderCell('Operations'),
    ];
  }

  DataColumn _buildHeaderCell(String label) {
    return DataColumn(
      label: Expanded(
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}

class SoulCartaTableSource extends DataTableSource {
  final int _selectedCount = 0;
  final DestinyChildSettings destinyChildSettings;

  final List<SoulCarta> items;
  final BuildContext context;
  final SoulCartaService soulCartaService;

  SoulCartaTableSource(
    this.context, {
    required this.items,
    required this.destinyChildSettings,
  }) : soulCartaService = SoulCartaService(destinyChildSettings);

  @override
  DataRow? getRow(int index) {
    if (index >= items.length || index < 0) {
      throw FlutterError('index out of range');
    }
    final item = items[index];
    final avatarPath = destinyChildSettings.soulCartaSettings!.avatarPath;

    final textEditingController = TextEditingController.fromValue(
        TextEditingValue(text: item.name ?? ''));
    final controller = EditableCellInputController(readOnly: true);
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus &&
          textEditingController.value.text != item.name) {
        items[index].name = textEditingController.value.text;
        soulCartaService.save(items, backupBeforeSave: false);
        notifyListeners();
      }
    });

    return DataRow.byIndex(index: index, selected: false, cells: [
      DataCell(Center(child: Text('${index + 1}'))),
      DataCell(Center(child: Image.file(File('$avatarPath/${item.avatar}')))),
      DataCell(
        EditableCellInput(
          controller: controller,
          textEditingController: textEditingController,
          focusNode: focusNode,
          textAlign: TextAlign.center,
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
          value: item.enable,
          onChanged: (value) {
            items[index].enable = value;
            soulCartaService.save(items, backupBeforeSave: false);
            notifyListeners();
          },
        ),
      )),
      DataCell(Center(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ImageButton(
              icon: const Icon(Icons.search, color: Colors.white70, size: 20),
              onPressed: () {
                SoulCartaService.initViewWindow(item);
                DestinyChildService.closeItemsWindow();
              },
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => _selectedCount;
}
