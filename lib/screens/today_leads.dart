import 'package:flutter/material.dart';

class TodayLeadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Leads'),
      ),
      body: Center(
        child: Text(
          'No leads for today!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}