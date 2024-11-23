import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/screens/leads/auth/login.dart';
import 'package:hbs_partner/screens/dashboard.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    await Future.delayed(Duration(milliseconds: 500));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("AUTH: ${authController.isAuthenticated}");
      if (authController.isAuthenticated) {
        print("taking user to dashboard");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // Navigate to the onboarding screen if the user is not logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 300,
          height: 300,
        ), // Make sure the image is in the assets folder
      ),
    );
  }
}
