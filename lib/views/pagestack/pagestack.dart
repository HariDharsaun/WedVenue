import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hall_booking_app/views/bookings/bookings.dart';
import 'package:hall_booking_app/views/home/home.dart';
import 'package:hall_booking_app/views/profile/profile.dart';

class Pagestack extends StatefulWidget {
  const Pagestack({super.key});

  @override
  State<Pagestack> createState() => _PagestackState();
}

class _PagestackState extends State<Pagestack> {
  int _bottomNavIndex = 0;
  List<IconData> iconlist = [Icons.home, Icons.book_online, Icons.people,Icons.settings];
  List<Widget> pages = [
    HomeScreen(),
    BookingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_bottomNavIndex],
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.purple,
      //   child: Icon(Icons.add, color: Colors.white),
      //   onPressed: () {

      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Color(0xFFd053d4),
        gapLocation: GapLocation.none,
        icons: iconlist,
        activeIndex: _bottomNavIndex,
        activeColor: Colors.white,
        inactiveColor: Colors.white38,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
   ),
    );
  }
}