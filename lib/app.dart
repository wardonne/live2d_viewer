import 'dart:ui';

import 'package:args/args.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'router/router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

class Live2DViewer extends StatefulWidget {
  final ArgResults args;

  const Live2DViewer({super.key, required this.args});

  @override
  State<StatefulWidget> createState() => _Live2DViewerState();
}

class _Live2DViewerState extends State<Live2DViewer> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).title,
      scrollBehavior: ScrollConfiguration.of(context)
        ..copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
      theme: ThemeData(
        brightness: Brightness.dark,
        hoverColor: Styles.hoverBackgroundColor,
        scaffoldBackgroundColor: Styles.backgroundColor,
        iconTheme: const IconThemeData(
          color: Styles.iconColor,
          size: Styles.iconSize,
        ),
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(
            size: Styles.iconSize,
            color: Styles.iconColor,
          ),
          iconTheme: IconThemeData(
            size: Styles.iconSize,
            color: Styles.iconColor,
          ),
        ),
      ),
      locale: Provider.of<LocaleProvider>(context).locale,
      localizationsDelegates: const {
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      },
      supportedLocales: S.delegate.supportedLocales,
      routes: router,
      initialRoute: Routes.index,
      onGenerateInitialRoutes: (initialRoute) {
        final page = widget.args['page'] as String;
        final builder = router[Routes.index];
        return [
          MaterialPageRoute(builder: router[Routes.index]!),
          if (page != Routes.index && builder != null)
            MaterialPageRoute(builder: builder),
        ];
      },
    );
  }
}
