import 'package:budget_worker/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Booking.dart';
import 'UserAcc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  final _screens = [
    const HomePage(),
    const Booking(),
    const UserAcc(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      backgroundColor : HexColor('#ffe6e6'),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: HexColor('#76c7ef'),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: Colors.white),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: HexColor('#0B4360'),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white,),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border_rounded, color: Colors.white,),
              label: "Bookings" ,
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Colors.white,),
              label: "Account" ,
            ),
          ],
        ),
      ),
    );
  }
}

