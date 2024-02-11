import 'package:echoes_of_equality/components/my_button.dart';
import 'package:echoes_of_equality/pages/mentee_main_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}


class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  // Your state variables remain unchanged
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
    var firestore = FirebaseFirestore.instance;
    //await firestore.collection('mentee_Q').add(responses);
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final responses = {
      'userId': userId,
      'lgbtqiaPlusMember': _lgbtqiaPlusMember,
      'assistanceType': _assistanceType,
      'previousAssistance': _previousAssistance,
      'issuesDescription': _issuesDescriptionController.text,
      'lifeThreateningSituation': _lifeThreateningSituation,
    };
    // Here, you would typically send the collected data to your backend or Firebase.
    //print('Collected Responses: $responses');

    await firestore.collection("mentee_Q").doc(userId).set(responses);

    Navigator.push(context, MaterialPageRoute(builder: (context) => MenteeMainPage()));

  }

  Widget _buildQuestion(String questionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        questionText,
        textAlign: TextAlign.left, // Adjust text alignment if necessary
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
      ),
    );
  }

  Widget _customDropdownButton({
    required List<String> options,
    required String value,
    required Function(String?) onChanged,
  }) {
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
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold and other widget setup remains unchanged

    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire', style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            _buildQuestion("2. What kind of assistance are you seeking?"),
            _customDropdownButton(
              options: ["Legal", "Health", "Psychological", "Other"],
              value: _assistanceType,
              onChanged: (String? newValue) {
                setState(() {
                  _assistanceType = newValue!;
                });
              },
            ),
            _buildQuestion("3. Have you previously sought assistance for the issues you're facing?"),
            _customDropdownButton(
              options: ["Yes", "No"],
              value: _previousAssistance,
              onChanged: (String? newValue) {
                setState(() {
                  _previousAssistance = newValue!;
                });
              },
            ),


            // Repeated for other questions...
            _buildQuestion("4. Please briefly describe the issues you're facing."),
            TextFormField(
              controller: _issuesDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter your description here",
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              style: TextStyle(fontFamily: 'Inter'),
            ),
            _buildQuestion("5. Are you in a life-threatening situation?"),
            _customDropdownButton(
              options: ["Yes", "No"],
              value: _lifeThreateningSituation,
              onChanged: (String? newValue) {
                setState(() {
                  _lifeThreateningSituation = newValue!;
                });
              },
            ),

            // Continue with the setup for other questions...
            SizedBox(height: 20),
            Center(
              child: MyButton(
                buttonText: 'Submit',
                onTap: () => _submit(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
