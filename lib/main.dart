import 'package:flutter/material.dart';

import 'pages/login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'pages/onboarding_screen.dart';


// It means that it will show the onboard screen first
bool showHome = true;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  showHome = prefs.getBool('showHome') ?? true;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome? const OnBoardingScreen() : LoginPage(),
    );
  }
}

