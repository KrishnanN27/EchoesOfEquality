
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final double coverHeight = 280;
  final double profileHeight = 144;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: HexColor('C4BAE0'),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildContent(),
        ],
      )
    );
  }

  buildCoverImage() => Container(
    color: Colors.deepPurple,
    child: Image.asset('assets/images/lgbt.jpg',
    width: double.infinity,
    height: coverHeight,
    fit: BoxFit.cover,),
  );

  buildProfileImage() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.deepPurple,
    backgroundImage: const AssetImage("assets/dp.JPG"),
  );

  buildTop() {

    final bottom = profileHeight/2;

    final top = coverHeight - profileHeight /2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
            top: top,
            child: buildProfileImage())
      ],
    );
  }

  buildContent() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 48
    ),
    child: Column(
        children: [
          SizedBox(height: 15,),
          Text("krishnaofficial27@gmail.com",style: TextStyle(fontSize: 17),),
          SizedBox(height: 15,),
          buildContact(),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Work Experience",style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
          ),
          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: const <TextSpan>[
                  TextSpan(text: 'Software Developer', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 16,fontFamily: 'Raleway')),
                  TextSpan(text: '\nNcompass tech studio', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Raleway',color: Colors.black,fontSize: 17)),
                ],
              ),
            )
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Goal",style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
          ),
          SizedBox(height: 8,),
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children:  <TextSpan>[
                    TextSpan(text: "Krishna's goal is to always exceed our \nclient's expectations with personalized \nservice as we transform their visions into timeless designs", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 16,fontFamily: 'Raleway')),
                  ],
                ),
              )
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                child: Row(
                  children: [
                    Icon(Icons.link,),
                    new Text('More About Krishna',style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),),
                  ],
                ),
                onTap: () => launch('https://www.linkedin.com/in/krishnan-n/')
            ),
          ),

      ],
    ),);
  }

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
    radius: 25,
    child: Center(
      child: Icon(icon,size: 32,),
    ),
  );

  buildContact() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: (){
              launch('tel:+916382125376');
            },
            icon: const Icon(Icons.phone,color: Colors.deepPurple,size: 15),
            label: const Text("Call",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 10),)
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: (){
              launch('sms:+916382125376');

            },
            icon: const Icon(Icons.message_rounded,color: Colors.deepPurple,size: 15,),
            label: const Text("Message",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 10),)
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: (){
              launch('mailto:krishnaofficial27@gmail.com');

            },
            icon: const Icon(Icons.email,color: Colors.deepPurple,size: 15,),
            label: const Text("Email",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 10),)
        ),
      ],
    );
  }

}
