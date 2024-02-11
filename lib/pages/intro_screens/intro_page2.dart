import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black26,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Engage in Meaningful Conversations",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Poppins', // Consistent with subheadings
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/animations/i1.json'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Support and Funding",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'Poppins', // Emphasizing the funding aspect
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Seek support for your needs or contribute to someone's journey. Every donation brings us closer to equality and acceptance.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white70,
                fontFamily: 'Inter', // Ensuring readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}
