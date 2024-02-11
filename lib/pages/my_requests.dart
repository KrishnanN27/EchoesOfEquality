import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  List<Map<String, dynamic>> myMatches = [];

  @override
  void initState() {
    super.initState();
    fetchMatches(); // Fetch matches when the widget is initialized
  }

  void fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("requests_for_donation");
    List<String> matches = [];

    try {
      print("Fetching mentees collection...");
      QuerySnapshot matchSnapshot = await matchCollection.get();

      for (var doc in matchSnapshot.docs) {
      // Assuming 'menteeID' is the field you're interested in
        if (doc.get('menteeId') == userId) { 
          matches.add(doc.id); // Add the document ID to your list if the condition is met
        }
      }
      print("Mentee collection size: ${matches.length}");

      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        print("Fetching details for mentee with ID: $matchId");
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("requests_for_donation").doc(matchId).get();
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
                    title: Text('REQUEST: ${matchDetails["title"]}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mentor: ${matchDetails["mentorId"]}'),
                        Text('Remaining Amount: ${matchDetails["cost"]}'),
                       ],
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