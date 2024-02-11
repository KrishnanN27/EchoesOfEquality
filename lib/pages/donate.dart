import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Donate extends StatefulWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  List<Map<String, dynamic>> myMatches = [];
  Map<String, TextEditingController> _controllers = {};
  List<String> documentIds = []; // List to store document IDs

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  void fetchMatches() async {
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("requests_for_donation");

    try {
      QuerySnapshot matchSnapshot = await matchCollection.get();

      List<Map<String, dynamic>> matchDetails = [];
      List<String> tempDocumentIds = [];

      for (var doc in matchSnapshot.docs) {
        Map<String, dynamic>? matchData = doc.data() as Map<String, dynamic>?;
        if (matchData != null) {
          matchDetails.add(matchData);
          tempDocumentIds.add(doc.id); // Store document ID
          _controllers[doc.id] = TextEditingController(); // Initialize a controller for each document
        }
      }

      setState(() {
        myMatches = matchDetails;
        documentIds = tempDocumentIds; // Update document IDs
      });
    } catch (e) {
      print("Error fetching matches: $e");
    }
  }

  void donate(String matchId, String donationAmount) async {
    final int donateAmount = int.tryParse(donationAmount) ?? 0;
    if (donateAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid donation amount')));
      return;
    }

    try {
      DocumentSnapshot matchDocument = await FirebaseFirestore.instance.collection("requests_for_donation").doc(matchId).get();

      if (matchDocument.exists) {
        Map<String, dynamic> matchDetails = matchDocument.data() as Map<String, dynamic>;
        int currentCost = int.tryParse(matchDetails["cost"].toString()) ?? 0;
        int updatedCost = currentCost - donateAmount;

        updatedCost = updatedCost < 0 ? 0 : updatedCost;

        await FirebaseFirestore.instance.collection("requests_for_donation").doc(matchId).update({"cost": updatedCost.toString()});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation successful! Remaining amount: $updatedCost')));
        fetchMatches(); // Refresh the list to show updated cost
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Document does not exist')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error processing donation: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donate',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: myMatches.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> matchDetails = myMatches[index];
            String documentId = documentIds[index]; // Retrieve document ID
            TextEditingController? controller = _controllers[documentId];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Title: ${matchDetails["title"]}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${matchDetails["description"]}'),
                        Text('Remaining Amount: ${matchDetails["cost"]}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (controller != null) // Check for null controller
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Enter donation amount',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () => donate(documentId, controller?.text ?? '0'),
                          child: Text('Donate'),
                        ),
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
