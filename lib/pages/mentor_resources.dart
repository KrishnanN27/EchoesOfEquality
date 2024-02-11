import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MentorResources extends StatefulWidget {
  const MentorResources({Key? key}) : super(key: key);

  @override
  State<MentorResources> createState() => _MentorResourcesState();
}

class _MentorResourcesState extends State<MentorResources> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = firestore.collection("Matches_$userId");

    List<Map<String, dynamic>> matchDetails = [];

    try {
      QuerySnapshot matchSnapshot = await matchCollection.get();
      List<String> matches = matchSnapshot.docs
          .where((doc) => ((doc.data() as Map<String, dynamic>?)?["isMatch"] == "yes") &&
          ((doc.data() as Map<String, dynamic>?)?["oldMatch"] != "yes"))
          .map((doc) => doc.id)
          .toList();

      for (String matchId in matches) {
        DocumentSnapshot matchDocument = await firestore.collection("mentee_Q").doc(matchId).get();
        Map<String, dynamic>? matchData = matchDocument.data() as Map<String, dynamic>?;
        if (matchData != null) {
          matchDetails.add(matchData);
        }
      }
    } catch (e) {
      print("Error fetching matches: $e");
    }

    return matchDetails;
  }

  Future<void> _acceptMatch(String matchId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Assuming you want to update some status in Firestore when a match is accepted
    await firestore.collection("Matches_$userId").doc(matchId).set({"isMatch": "no","oldMatch":"yes"});
    await firestore.collection("Mentees_$userId").doc(matchId).set({"matchId": matchId});
    await firestore.collection("Mentors_$matchId").doc(userId).set({"isMatch": userId});

    // Additional Firestore updates or logic after accepting a match can go here

    // Refresh data to reflect the changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Mentees',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/404.png', height: 200, width: 200, fit: BoxFit.cover),
                SizedBox(height: 8),
                Text("No new mentees found", style: TextStyle(fontSize: 16, color: Colors.black54, fontFamily: 'Poppins')),
              ],
            ));

          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> matchDetails = snapshot.data![index];

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
                            onPressed: () => _acceptMatch(matchDetails["userId"]),
                            child: Text('Accept'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
