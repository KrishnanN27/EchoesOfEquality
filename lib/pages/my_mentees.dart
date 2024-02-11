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

  Future<List<Map<String, dynamic>>> fetchMatches() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Mentees_$userId");
    List<Map<String, dynamic>> matchDetails = [];

    try {
      QuerySnapshot matchSnapshot = await matchCollection.get();
      List<String> matches = matchSnapshot.docs.map((doc) => doc.id).toList();

      for (String matchId in matches) {
        DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("mentee_Q").doc(matchId).get();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Mentees',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 20),
        ),
        backgroundColor: Colors.grey[300], // AppBar background color
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
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
    return Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Image.asset('assets/images/404.png', height: 200, width: 200, fit: BoxFit.cover),
    SizedBox(height: 8),
    Text("No new mentees found", style: TextStyle(fontSize: 16, color: Colors.black54, fontFamily: 'Poppins')),
    ],
    ),
    );
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> matchDetails = myMatches[index];
            String displayName = 'Mentee: ${matchDetails["userId"][0].toUpperCase()}'; // Using first letter of userID
            return Card(
              margin: EdgeInsets.only(bottom: 16.0),
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
                  onPressed: () async {

                    String CurrentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
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
                    // Simplified example function call
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
