import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/firebase_fireStore_operations/getdata.dart';
import 'package:social_app/ui/widgets/custom_button.dart';

import '../../../utils/constants.dart';

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({super.key});

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final nameController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            const Center(
              child: Text("Post Dhta Screen"),
            ),
            TextFormField(
              controller: nameController,
              onChanged: (value) {
                nameController.text = "";
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
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
                    databaseReference.child(id).set({
                      'id': id,
                      'title': nameController.text.toString(),
                    }).then((value) {
                      setState(() {});

                      ReUse().loginErrorToast("Data Aded Succfully");
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
                title: "Show Daata",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FireStoreGetData(),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
