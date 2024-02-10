import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_service.dart';
import '../../../components/color_utils.dart';
import '../reusable_widgets/reusable_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  String? _selectedRole; // For dropdown selection

  void signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
        _emailTextController.text,
        _passwordTextController.text,
      );
      // After successful signup, navigate or show success message
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.15, 20, 0),
              child: Column(
                children: [
                  reusableTextField("Enter UserName", Icons.person_outline, false, _userNameTextController, fontFamily: "Raleway"),
                  SizedBox(height: 20),
                  reusableTextField("Enter Email Id", Icons.email_outlined, false, _emailTextController, fontFamily: "Inter"),
                  SizedBox(height: 20),
                  reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController, fontFamily: "Raleway"),
                  SizedBox(height: 20),
                  Text("What do you want to do?", style: TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: "Inter")),
                  SizedBox(height: 20),
                  customDropdownButton(
                    "Select an option",
                    ['Mentor', 'Mentee'],
                    _selectedRole,
                        (String? value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),

                  SizedBox(height: 40),
                  firebaseUIButton(context, "Sign Up", signUp, fontFamily: "Poppins"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDropdownButton(String hint, List<String> items, String? selectedValue, ValueChanged<String?> onChanged, {String fontFamily = 'Raleway'}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: Colors.white.withOpacity(0.8),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white70),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black, fontFamily: fontFamily),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: fontFamily)),
        ),
      ),
    );
  }
}
