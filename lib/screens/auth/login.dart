import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/screens/auth/signup.dart';
import 'package:hbs_partner/screens/auth/verification.dart';
import 'package:hbs_partner/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    print("Init");

    final authController = Provider.of<AuthController>(context, listen: false);

    // Wait for the authController to finish initialization
    await Future.delayed(Duration(milliseconds: 500));
    // Check if the user is already authenticated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("AUTH: ${authController.isAuthenticated}");
      if (authController.isAuthenticated) {
        print("taking user to dashboard");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'HB-Partner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFF6881F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                            const SizedBox(height: 20),

              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Partner Login',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 8),
              // const Text(
              //   'Your Local Services, Just a Click Away!',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(height: 35),
              const Text(
                'Mobile Number',
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
                  hintText: 'Enter your mobile number',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Hide the keyboard
                    FocusScope.of(context).unfocus();

                    final mobileNumber = _mobileNumberController.text;
                    if (mobileNumber.length != 10 ||
                        !RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
                      ToastService.showErrorToast(
                        context,
                        length: ToastLength.medium,
                        expandedHeight: 100,
                        message: 'Please enter a valid 10-digit mobile number',
                      );
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
                            isSignUp: false,
                          ),
                        ),
                      );
                    } else {
                      ToastService.showErrorToast(
                        context,
                        length: ToastLength.medium,
                        expandedHeight: 100,
                        message: response.message,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Verify using OTP',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Are you a new user? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: Color(0xFFFCAD1F),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),

                Center(
                child: TextButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                  },
                  child: Text("DASHBOARD"),
                ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Image.asset(
        'assets/images/bottom.png',
        width: double.infinity, // Stretch to the device width
        fit: BoxFit.cover,
      ),
    );
  }
}
