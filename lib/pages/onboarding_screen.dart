
import 'package:echoes_of_equality/pages/intro_screens/intro_page1.dart';
import 'package:echoes_of_equality/pages/intro_screens/intro_page2.dart';
import 'package:echoes_of_equality/pages/intro_screens/intro_page3.dart';
import 'package:echoes_of_equality/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  //Controller to keep track of what page we are in
  final PageController _pageController = PageController();


  //Keep track if we are on the Last Page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index ==2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          onLastPage?
          Container(
              alignment: Alignment(0,0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: const Text("GET STARTED",style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                    onTap: () async{
                        //setting the condition false so that the onboarding screen will appear only one time
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('showHome', false);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                    },

                  )
                ],
              )
          ):
          Container(
            alignment: Alignment(0,0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Text('Skip', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    onTap: () {
                      _pageController.jumpToPage(2);
                    },
                  ),
                  SmoothPageIndicator(controller: _pageController,
                      count: 3,
                    effect:  WormEffect(),
                  ),
                  GestureDetector(
                    child: Text('Next', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    onTap: () {
                      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                  ),
                ],
              )
          )
        ],
      )
    );
  }
}
