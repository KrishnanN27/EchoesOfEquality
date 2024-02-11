import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCreators extends StatelessWidget {
  const AboutCreators({Key? key}) : super(key: key);

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('About Creators', style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
        backgroundColor: Colors.purple, // Enhanced AppBar color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreatorTile(
              name: 'Sowndarya Krishnan Navaneetha Kannan',
              onPressed: () => _launchUrl('https://krishnann27.github.io/sKrishnan/'), // Replace with actual URL
            ),
            CreatorTile(
              name: 'Meta Saka',
              onPressed: () => _launchUrl('https://www.linkedin.com/in/umsaka/'),// Replace with actual URL
            ),
            CreatorTile(
              name: 'Tanmay Tukaram Desai',
                onPressed: () => _launchUrl('https://desaitanmay.owlstown.net/'),  // Replace with actual URL
            ),
          ],
        ),
      ),
    );
  }
}

class CreatorTile extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const CreatorTile({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Add spacing between tiles
      decoration: BoxDecoration(
        color: Colors.white, // Tile background color
        borderRadius: BorderRadius.circular(8), // Rounded corners for tiles
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: ListTile(
        title: Text(name, style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        trailing: IconButton(
          icon: Icon(Icons.link, color: Colors.purple), // Link icon color
          onPressed: onPressed,
        ),
      ),
    );
  }
}
