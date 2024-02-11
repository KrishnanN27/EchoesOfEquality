import 'package:echoes_of_equality/pages/mentor_resources.dart';
import 'package:echoes_of_equality/pages/my_Mentors.dart';
import 'package:echoes_of_equality/pages/questionairre_source/mentee_q.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:lottie/lottie.dart';

class MenteeMainPage extends StatelessWidget {
  const MenteeMainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text("Mentee's Space" , style: TextStyle(fontFamily: 'Poppins')),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.05), // Adjust size as a percentage of screen height

              Container(
                // Adjust container size as a percentage of screen size
                height: size.width * 0.5, // Makes the container responsive
                width: size.width * 0.5,
                child: Center(
                  child: Lottie.asset('assets/animations/m.json'),
                ),
              ),
              const SizedBox(height: 20),
              MyButton(onTap: () =>    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnaireScreen())),
              buttonText: "Find a Mentor"),
              const SizedBox(height: 20),
              MyButton(onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyMentors(),
                  ),
                );

              }

                  , buttonText: "My Mentors"),
              const SizedBox(height: 20),
              MyButton(onTap: () {}, buttonText: "FILL ME UP"),
            ],
        ),
      ),
    );
  }
}