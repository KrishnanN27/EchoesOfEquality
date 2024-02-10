import 'package:echoes_of_equality/pages/mentee_questions.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:echoes_of_equality/components/square_tile.dart';
import 'package:lottie/lottie.dart';



class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... Existing configurations
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Lottie.asset('assets/animations/main_page.json'),
                ),
              ),

              // logo


              const SizedBox(height: 50),

              // welcome back, you've been missed!
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mentee_Questions(),
                    ),
                  );
                },
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 26,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 25),


              const SizedBox(height: 10),


              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () {},
                buttonText: 'Mentor',
                // Specify the text here
              ),

              const SizedBox(height: 20),

              MyButton(
                onTap: () {},
                buttonText: 'Mentee', // Use a different text for another instance
              ),




              // not a member? register now

            ],
          ),
        ),
      ),
    );
  }
}



