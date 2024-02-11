import 'package:echoes_of_equality/components/my_button.dart';
import 'package:echoes_of_equality/pages/Mentor_Resources/Mentor_main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestEnter extends StatefulWidget {
  @override
  _RequestEnterState createState() => _RequestEnterState();
}

class _RequestEnterState extends State<RequestEnter> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController cost = TextEditingController();
  String recipient = '';
  List<String> menteeIds = [];

  @override
  void initState() {
    super.initState();
    fetchMenteeIds();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    cost.dispose();
    super.dispose();
  }

  void fetchMenteeIds() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference matchCollection = FirebaseFirestore.instance.collection("Mentees_$userId");
    QuerySnapshot matchSnapshot = await matchCollection.get();
    List<String> ids = matchSnapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      menteeIds = ids;
    });
  }

  void _submit(String recipient) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    var firestore = FirebaseFirestore.instance;
    final responses = {
      'mentorId': userId,
      'title': title.text,
      'description': description.text,
      'cost': cost.text,
      'menteeId': recipient,
    };
    await firestore.collection("requests_for_donation").doc(userId+recipient).set(responses);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MentorMainPage()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Request submitted successfully!'),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildQuestion(String questionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        questionText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
      ),
    );
  }

  Widget _customDropdownButton({required List<String> options, required String value, required Function(String?) onChanged}) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      onChanged: onChanged,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontFamily: 'Inter')),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Request', style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildQuestion("1. Title"),
            TextFormField(
              controller: title,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter the title here",
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(fontFamily: 'Inter'),
            ),
            _buildQuestion("2. Description"),
            TextFormField(
              controller: description,
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter the description here",
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(fontFamily: 'Inter'),
            ),
            _buildQuestion("3. Cost"),
            TextFormField(
              controller: cost,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter the cost here",
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(fontFamily: 'Inter'),
            ),
            _buildQuestion("4. Recipient"),
            menteeIds.isNotEmpty
                ? _customDropdownButton(
                    options: menteeIds,
                    value: recipient,
                    onChanged: (String? newValue) {
                      setState(() {
                        recipient = newValue!;
                      });
                    },
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            Center(
              child: MyButton(
                buttonText: "Submit",
                onTap: () async {
                  _submit(recipient);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
