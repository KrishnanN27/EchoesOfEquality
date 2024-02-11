import 'package:echoes_of_equality/components/my_button.dart';
import 'package:echoes_of_equality/pages/Mentor_Resources/Mentor_main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        title: Text('Questionnaire', style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildQuestion("1. Do you identify as a member of the LGBTQIA+ community?"),
            _customDropdownButton(
              options: ["Yes", "No"],
              value: _lgbtqiaPlusMember,
              onChanged: (String? newValue) {
                setState(() {
                  _lgbtqiaPlusMember = newValue!;
                });
              },
            ),
            _buildQuestion("2. What kind of assistance can you provide?"),
            _customDropdownButton(
              options: ["Legal", "Health", "Psychological", "General"],
              value: _assistanceType,
              onChanged: (String? newValue) {
                setState(() {
                  _assistanceType = newValue!;
                });
              },
            ),
            _buildQuestion("3. How many years have you provided assistance for LGBTQIA+?"),
            _customDropdownButton(
              options: ["0-5 years", "5-10 years", "10+ years"],
              value: _previousAssistance,
              onChanged: (String? newValue) {
                setState(() {
                  _previousAssistance = newValue!;
                });
              },
            ),
            _buildQuestion("4. Please tell about yourself."),
            TextFormField(
              controller: _issuesDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter your description here",
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(fontFamily: 'Inter'),
            ),
            _buildQuestion("5. How many hours per week can you dedicate to our cause?"),
            _customDropdownButton(
              options: ["0-5 hours", "5-10 hours", "10-15 hours"],
              value: _lifeThreateningSituation,
              onChanged: (String? newValue) {
                setState(() {
                  _lifeThreateningSituation = newValue!;
                });
              },
            ),




            // Repeat for other questions...
            SizedBox(height: 20),
            Center(
              child: MyButton(
                buttonText: "Submit",
                onTap: () async {
                  // Add your code here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
