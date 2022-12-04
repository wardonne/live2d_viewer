import 'package:flutter/material.dart';
import 'package:live2d_viewer/views/home/components/menu.dart' as menu;

class Home extends StatelessWidget
{
  Home({super.key});

  final menuInstance = menu.Menu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), 
          onPressed: () { 
          },
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: menuInstance.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(menuInstance.at(index).label),);
          },
        ),
      ),
    );
  }
}