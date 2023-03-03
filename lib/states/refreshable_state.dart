import 'package:flutter/material.dart';

abstract class RefreshableState<T extends StatefulWidget> extends State {
  void reload({bool forceReload = false});

  T? _widget;

  @override
  T get widget => _widget!;
}
