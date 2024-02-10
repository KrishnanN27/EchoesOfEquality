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
              "We love everyone",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Poppins', // Consistent with subheadings/important messages
              ),
            ),
            SizedBox(height: 45,),
            SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Lottie.asset('assets/animations/i1.json'),
              ),
            ),
            SizedBox(height: 45,),
            Text(
              "Equally!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
                fontFamily: 'Poppins', // Using Poppins for emphasis on "Equally!"
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home),
                SizedBox(width: 15,),
                Icon(Icons.person),
                SizedBox(width: 15,),
                Icon(Icons.car_crash_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
