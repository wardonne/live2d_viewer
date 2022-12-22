import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/settings.dart';

class MenuWindowButton extends StatefulWidget {
  const MenuWindowButton({super.key});
  @override
  State<StatefulWidget> createState() {
    return MenuWindowButtonState();
  }
}

class MenuWindowButtonState extends State<MenuWindowButton> {
  bool isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isMenuOpen ? Icons.menu_open : Icons.menu),
      onPressed: () {
        if (kDebugMode) {
          print(isMenuOpen ? 'close menu' : 'open_menu');
        }
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
      splashRadius: defaultActionIconButtonSplashRadius,
    );
  }
}
