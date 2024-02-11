import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    fetchMatches();
  }

  void fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Match_$userId");

    try {
      QuerySnapshot matchSnapshot = await matchCollection.get();

      List<String> matches = matchSnapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>?)?["isMatch"] == "yes") // Cast to Map<String, dynamic>?
          .map((doc) => doc.id)
          .toList();

      List<Map<String, dynamic>> matchDetails = [];

      for (String matchId in matches) {
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("mentee_Q").doc(matchId).get();
        Map<String, dynamic>? matchData = matchDocument.data() as Map<String, dynamic>?; // Nullable map
        if (matchData != null) { // Check if matchData is not null
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
          'Mentor Resources',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: myMatches.isEmpty
            ? Center(
          child: Text(
            'No matches found',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
            ),
          ),
        )
            : ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext ctx, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  'Name: ${myMatches[index]["name"]}',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Description: ${myMatches[index]["description"]}',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  // Implement onTap functionality
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
