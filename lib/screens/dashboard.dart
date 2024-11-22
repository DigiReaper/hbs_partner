import 'package:flutter/material.dart';
import 'package:hbs_partner/screens/accepted_page.dart';
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

  void _navigateToPage(String page) {
    // Add navigation logic for each page here
    switch (page) {
      case 'ACCEPTED':
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcceptedPage()),
        );
        break;
      case 'TODAY':
        // Navigate to Today page
        break;
      case 'TOMORROW':
        // Navigate to Tomorrow page
        break;
      case 'PENDING':
        // Navigate to Pending page
        break;
      case 'IN PROGRESS':
        // Navigate to In Progress page
        break;
      case 'ALL LEADS':
        // Navigate to All Leads page
        break;
      case 'COMPLETED':
        // Navigate to Completed page
        break;
      case 'MISSED':
        // Navigate to Missed page
        break;
      default:
        // Default action
        break;
    }
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: Column(
                        children: [
                          Icon(Icons.person, size: 40),
                          Text('Profile'),
                        ],
                      ),
                    ),
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
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              children: [
                'ACCEPTED',
                'TODAY',
                'TOMORROW',
                'PENDING',
                'IN PROGRESS',
                'ALL LEADS',
                'COMPLETED',
                'MISSED',
              ].map((text) {
                return GestureDetector(
                  onTap: () {
                    _navigateToPage(text);
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.33),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          '00000',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
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
