import 'package:flutter/material.dart';
import 'package:hbs_partner/controllers/booking_controller.dart';
import 'package:hbs_partner/controllers/services_controller.dart';
import 'package:hbs_partner/controllers/subcategory_controller.dart';
import 'package:hbs_partner/screens/auth/login.dart';
import 'package:hbs_partner/theme.dart';
import 'package:provider/provider.dart';
import 'package:hbs_partner/controllers/auth_controller.dart';
import 'package:hbs_partner/controllers/category_controller.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => SubcategoryController()),
        ChangeNotifierProvider(create: (context) => ServiceController()),
        ChangeNotifierProvider(create: (context) => BookingController()),
      ],
      child: MaterialApp(
        title: 'Helloo Bhaiaah',
        theme: appTheme, // Use the theme from the separate file
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
