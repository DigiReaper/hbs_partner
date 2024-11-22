import 'package:flutter/material.dart';

class TomorrowLeads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomorrow\'s Leads'),
      ),
      body: Center(
        child: Text(
          'No leads for tomorrow.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TomorrowLeads(),
  ));
}