import 'package:echoes_of_equality/pages/login_pages/screens/reset_password.dart';
import 'package:echoes_of_equality/pages/login_pages/screens/user_profile.dart';
import 'package:echoes_of_equality/pages/main_page.dart';
import 'package:flutter/material.dart';

class NavigationDrawerForCarLoan extends StatelessWidget {
  final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20, vertical: 25);
  final VoidCallback signOut;

  NavigationDrawerForCarLoan({required this.signOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.grey[400], // Drawer background color
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 34),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  SizedBox(height: 24),
                  Divider(color: Colors.white70, thickness: 2),

                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),

                  Divider(color: Colors.white70, thickness: 2),

                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'About Creators',
                    icon: Icons.people_sharp,
                    onClicked: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return InkWell(
      onTap: onClicked,
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6E48AA), Color(0xFF9D50BB)], // Example gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10), // Add corner radius here
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 20), // Space between icon and text
            Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); // Close the drawer

    switch (index) {
      case 0:
      // Navigate to the MainPage
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
        break;
      case 1:
      // Call the signOut function
        signOut();
        break;
    }
  }
}
