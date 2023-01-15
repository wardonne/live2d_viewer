import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'router/router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

class Live2DViewer extends StatefulWidget {
  const Live2DViewer({super.key});

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
      theme: ThemeData(
        brightness: Brightness.dark,
        hoverColor: Styles.hoverBackgroundColor,
        scaffoldBackgroundColor: Styles.backgroundColor,
        iconTheme: const IconThemeData(
          color: Styles.iconColor,
          size: Styles.iconSize,
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
    );
  }
}
