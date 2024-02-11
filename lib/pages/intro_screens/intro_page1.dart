import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white30,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Echoes of Equality",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Inter', // Adjusted for the app name
              ),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/animations/i0.json'),
              ),
            ),
            Text(
              "Connect with Mentors",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins', // Using Poppins for title
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Find and connect with experienced mentors to guide you through your journey. A supportive community awaits.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontFamily: 'Inter', // Using Inter for body text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
