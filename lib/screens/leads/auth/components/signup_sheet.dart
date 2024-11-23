import 'package:flutter/material.dart';
import 'package:hbs_partner/screens/leads/auth/signup.dart';

class SignUpBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 60, left: 20.0, right: 20.0, bottom: 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 40),
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlock Local Services — Join Hello Bhaiaah!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 37),
          ElevatedButton.icon(
            onPressed: () {
              // Handle Google sign up
            },
            icon: Image.asset(
              'assets/images/google_logo.png',
              height: 30,
            ),
            label: const Text(
              'Continue with Google',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              // maximumSize: Size(double.infinity, 50),
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.black),
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () {
              // Handle Facebook sign up
            },
            icon: Image.asset(
              'assets/images/facebook_logo.jpg',
              height: 30,
            ),
            label: const Text(
              'Continue with Facebook',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.black),
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            icon: Icon(
              Icons.email_outlined,
              color: Colors.black,
              size: 30,
            ),
            label: const Text(
              'Continue with Email',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.black),
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
