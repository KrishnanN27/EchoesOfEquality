import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echoes_of_equality/components/my_textfield.dart';
import 'package:echoes_of_equality/components/utils/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  // Example of how to initiate a chat
  void startChat(String receiverUserId, String receiverUserEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          receiverUserID: receiverUserId,
          receiverUserEmail: receiverUserEmail,
        ),
      ),
    );
  }

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Set scaffold background color
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.receiverUserEmail, style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
        backgroundColor: Colors.grey[300], // AppBar background color to match scaffold
        elevation: 0, // Remove shadow
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState==ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }


  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data() as Map<String,dynamic>;

    var alignment = (data['senderid'] == _firebaseAuth.currentUser!.uid)
    ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderid'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderid'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      )
      );
  }
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter message',
              obscureText: false,
              // Ensure MyTextField uses Poppins if it doesn't by default
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              size: 40,
              color: Colors.purple, // Setting the icon color to purple
            ),
          ),

        ],
      ),
    );
  }
}