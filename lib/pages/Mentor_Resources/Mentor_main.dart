import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';

import '../chat_files/chat_page.dart';
import '../questionairre_source/mentee_q.dart';

class MentorMainPage extends StatelessWidget {
  const MentorMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            MyButton(onTap: () {},//=>    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage())),
                buttonText: "My Mentees"),
            const SizedBox(height: 20),
            MyButton(onTap: () {}, buttonText: "Mentee Requests"),
            const SizedBox(height: 20),
            MyButton(onTap: () {}, buttonText: "New Mentees"),
          ],
        ),
      ),
    );
  }
}