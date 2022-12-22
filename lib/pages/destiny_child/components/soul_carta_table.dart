import 'dart:io';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/services/destiny_child/soul_carta_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

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
  final PreviewWindowController previewWindowController =
      DestinyChildConstant.soulCartaViewController;
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
    return DataRow.byIndex(index: index, selected: false, cells: [
      DataCell(Center(child: Text('${index + 1}'))),
      DataCell(Center(
          child: Image.file(File(
              '${destinyChildSettings.soulCartaSettings!.avatarPath}/${item.avatar}')))),
      DataCell(Center(child: Text(item.name ?? ''))),
      DataCell(Center(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ImageButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                soulCartaService.initViewWindow(
                  useLive2d: item.useLive2d,
                  data: item,
                );
              },
            ),
            ImageButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
            ImageButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                var confirmed = await confirm(context,
                    content: const Text('Confirm to remove?'));
                if (confirmed) {
                  try {
                    items.removeAt(index);
                    soulCartaService.save(items);
                    notifyListeners();
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            ErrorDialog(message: e.toString()));
                  }
                }
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
