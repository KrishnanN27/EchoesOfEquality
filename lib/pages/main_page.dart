
import 'package:conditional_questions/conditional_questions.dart';
import 'package:echoes_of_equality/pages/login_page.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_service.dart';
import 'package:echoes_of_equality/pages/login_pages/screens/signin_screen.dart';
import 'package:echoes_of_equality/pages/mentee_main_page.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';



class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void signOut(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),

    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Signed out, bitches!"),
    ));

  }


  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => signOut(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.grey[300],
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
                  onTap: () {},
                  buttonText: 'Mentor',
                ),

                SizedBox(height: size.height * 0.02), // Responsive spacing


              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () {},
                buttonText: 'Mentor',
                // Specify the text here
              ),

              const SizedBox(height: 20),

              MyButton(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenteeMainPage())),
                buttonText: 'Mentee', // Use a different text for another instance
              ),




              // not a member? register now

            ],
          ),
        ),
      ),
    ));
  }
}
