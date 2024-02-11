
import 'package:echoes_of_equality/components/navigation_drawer_for_car_loan.dart';
import 'package:echoes_of_equality/pages/chat_files/chat_page.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_service.dart';
import 'package:echoes_of_equality/pages/login_pages/screens/signin_screen.dart';
import 'package:echoes_of_equality/pages/mentee_main_page.dart';
import 'package:echoes_of_equality/pages/questionairre_source/mentor_q.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'Mentor_Resources/Mentor_main.dart';

bool flag = false;
var firestore = FirebaseFirestore.instance;
String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void signOut(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),

    );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Signed out successfully!"),
    ));

  }

  void roleflag() async{
    final responses = {

      'Mentor': flag,
    };

    await firestore.collection("Role Flag").doc(userId).set(responses);
}

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
      ),

        endDrawer: NavigationDrawerForCarLoan(signOut: () => signOut(context)),

      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView for scrollable behavior
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05), // Adjust size as a percentage of screen height

                Container(
                  // Adjust container size as a percentage of screen size
                  height: size.width * 0.5, // Makes the container responsive
                  width: size.width * 0.5,
                  child: Center(
                    child: Lottie.asset('assets/animations/main_page.json'),
                  ),
                ),

                SizedBox(height: size.height * 0.05), // Responsive spacing

                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: size.width * 0.07, // Responsive font size
                    fontFamily: 'Poppins',
                  ),
                ),

                SizedBox(height: size.height * 0.03), // Responsive spacing

                MyButton(
                  onTap: () async {
                    DocumentSnapshot roleFlagSnapshot = await FirebaseFirestore.instance.collection('Role Flag').doc(userId).get();
                    if (roleFlagSnapshot.exists && (roleFlagSnapshot.data() as Map<String, dynamic>)['Mentor'] == true) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MentorMainPage()));
                    } else {

                    flag = true;
                    roleflag();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnaireScreenMentor()));
                    }},
                  buttonText: 'Mentor',
                ),

                SizedBox(height: size.height * 0.02), // Responsive spacing

              MyButton(
                onTap: () {
                  flag = false;
                  roleflag();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenteeMainPage()));
                },

                buttonText: 'Mentee', // Use a different text for another instance
                
                
              ),

                MyButton(
                  onTap: () async {
                    // Get the current user's ID
                    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

                    // Get user data
                    Map<String, dynamic> userData = await AuthService().getUserData(currentUserId);

                    // Pass user data to ChatPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserEmail: userData['email'],
                          receiverUserID: currentUserId,
                        ),
                      ),
                    );
                  },
                  buttonText: 'Chat',
                ),


              // not a member? register now

            ],
          ),
        ),
      ),
    ));
  }
}
