import 'package:flutter/material.dart';

class Mentee_Questions extends StatefulWidget {
  const Mentee_Questions({Key? key});

  @override
  State<Mentee_Questions> createState() => _Mentee_QuestionsState();
}

class _Mentee_QuestionsState extends State<Mentee_Questions> {
  String selectedOption = ''; // Variable to store the selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentee Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select an option:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown menu with unique values for each item
            DropdownButton<String>(
              value: selectedOption,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: <String>[
                'Option A',
                'Option B',
                'Option C',
                'Option D',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press, e.g., submit the selected option
                print('Selected Option: $selectedOption');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
