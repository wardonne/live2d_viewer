import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  final SidebarXController controller;
  final Image avatarImage;
  final List<SidebarXItem> items;

  const SideBar({
    super.key,
    required this.controller,
    required this.avatarImage,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        decoration: const BoxDecoration(
          color: barColor,
          border: Border(
            right: BorderSide(color: Colors.white70),
          ),
        ),
        hoverColor: const Color.fromARGB(255, 48, 48, 63),
        textStyle: const TextStyle(color: Colors.white70),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        selectedItemDecoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white70,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: barColor,
          border: Border(
            right: BorderSide(color: Colors.white70),
          ),
        ),
      ),
      footerDivider: const Divider(
        color: Colors.white70,
        height: 1,
      ),
      headerDivider: const Divider(
        color: Colors.white70,
        height: 1,
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: headerBarHeight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: avatarImage,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(),
      items: items,
    );
  }
}
