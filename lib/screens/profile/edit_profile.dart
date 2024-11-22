import 'package:flutter/material.dart';
import 'package:hbs_partner/components/button.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/model/user.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toasty_box.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authController = Provider.of<AuthController>(context, listen: false);
    final user = authController.user;

    // Prefill the data from authController
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _mobileController.text = user.mobileNumber;
      // Assuming address is a property of user
      // _addressController.text = user.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final user = authController.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Figtree',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                enabled: false,
                controller: _mobileController,
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter your address';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 32),
              Center(
                child: MyElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Handle save changes logic here
                      User updatedUser = User(
                        id: user!.id,
                        name: _nameController.text,
                        email: _emailController.text,
                        mobileNumber: _mobileController.text,
                        role: "user",
                      );
                      final response =
                          await authController.updateUser(updatedUser);
                      if (response.success) {
                        Navigator.of(context).pop();
                      } else {
                        ToastService.showErrorToast(
                          context,
                          message: response.message,
                          length: ToastLength.medium,
                        );
                      }
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  height: 52,
                  width: 250,
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                    ),
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
