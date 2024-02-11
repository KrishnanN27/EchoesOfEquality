import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_files/chat_page.dart';
import 'login_pages/auth_service.dart';
import 'main_page.dart';

class MyMentees extends StatefulWidget {
  const MyMentees({Key? key}) : super(key: key);

  @override
  State<MyMentees> createState() => _MyMenteesState();
}

class _MyMenteesState extends State<MyMentees> {
  List<Map<String, dynamic>> myMatches = [];

  @override
  void initState() {
    super.initState();
    fetchMatches(); // Fetch matches when the widget is initialized
  }

  void fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Mentees_$userId");

    try {
      print("Fetching mentees collection...");
      QuerySnapshot matchSnapshot = await matchCollection.get();

      List<String> matches = matchSnapshot.docs
          .map((doc) => doc.id)
          .toList();

      print("Mentee collection size: ${matches.length}");

      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        print("Fetching details for mentee with ID: $matchId");
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("mentee_Q").doc(matchId).get();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Mentees',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext context, int index) {
            // Extracting match details
            Map<String, dynamic> matchDetails = myMatches[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Mentee ID: ${matchDetails["userId"]}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LGBTQIA+ Member: ${matchDetails["lgbtqiaPlusMember"]}'),
                        Text('Assistance Type: ${matchDetails["assistanceType"]}'),
                        Text('Life Threatening Situation: ${matchDetails["lifeThreateningSituation"]}'),
                        Text('Issues Description: ${matchDetails["issuesDescription"]}'),
                        Text('Previous Assistance: ${matchDetails["previousAssistance"]}'),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Implement accept functionality

                          // CHAT!!!!!
                        ;

                          // Get the current user's ID
                          String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

                          // Get user data
                          Map<String, dynamic> userData = await AuthService().getUserData(matchDetails["userId"]);

                          // Pass user data to ChatPage
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

                        child: Text('Chat with Mentee'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}