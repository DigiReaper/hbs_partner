import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/screens/leads/auth/login.dart';
import 'package:hbs_partner/screens/leads/auth/verification.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final List<String> _categories = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'Painter',
    'Pest Control',
    'AC Service',
    'Cleaning',
    'Others'
  ];
  final List<String> _selectedCategories = [];
  String _photoFileName = 'None';
  String _aadharFileName = 'None';
  String _panFileName = 'None';

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Partner Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Partner Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join Hello Bhaiaah as a Partner!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'Your Name',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Enter your name',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Phone Number',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.local_phone_outlined),
                  hintText: 'Enter your phone number',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Category',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              GestureDetector(
                onTap: () async {
                  final selected = await showDialog<List<String>>(
                    context: context,
                    builder: (BuildContext context) {
                      return MultiSelectDialog(
                        items: _categories,
                        initialSelectedItems: _selectedCategories,
                      );
                    },
                  );
                  if (selected != null) {
                    _selectedCategories.clear();
                    _selectedCategories.addAll(selected);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.category_outlined, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedCategories.isEmpty
                              ? 'Select categories'
                              : _selectedCategories.join(', '),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Photo Upload',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                onPressed: () {
                  // Implement photo upload functionality
                  // Update _photoFileName with the selected file name
                },
                child: const Text('Upload Photo'),
              ),
              Text(_photoFileName, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),
              const Text(
                'Aadhar Card Upload',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                onPressed: () {
                  // Implement Aadhar card upload functionality
                  // Update _aadharFileName with the selected file name
                },
                child: const Text('Upload Aadhar Card'),
              ),
              Text(_aadharFileName, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),
              const Text(
                'PAN Card Upload',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                onPressed: () {
                  // Implement PAN card upload functionality
                  // Update _panFileName with the selected file name
                },
                child: const Text('Upload PAN Card'),
              ),
              Text(_panFileName, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final mobileNumber = _mobileNumberController.text;

                    // Name should be at least 4 characters and up to 15 characters
                    if (name.length < 4 || name.length > 15) {
                      ToastService.showErrorToast(context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message:
                              'Name should be at least 4 characters and up to 15 characters');
                      return;
                    }

                    // Email should be valid
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(email)) {
                      ToastService.showErrorToast(context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message: 'Please enter a valid email');
                      return;
                    }

                    // Mobile number should be 10 digits
                    if (mobileNumber.length != 10 ||
                        !RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
                      ToastService.showErrorToast(context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message:
                              'Please enter a valid 10-digit mobile number');
                      return;
                    }

                    final response = await authController.sendOtp(mobileNumber);
                    if (response.success) {
                      ToastService.showSuccessToast(context,
                          length: ToastLength.medium,
                          message: response.message);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationScreen(
                            mobileNumber: mobileNumber,
                            name: name,
                            email: email,
                            isSignUp: true,
                          ),
                        ),
                      );
                    } else {
                      ToastService.showErrorToast(context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message: response.message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Color(0xFFFCAD1F),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedItems;

  MultiSelectDialog({required this.items, required this.initialSelectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  final List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems.addAll(widget.initialSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Categories'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked!) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          },
        ),
      ],
    );
  }
}
