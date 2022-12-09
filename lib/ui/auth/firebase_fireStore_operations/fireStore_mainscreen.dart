import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/firebase_fireStore_operations/postData.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';
import 'package:social_app/ui/auth/post_data/postdata_screen.dart';
import 'package:social_app/ui/auth/showresult/fetchdata_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';

import 'getdata.dart';

class FireStoreMainScree extends StatefulWidget {
  const FireStoreMainScree({super.key});

  @override
  State<FireStoreMainScree> createState() => _FireStoreMainScreeState();
}

class _FireStoreMainScreeState extends State<FireStoreMainScree> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FireStore Main Screen"), actions: [
        GestureDetector(
            onTap: () {
              try {
                _auth.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginScreen()));
                });
              } catch (e) {
                const Text("Not logout yet");
              }
            },
            child: const Icon(Icons.login_outlined))
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            Text("Home Screen"),
            SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FireStorePostData(),
                    ));
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
                title: "Show Data",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FireStoreGetData(),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
