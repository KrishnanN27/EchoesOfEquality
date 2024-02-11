
import 'package:echoes_of_equality/pages/login_pages/screens/reset_password.dart';
import 'package:echoes_of_equality/pages/main_page.dart';
import 'package:flutter/material.dart';


class NavigationDrawerForCarLoan extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20,vertical: 25);
  final VoidCallback signOut;


  NavigationDrawerForCarLoan({required this.signOut});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.grey[900],
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 12),
                  // buildSearchField(),
                  const SizedBox(height: 34),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  Divider(color: Colors.white70,thickness: 2,),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
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
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); // Close the drawer

    switch (index) {
      case 0:
      // Navigate to the ResetPassword page
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
