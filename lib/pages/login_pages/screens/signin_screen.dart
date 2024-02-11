import 'package:echoes_of_equality/pages/donate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_service.dart';
import '../../../components/color_utils.dart';
import '../../main_page.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'signup_screen.dart';
import 'reset_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(_emailTextController.text, _passwordTextController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to sign in: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 20),
            child: Center(
              child: Column(
                children: [
                  logoWidget("assets/images/lgbt.png"),
                  const SizedBox(height: 20),
                  Text(
                    "Echoes of Equality",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins', // Ensure you have this font in your pubspec.yaml
                    ),
                  ),
                  const SizedBox(height: 20),
                  reusableTextField("Enter Email Id", Icons.person_outline, false, _emailTextController),
                  const SizedBox(height: 20),
                  reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                  const SizedBox(height: 20),
                  firebaseUIButton(context, "Sign In", () => signIn()),
                  forgetPassword(context),
                  signUpOption(),
                  SizedBox(height: 20),
                  firebaseUIButton(context, "Donate", () {
                    // Donation action or navigation
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Donate()));
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
          child: const Text(" Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text("Forgot Password?", style: TextStyle(color: Colors.white70)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
