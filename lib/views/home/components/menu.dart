import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live2d_viewer/model/menu_item_model.dart';

class Menu {
  late List<MenuItemModel> menuItems;

  Menu() {
    loadMenu();
  }

  loadMenu() async {
    final content = await rootBundle.loadString('assets/storage/menu.json');
    final items = json.decode(content);
      for (final item in items) {
        final menuItem = MenuItemModel.fromMap(item);
        menuItems.add(menuItem);
      }
      print(menuItems);
  }

  int get length => menuItems.length;

  MenuItemModel at(int index) => menuItems[index];
}
