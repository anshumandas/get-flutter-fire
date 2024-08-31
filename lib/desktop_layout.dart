import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            child: Column(
              children: [
                DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: Text('Screen 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Screen 2'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: Text('Desktop Layout'),
                  actions: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton<int>(
                      onSelected: (item) => print('Selected $item'),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Text('Profile')),
                        PopupMenuItem<int>(value: 1, child: Text('Settings')),
                        PopupMenuItem<int>(value: 2, child: Text('Logout')),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text('Desktop Body Content'),
                  ),
                ),
                Container(
                  height: 30,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Text('Status Bar - Desktop Only'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
