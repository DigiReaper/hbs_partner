import 'package:flutter/material.dart';
import 'package:hbs_partner/screens/profile/profile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    // HomeScreen(),
    // MyBookingsPage(),
    ProfilePage(),
    ProfilePage(),

    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            icon: Icon(Icons.book),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFFFFA51D),
        unselectedItemColor: Color(0xFF6D6D6D),
        iconSize: 30,
        //selectedFontSize: 14,

        // backgroundColor: Color(0xF9F9F9),
        showUnselectedLabels: true,
      ),
    );
  }
}
