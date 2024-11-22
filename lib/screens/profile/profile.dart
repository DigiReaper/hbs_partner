import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/screens/auth/login.dart';
import 'package:hbs_partner/screens/profile/edit_profile.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Figtree',
          ),
        )),
        automaticallyImplyLeading: false, // Remove the back icon
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileDetails(),
                const SizedBox(height: 24),
                LogoutButton(),
                const SizedBox(height: 16),
                DeleteAccountButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final user = authController.user;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(title: 'Name', value: user?.name ?? '---'),
          const SizedBox(height: 16),
          InfoRow(title: 'Email', value: user?.email ?? '---'),
          const SizedBox(height: 16),
          InfoRow(title: 'Mobile Number', value: user?.mobileNumber ?? '---'),
          const SizedBox(height: 16),
          // InfoRow(title: 'Address', value: 'Lorem ipsum'),
          // const SizedBox(height: 16),
          EditDetailsButton(),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF969494),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class EditDetailsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFA51D), Color(0xFFF6BA23)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(),
            ),
          );
        },
        child: Text(
          'Edit Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);

    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          authController.logout();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        child: Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFF032678),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class DeleteAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          ToastService.showSuccessToast(context,
              length: ToastLength.long,
              message:
                  'Account delete request submitted successfully.\n We will get back to you soon.');
        },
        child: Text(
          'Delete Account',
          style: TextStyle(
            color: Color(0xFFFE0606),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
