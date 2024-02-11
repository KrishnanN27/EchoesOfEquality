import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false, // Default to false if not provided
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400), // Adjusted for consistency
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple), // Highlight color when focused
        ),
        fillColor: Colors.grey.shade200, // Slight contrast to scaffold's grey[300]
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontFamily: 'Poppins', // Applying Poppins font family
        ),
      ),
      style: TextStyle(
        fontFamily: 'Poppins', // Ensure input text uses Poppins
      ),
    );
  }
}
