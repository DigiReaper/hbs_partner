import 'package:flutter/material.dart';
import 'package:hbs_partner/components/lead_details.dart';

class DeclinedLeads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Declined Leads Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeadDetails(
                  serviceId: '12345',
                  serviceType: 'Plumbing',
                  category: 'Home Services',
                  location: '123 Main St, Springfield',
                  dateTime: '10:00 AM, 25th Dec 2023',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}