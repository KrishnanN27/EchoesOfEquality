import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_files/chat_page.dart';
import 'login_pages/auth_service.dart';
import 'main_page.dart';

class MyMentors extends StatefulWidget {
  const MyMentors({Key? key}) : super(key: key);

  @override
  State<MyMentors> createState() => _MyMentorsState();
}

class _MyMentorsState extends State<MyMentors> {
  List<Map<String, dynamic>> myMatches = [];

  @override
  void initState() {
    super.initState();
    fetchMatches(); // Fetch matches when the widget is initialized
  }

  void fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Mentors_$userId");

    try {
      print("Fetching mentors collection...");
      QuerySnapshot matchSnapshot = await matchCollection.get();

      List<String> matches = matchSnapshot.docs
          .map((doc) => doc.id)
          .toList();

      print("Mentor collection size: ${matches.length}");

      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        print("Fetching details for mentor with ID: $matchId");
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("mentor_Q").doc(matchId).get();
        Map<String, dynamic>? matchData = matchDocument.data() as Map<String, dynamic>?; // Nullable map
        if (matchData != null) { // Check if matchData is not null
          print("Match details fetched: $matchData");
          matchDetails.add(matchData);
        }
      }

      setState(() {
        myMatches = matchDetails;
      });
      print("Matches fetched successfully.");
    } catch (e) {
      print("Error fetching matches: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'My Mentors',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[300], // Changed AppBar background color to purple
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjusted padding to match MyMentees
        child: ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> matchDetails = myMatches[index];
            // Simplified display name to use the first letter of the mentor's ID
            String displayName = 'Mentor: ${matchDetails["userId"][0].toUpperCase()}';
            return Card(
              margin: EdgeInsets.only(bottom: 8.0),
              elevation: 2.0,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  displayName,
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                subtitle: Text(
                  'LGBTQIA+ Member: ${matchDetails["lgbtqiaPlusMember"]}\n'
                      'Assistance Type: ${matchDetails["assistanceType"]}\n'
                      'Background: ${matchDetails["issuesDescription"]}\n'
                      'Past Experience: ${matchDetails["previousAssistance"]}',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.chat, color: Colors.purple),
                  onPressed: () async {
                    // Implement chat functionality
                    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
                    Map<String, dynamic> userData = await AuthService().getUserData(matchDetails["userId"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserEmail: userData['email'],
                          receiverUserID: matchDetails["userId"],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}