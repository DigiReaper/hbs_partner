import 'package:flutter/material.dart';

class LeadDetails extends StatelessWidget {
  final String serviceId;
  final String serviceType;
  final String category;
  final String location;
  final String dateTime;

  LeadDetails({
    required this.serviceId,
    required this.serviceType,
    required this.category,
    required this.location,
    required this.dateTime,
  });

  void _showDialog(BuildContext context, String title) {
    if (title == 'Schedule Lead') {
      final TextEditingController remarksController = TextEditingController();
      DateTime? selectedDate;
      TimeOfDay? selectedTime;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service ID: $serviceId', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Date:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(selectedDate == null
                          ? 'Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                    ),
                    SizedBox(height: 10),
                    Text('Time:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Text(selectedTime == null
                          ? 'Time'
                          : '${selectedTime!.hour}:${selectedTime!.minute}'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: remarksController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Remarks', labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    } else if (title == 'Work Status') {
      final TextEditingController remarksController = TextEditingController();
      String? selectedWorkStatus;
      String? selectedCancelReason;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service ID: $serviceId', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      hint: Text('Select Work Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      value: selectedWorkStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWorkStatus = newValue;
                          selectedCancelReason = null; // Reset cancel reason if work status changes
                        });
                      },
                      items: <String>[
                        'REACHED LOCATION',
                        'WORK STARTED',
                        'LEAD COMPLETED',
                        'CANCEL THE WORK',
                        'CUSTOMER NOT RESPONDING',
                        'CUSTOMER WILL CALL AND RE-CONFIRM',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        );
                      }).toList(),
                    ),
                    if (selectedWorkStatus == 'CANCEL THE WORK') ...[
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        hint: Text('Select Cancel Reason', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        value: selectedCancelReason,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCancelReason = newValue;
                          });
                        },
                        items: <String>[
                          'EMERGENCY',
                          'Customer out of town',
                          'Reached location customer not responding to calls',
                          'Customer took service from others',
                          'Customer booked wrong service',
                          'Others',
                          'Tools Not Available',
                          'Customer asked to cancel',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    ],
                    SizedBox(height: 20),
                    TextField(
                      controller: remarksController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text('This is the $title dialog box.'),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'LEAD DETAILS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Service ID: $serviceId',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Service Type: $serviceType',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Category: $category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Location: $location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Time & Date: $dateTime',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showDialog(context, 'Call'),
                    child: Icon(Icons.call, size: 40),
                  ),
                  Text(
                    'Call',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showDialog(context, 'Schedule Lead'),
                    child: Icon(Icons.schedule, size: 40),
                  ),
                  Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showDialog(context, 'Location'),
                    child: Icon(Icons.location_on, size: 40),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _showDialog(context, 'Work Status'),
                    child: Icon(Icons.work, size: 40),
                  ),
                  Text(
                    'Work Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}