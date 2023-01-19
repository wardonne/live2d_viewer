import 'package:flutter/material.dart';

abstract class RefreshableState<T> extends State {
  void reload({bool forceReload = false});
}
