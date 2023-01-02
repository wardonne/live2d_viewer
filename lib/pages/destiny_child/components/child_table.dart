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
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
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
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!,
              child: IconTheme.merge(
                data: const IconThemeData(
                  opacity: 0.54,
                ),
                child: SizedBox(
                  height: 56,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      children: [
                        Container(width: 32.0),
                        Text(
                          localizations.pageRowsInfoTitle(
                            startIndex + 1,
                            endIndex + 1,
                            source.total,
                            false,
                          ),
                        ),
                        Container(width: 32.0),
                        IconButton(
                          onPressed: startIndex <= 0 ? null : source.firstPage,
                          icon: const Icon(Icons.skip_previous),
                          padding: EdgeInsets.zero,
                          tooltip: localizations.firstPageTooltip,
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          padding: EdgeInsets.zero,
                          tooltip: localizations.previousPageTooltip,
                          onPressed: startIndex <= 0 ? null : source.prePage,
                        ),
                        Container(width: 24.0),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          padding: EdgeInsets.zero,
                          tooltip: localizations.nextPageTooltip,
                          onPressed: !source.isNextPageAvailable()
                              ? null
                              : source.nextPage,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          padding: EdgeInsets.zero,
                          tooltip: localizations.lastPageTooltip,
                          onPressed: !source.isNextPageAvailable()
                              ? null
                              : source.lastPage,
                        ),
                        Container(width: 14.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChildTableSource extends ChangeNotifier {
  final List<Child> items;
  int page;
  final int pageSize;
  final DestinyChildSettings destinyChildSettings;
  final ChildService childService;

  ChildTableSource({
    required this.items,
    this.page = 1,
    this.pageSize = 8,
    required this.destinyChildSettings,
  }) : childService = ChildService(destinyChildSettings);

  int get total => items.length;

  pageTo(int page) {
    if (this.page != page && page > 0) {
      this.page = page;
      notifyListeners();
    }
  }

  prePage() {
    pageTo(page - 1);
  }

  nextPage() {
    pageTo(page + 1);
  }

  firstPage() {
    pageTo(1);
  }

  lastPage() {
    pageTo(((total) / pageSize).floor() + 1);
  }

  bool isNextPageAvailable() {
    return page * pageSize < total;
  }

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
