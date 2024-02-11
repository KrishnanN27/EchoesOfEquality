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
      QuerySnapshot matchSnapshot = await matchCollection.get();
      List<String> matches = matchSnapshot.docs.map((doc) => doc.id).toList();
      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("mentee_Q").doc(matchId).get();
        Map<String, dynamic>? matchData = matchDocument.data() as Map<String, dynamic>?;
        if (matchData != null) {
          matchDetails.add(matchData);
        }
      }

      setState(() {
        myMatches = matchDetails;
      });
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
        backgroundColor: Colors.purple, // AppBar background color
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> matchDetails = myMatches[index];
            String displayName = 'Mentee: ${matchDetails["userId"][0].toUpperCase()}'; // Using first letter of userID
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
                      'Life Threatening Situation: ${matchDetails["lifeThreateningSituation"]}\n'
                      'Issues Description: ${matchDetails["issuesDescription"]}\n'
                      'Previous Assistance: ${matchDetails["previousAssistance"]}',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.chat, color: Colors.purple),
                  onPressed: () async{
                    // Simplified example function call
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

                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void initiateChatWithMentee(String menteeId) {
    // Example function to initiate chat
    // Replace with actual navigation and chat initiation logic
    print("Initiating chat with mentee: $menteeId");
    // Navigation to ChatPage or similar would happen here
  }
}
