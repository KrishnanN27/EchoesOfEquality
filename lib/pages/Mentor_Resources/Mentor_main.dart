import 'package:echoes_of_equality/pages/create_req.dart';
import 'package:echoes_of_equality/pages/mentor_resources.dart';
import 'package:echoes_of_equality/pages/my_mentees.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';

import '../chat_files/chat_page.dart';
import '../questionairre_source/mentee_q.dart';

class MentorMainPage extends StatelessWidget {
  const MentorMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: Text("Mentor's Space", style: TextStyle(fontFamily: 'Poppins')),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            MyButton(onTap: () =>    Navigator.push(context, MaterialPageRoute(builder: (context) => MyMentees())),

                buttonText: "My Mentees"),
            const SizedBox(height: 20),
            MyButton(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RequestEnter())), buttonText: "Create Request"),
            const SizedBox(height: 20),
            MyButton(onTap: () {
            //   navigate to mentor resources
              Navigator.push(context, MaterialPageRoute(builder: (context) => MentorResources()));
            }, buttonText: "New Mentees"),
          ],
        ),
      ),
    );
  }
}