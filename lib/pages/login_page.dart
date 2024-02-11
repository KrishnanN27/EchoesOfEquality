import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echoes_of_equality/pages/main_page.dart';
import 'package:echoes_of_equality/pages/mentee_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:echoes_of_equality/components/my_textfield.dart';
import 'package:echoes_of_equality/components/square_tile.dart';

import 'Mentor_Resources/Mentor_main.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
// Inside your widget class

  Future<void> signUserIn(BuildContext context) async {
    var firestore = FirebaseFirestore.instance;
    String usr = FirebaseAuth.instance.currentUser?.uid ?? '';
    DocumentSnapshot roleFlagSnapshot = await FirebaseFirestore.instance.collection('Role Flag').doc(usr).get();
    if (roleFlagSnapshot.exists && (roleFlagSnapshot.data() as Map<String, dynamic>)['Mentor'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MentorMainPage()));
    }
    else if (roleFlagSnapshot.exists && (roleFlagSnapshot.data() as Map<String, dynamic>)['Mentor'] == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MenteeMainPage()));
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () => signUserIn(context),
                buttonText: 'Sign In',
              ),


              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
