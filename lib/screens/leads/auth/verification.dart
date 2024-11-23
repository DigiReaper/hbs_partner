import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toasty_box.dart';

class VerificationScreen extends StatefulWidget {
  final String mobileNumber;
  final String? name;
  final String? email;
  final bool isSignUp;

  VerificationScreen({
    required this.mobileNumber,
    this.name,
    this.email,
    required this.isSignUp,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleKeyEvent(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(''),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "We've Sent A Verification Code",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "We've sent a verification code to your mobile number. Please enter the OTP code to login.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 45),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 55,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onChanged: (value) => _handleKeyEvent(index, value),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Center(
                  child: ElevatedButton(
                    onPressed: () => handleVerification(authController),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(270, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                ),
                const SizedBox(height: 37),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Didn't receive OTP? ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyle(
                            color: Color(0xFFFCAD1F),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // Handle resend OTP
                              final response = await authController
                                  .sendOtp(widget.mobileNumber);
                              if (!response.success) {
                                // Show error message
                                ToastService.showErrorToast(
                                  context,
                                  message: response.message,
                                  length: ToastLength.short,
                                );
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png',
                width: double.infinity, // Stretch to the device width
                fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  void handleVerification(AuthController authController) async {
    // Hide the keyboard
    FocusScope.of(context).unfocus();

    // Collect the OTP from the text fields
    final otp = _controllers.map((controller) => controller.text).join();

    if (widget.isSignUp) {
      // Handle registration
      print(
          'Registering user with details: ${widget.name}, ${widget.email}, ${widget.mobileNumber}');
      final response = await authController.register(
        widget.name!,
        widget.email!,
        widget.mobileNumber,
        'user',
        otp,
      );
      print(response.message);
      if (response.success) {
        ToastService.showSuccessToast(context,
            length: ToastLength.short, message: response.message);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // Show error message
        ToastService.showErrorToast(
          context,
          message: response.message,
          length: ToastLength.short,
        );
      }
    } else {
      // Handle login
      print('Logging in user with mobile number: ${widget.mobileNumber}');
      final response = await authController.login(widget.mobileNumber, otp);
      if (response.success) {
        ToastService.showSuccessToast(context,
            length: ToastLength.short, message: response.message);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // Show error message
        ToastService.showErrorToast(
          context,
          message: response.message,
          length: ToastLength.short,
        );
      }
    }
  }
}
