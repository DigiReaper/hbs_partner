import 'package:flutter/material.dart';
import 'package:hbs_partner/screens/profile/profile.dart';
import 'package:hbs_partner/theme.dart'; // Import the theme file to use primaryColor

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool _isOnline = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back icon
        title: Text('HB - PARTNER', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 7),
              color: primaryColor.withOpacity(0.33),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.person, size: 40),
                    Text('Profile'),
                  ],
                ),
                Column(
                  children: [
                    Switch(
                      value: _isOnline,
                      onChanged: (bool value) {
                      setState(() {
                        _isOnline = value;
                      });
                      },
                      activeColor: Colors.green,
                    ),
                    Text('Online'),
                  ],
                ),
                Icon(Icons.notifications, size: 40),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 4),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Text(
              'Wallet balance: 2500',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.book),
      //       label: 'My Bookings',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   selectedItemColor: Color(0xFFFFA51D),
      //   unselectedItemColor: Color(0xFF6D6D6D),
      //   iconSize: 30,
      //   showUnselectedLabels: true,
      // ),
    );
  }
}
