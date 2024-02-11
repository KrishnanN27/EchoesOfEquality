import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
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
    await firestore.collection('mentee_Q').doc('mentee_Q1').set(responses);



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
            _buildQuestion("2. What kind of assistance are you seeking?"),
            DropdownButtonFormField<String>(
              value: _assistanceType.isEmpty ? null : _assistanceType,
              onChanged: (value) => setState(() => _assistanceType = value!),
              items: ["Legal", "Health", "Psychological", "Other"]
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
            _buildQuestion("3. Have you previously sought assistance for the issues you're facing?"),
            DropdownButtonFormField<String>(
              value: _previousAssistance.isEmpty ? null : _previousAssistance,
              onChanged: (value) => setState(() => _previousAssistance = value!),
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
            _buildQuestion("4. Please briefly describe the issues you're facing."),
            TextFormField(
              controller: _issuesDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your description here",
              ),
            ),
            _buildQuestion("5. Are you in a life-threatening situation?"),
            DropdownButtonFormField<String>(
              value: _lifeThreateningSituation.isEmpty ? null : _lifeThreateningSituation,
              onChanged: (value) => setState(() => _lifeThreateningSituation = value!),
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
