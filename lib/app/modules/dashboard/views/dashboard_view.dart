import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_project_name/app/routes/app_pages.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : IconButton(
                icon: Image.asset('assets/icons/logo.png'),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
                onSubmitted: (value) {
                  // Trigger search logic here
                },
              )
            : Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  Get.toNamed(Routes.PROFILE);
                  break;
                case 'Settings':
                  Get.toNamed(Routes.SETTINGS);
                  break;
                case 'Logout':
                  // Trigger logout logic here
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Settings', 'Logout'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.HOME);
              },
            ),
            // Add more ListTile items for different roles/screens
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    // Add more NavigationRailDestination items here
                  ],
                ),
                Expanded(child: _getSelectedScreen(_selectedIndex)),
              ],
            );
          } else {
            return _getSelectedScreen(_selectedIndex);
          }
        },
      ),
      floatingActionButton: MediaQuery.of(context).size.width <= 600
          ? FloatingActionButton(
              onPressed: () {
                // FAB action
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: MediaQuery.of(context).size.width > 600
          ? BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Status: Ready'),
              ),
            )
          : null,
    );
  }

  Widget _getSelectedScreen(int index) {
    // Return the appropriate screen based on the selected index
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return AnotherScreen();
      default:
        return HomeScreen();
    }
  }
}
