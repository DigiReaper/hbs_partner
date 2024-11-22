import 'package:flutter/material.dart';
import 'package:hbs_partner/components/button.dart';
import 'package:hbs_partner/screens/dashboard.dart';

class RegistrationSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFF),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Success Image
                  Image.asset(
                    'assets/images/success.png',
                    width: 144.67,
                    height: 140,
                  ),
                  const SizedBox(height: 32),

                  // Success Message
                  Text(
                    'You’ve successfully registered with \nHelloo Bhaiaah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtext
                  Text(
                    'Explore, Book and Relax as we take care of your home needs!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF6D6D6D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Discover Services Button
                  SizedBox(
                    width: 280,
                    height: 52,
                    child: MyElevatedButton(
                      onPressed: () {
                        // Add action for the button here
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: const Text(
                        'Discover Services',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png',
                //height: 100,
                width: double.infinity, // Stretch to the device width
                fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
