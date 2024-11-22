import 'package:flutter/material.dart';

class InProgressLeadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In Progress Leads'),
      ),
      body: Center(
        child: Text('No leads in progress.'),
      ),
    );
  }
}