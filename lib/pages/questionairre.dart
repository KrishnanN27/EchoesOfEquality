import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:echoes_of_equality/questionairre_source/source.dart';


class Questionairre extends StatefulWidget {
  const Questionairre({super.key});

  @override
  State<Questionairre> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Questionairre> {
  final _key = GlobalKey<QuestionFormState>();
  late final _firestream;
  @override
  void initState() {
    super.initState();
    // _firestream =
    //     FirebaseFirestore.instance.collection('sample').doc('id_1234').get();
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mentee Questionairre"),
      ),
      body:Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            // FirebaseAuth.instance.signOut().then((value) {
            //   print("Signed Out");
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => SignInScreen()));
            // });
          },
        ),
      ),
      
      
      
      // FutureBuilder<DocumentSnapshot>(
      //   //future: _firestream,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData)
      //       return Center(child: CircularProgressIndicator());

      //     return ConditionalQuestions(
      //       key: _key,
      //       children: questions(),
      //       value: snapshot.data!.data(),
      //       trailing: [
      //         MaterialButton(
      //           color: Colors.deepOrange,
      //           splashColor: Colors.orangeAccent,
      //           onPressed: () async {
      //             if (_key.currentState!.validate()) {
      //               print("validated!");
      //               // FirebaseFirestore.instance
      //               //     .collection('sample')
      //               //     .doc('id_1234')
      //               //     .set(_key.currentState!.toMap());
      //             }
      //           },
      //           child: Text("Submit"),
      //         )
      //       ],
      //       leading: [Text("TITLE")],
      //     );
      //   },
      // ),
    );
  }
}





// class Questionairre extends StatelessWidget {
//   Questionairre({super.key});
//   final _key = GlobalKey<QuestionFormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Questionairre"),
//       ),
//       body: ConditionalQuestions(
//         key: _key,
//         children: questions(),
//         trailing: [
//           MaterialButton(
//             color: Colors.deepOrange,
//             splashColor: Colors.orangeAccent,
//             onPressed: () async {
//               if (_key.currentState!.validate()) {
//                 print("validated!");
//               }
//             },
//             child: Text("Submit"),
//           )
//         ],
//         leading: [Text("TITLE")],
//       ),
//     );
//   }
// }



