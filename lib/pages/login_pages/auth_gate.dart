import 'package:echoes_of_equality/pages/login_pages/screens/signin_screen.dart';
import 'package:echoes_of_equality/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  get snapshot => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const MainPage();
          }
          else{
            return const SignInScreen();
          }
        }
      ),
    );
  }
}
