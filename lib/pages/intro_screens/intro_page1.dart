import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
                fontFamily: 'Inter', // Using Raleway for the app name
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
              "Welcome",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins', // Keeping Poppins for consistency
              ),
            ),
            SizedBox(height: 15,),
            Text(
              "One Step solution for your financial calculators and loan manager to"
                  " track your loan progress",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontFamily: 'Inter', // Using Inter for body text for readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}
