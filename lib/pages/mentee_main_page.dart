import 'package:echoes_of_equality/pages/questionairre.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';

class MenteeMainPage extends StatelessWidget {
  const MenteeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              MyButton(onTap: () =>    Navigator.push(context, MaterialPageRoute(builder: (context) => Questionairre())),
              buttonText: "Find a Mentor"),
              const SizedBox(height: 20),
              MyButton(onTap: () {}, buttonText: "My Mentors"),
              const SizedBox(height: 20),
              MyButton(onTap: () {}, buttonText: "FILL ME UP"),
            ],
        ),
      ),
    );
  }
}