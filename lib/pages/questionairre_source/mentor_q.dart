import 'package:echoes_of_equality/pages/Mentor_Resources/Mentor_main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Static Questionnaire App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuestionnaireScreen(),
//     );
//   }
// }

class QuestionnaireScreenMentor extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreenMentor> {
  String _lgbtqiaPlusMember = '';
  String _assistanceType = '';
  String _previousAssistance = '';
  String _lifeThreateningSituation = '';
  final TextEditingController _issuesDescriptionController = TextEditingController();

  @override
  void dispose() {
    _issuesDescriptionController.dispose();
    super.dispose();
  }

  void _submit() async {
    final responses = {

      'lgbtqiaPlusMember': _lgbtqiaPlusMember,
      'assistanceType': _assistanceType,
      'previousAssistance': _previousAssistance,
      'issuesDescription': _issuesDescriptionController.text,
      'lifeThreateningSituation': _lifeThreateningSituation,
    };
    // Here, you would typically send the collected data to your backend or Firebase.
    //print('Collected Responses: $responses');
    var firestore = FirebaseFirestore.instance;
    //await firestore.collection('mentee_Q').add(responses);
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    await firestore.collection("mentor_Q").doc(userId).set(responses);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MentorMainPage()));


  }

  Widget _buildQuestion(String questionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              questionText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildQuestion("1. Do you identify as a member of the LGBTQIA+ community?"),
            DropdownButtonFormField<String>(
              value: _lgbtqiaPlusMember.isEmpty ? null : _lgbtqiaPlusMember,
              onChanged: (value) => setState(() => _lgbtqiaPlusMember = value!),
              items: ["Yes", "No"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            _buildQuestion("2. What kind of assistance can you provide?"),
            DropdownButtonFormField<String>(
              value: _assistanceType.isEmpty ? null : _assistanceType,
              onChanged: (value) => setState(() => _assistanceType = value!),
              items: ["Legal", "Health", "Psychological", "General"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            _buildQuestion("3. How many years have you provided assistance for LGBTQIA+?"),
            DropdownButtonFormField<String>(
              value: _previousAssistance.isEmpty ? null : _previousAssistance,
              onChanged: (value) => setState(() => _previousAssistance = value!),
              items: ["0-5 years", "5-10 years", "10+ years "].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            _buildQuestion("4. Please tell about yourself."),
            TextFormField(
              controller: _issuesDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your description here",
              ),
            ),
            _buildQuestion("5. How many hours per week can you dedicate to our cause?"),
            DropdownButtonFormField<String>(
              value: _lifeThreateningSituation.isEmpty ? null : _lifeThreateningSituation,
              onChanged: (value) => setState(() => _lifeThreateningSituation = value!),
              items: ["0-5 hours", "5-10 hours", "10-15 hours "].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
