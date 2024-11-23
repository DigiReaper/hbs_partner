import 'package:flutter/material.dart';
import 'package:hbs_partner/screens/leads/accepted_leads.dart';
import 'package:hbs_partner/screens/leads/declined_leads.dart';
import 'package:hbs_partner/screens/leads/completed_leads.dart';
import 'package:hbs_partner/screens/leads/inprogress_leads.dart';
import 'package:hbs_partner/screens/leads/missed_leads.dart';
import 'package:hbs_partner/screens/leads/pending_leads.dart';
import 'package:hbs_partner/screens/profile/profile.dart';
import 'package:hbs_partner/screens/leads/today_leads.dart';
import 'package:hbs_partner/screens/leads/tomorrow_leads.dart';
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TodayLeadsScreen()));
        break;
      case 'TOMORROW':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TomorrowLeads()));
        break;
      case 'PENDING':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PendingLeadsScreen()));
        break;
      case 'IN PROGRESS':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InProgressLeadsScreen()));
        break;
      case 'DECLINED':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DeclinedLeads()));
        break;
      case 'COMPLETED':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CompletedLeads()));
        break;
      case 'MISSED':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MissedLeads()));
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
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'HB',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              TextSpan(
                text: ' - PARTNER',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
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
                Column(
                  children: [
                    Icon(Icons.notifications, size: 40),
                    Text('Notifications'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              borderRadius: BorderRadius.circular(33),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              'Wallet balance: 2500',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 1,
              childAspectRatio: 1.5,
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
                        height: 100,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor, width: 4),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '00000',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
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
