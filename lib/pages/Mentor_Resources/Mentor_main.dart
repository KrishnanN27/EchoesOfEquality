import 'package:echoes_of_equality/pages/create_req.dart';
import 'package:echoes_of_equality/pages/mentor_resources.dart';
import 'package:echoes_of_equality/pages/my_mentees.dart';
import 'package:flutter/material.dart';
import 'package:echoes_of_equality/components/my_button.dart';
import 'package:lottie/lottie.dart';

import '../chat_files/chat_page.dart';
import '../questionairre_source/mentee_q.dart';

class MentorMainPage extends StatelessWidget {
  const MentorMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: Text("Mentor's Space", style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              // Adjust container size as a percentage of screen size
              height: size.width * 0.5, // Makes the container responsive
              width: size.width * 0.5,
              child: Center(
                child: Lottie.asset('assets/animations/men.json'),
              ),
            ),

            SizedBox(height: size.height * 0.05), // Adjust size as a percentage of screen height

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