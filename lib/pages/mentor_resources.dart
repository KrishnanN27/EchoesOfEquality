import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main_page.dart';

class MentorResources extends StatefulWidget {
  const MentorResources({Key? key}) : super(key: key);

  @override
  State<MentorResources> createState() => _MentorResourcesState();
}

class _MentorResourcesState extends State<MentorResources> {
  List<Map<String, dynamic>> myMatches = [];

  @override
  void initState() {
    super.initState();
    fetchMatches(); // Fetch matches when the widget is initialized
  }
  Future<void> _acceptMatch(String matchId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    await firestore.collection("Matches_$userId").doc(matchId).set({"isMatch": "no","oldMatch": "yes"});
    await firestore.collection("Mentees_$userId").doc(matchId).set({"matchId":matchId});
    await firestore.collection("Mentors_$matchId").doc(userId).set({"matchId":userId});

    // Perform actions when the match is accepted

    print('Match accepted with ID: $matchId');
    // Add your logic here
  }
  void fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Matches_$userId");

    try {
      print("Fetching match collection...");
      QuerySnapshot matchSnapshot = await matchCollection.get();

      List<String> matches = matchSnapshot.docs
          .where((doc) => ((doc.data() as Map<String, dynamic>?)?["isMatch"] == "yes") &&
          ((doc.data() as Map<String, dynamic>?)?["oldMatch"] != "yes"))
          .map((doc) => doc.id)
          .toList();

      print("Match collection size: ${matches.length}");

      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        print("Fetching details for match with ID: $matchId");
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
          'Mentor Resources',
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
                    title: Text('Match ID: ${matchDetails["userId"]}'),
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
                        onPressed: () {
                          // Implement accept functionality
                          _acceptMatch(matchDetails["userId"]);
                        },
                        child: Text('Accept'),
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