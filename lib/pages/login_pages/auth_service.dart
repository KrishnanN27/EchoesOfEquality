
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Instance for firestone
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      }, SetOptions(merge: true));
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }
//create a new user


  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // after creating the user, create user in user collection
       _firestore.collection('users').doc(userCredential.user!.uid).set({
         'uid' : userCredential.user!.uid,
         'email' : email,
       });

      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }

  }


  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
      await _firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

//   SignOut
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
  }
}