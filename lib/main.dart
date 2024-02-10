import 'package:echoes_of_equality/pages/login_pages/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echoes_of_equality/pages/onboarding_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   final prefs = await SharedPreferences.getInstance();
//   bool showHome = prefs.getBool('showHome') ?? true;
//
//   runApp(MyApp());
// }

bool showHome = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
      // Add other required fields as necessary.
    ),
  );
  final prefs = await SharedPreferences.getInstance();
  bool showHome = prefs.getBool('showHome') ?? true;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome? const OnBoardingScreen() : const SignInScreen(),
    );
  }
}

