import 'package:flutter/material.dart';

abstract class PaginatorController<T> extends ChangeNotifier {
  int page;
  int pageSize;
  List<T> items;

  PaginatorController({
    this.page = 1,
    this.pageSize = 8,
    required this.items,
  });

  int get total;

  void pageTo(int page) {
    if (this.page != page && page > 0) {
      this.page = page;
      notifyListeners();
    }
  }

  void prePage() => pageTo(page - 1);

  void nextPage() => pageTo(page + 1);

  void firstPage() => pageTo(1);

  void lastPage() => pageTo(((total) / pageSize).floor() + 1);

  bool isNextPageAvailable() => page * pageSize < total;

  List<Widget> getRange(int startIndex, int endIndex);

  Widget? getRow(int index);
}
