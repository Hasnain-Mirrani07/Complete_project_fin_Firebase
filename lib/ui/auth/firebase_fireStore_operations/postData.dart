import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/showresult/fetchdata_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';

import '../../../utils/constants.dart';

class FireStorePostData extends StatefulWidget {
  const FireStorePostData({super.key});

  @override
  State<FireStorePostData> createState() => _FireStorePostDataState();
}

class _FireStorePostDataState extends State<FireStorePostData> {
  final nameController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.ref('Post');
  final firestore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FireStore Addd Data")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            const Center(
              child: Text("Post DAta Screen"),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Namee',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your email";
                }
                return null;
              },
            ),
            CustomButton(
                title: "Add Data",
                onPressed: () {
                  try {
                    String id = DateTime.now().millisecond.toString();
                    //  debugPrint('press');
                    firestore.doc(id).set({
                      'id': id,
                      'title': nameController.text.toString(),
                    }).then((value) {
                      ReUse().loginErrorToast("Data Added Succfully");
                    });
                    debugPrint(nameController.text);
                    // debugPrint(databaseReference.toString());
                  } catch (e) {
                    debugPrint(e.toString());
                    Text(e.toString());
                    ReUse().loginErrorToast(e.toString());
                    setState(() {});
                  }
                }),
            CustomButton(
                title: "Show Data",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchDataScreen(),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
