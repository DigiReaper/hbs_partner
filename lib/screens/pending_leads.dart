import 'package:flutter/material.dart';

class PendingLeadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Leads'),
      ),
      body: Center(
        child: Text('No pending leads at the moment.'),
      ),
    );
  }
}