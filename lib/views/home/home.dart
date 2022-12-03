import 'package:flutter/material.dart';

class Home extends StatelessWidget
{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          itemBuilder: (context) {
            return [
              const PopupMenuItem(child: Text("Menu1")),
              const PopupMenuItem(child: Text("Menu2")),
              const PopupMenuItem(child: Text("Menu3")),
              const PopupMenuItem(child: Text("Menu4")),
            ];
          },
        )
      ),
      body: const Center(child: Text('Home page')),
    );
  }
}