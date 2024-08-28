import 'package:flutter/material.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/profile/views/profile_view.dart';
import 'app/modules/ranking/views/ranking_view.dart';
import 'app/modules/search/views/search_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    RankingView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.black, // Set the navigation bar background to black
        selectedItemColor: Colors.white, // Set selected item color to white
        unselectedItemColor: Colors.grey, // Set unselected item color to grey
        type: BottomNavigationBarType.fixed, // Ensure icons and labels are always displayed
        selectedLabelStyle: TextStyle(fontSize: 12), // Adjust the selected label font size
        unselectedLabelStyle: TextStyle(fontSize: 12), // Adjust the unselected label font size
      ),
    );
  }
}
