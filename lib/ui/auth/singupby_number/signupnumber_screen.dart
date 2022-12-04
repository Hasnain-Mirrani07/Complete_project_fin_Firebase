import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';
import 'package:social_app/ui/auth/singupby_number/verify_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';
import 'package:social_app/utils/constants.dart';

class SignUpNumScreen extends StatefulWidget {
  const SignUpNumScreen({super.key});

  @override
  State<SignUpNumScreen> createState() => _SignUpNumScreenState();
}

class _SignUpNumScreenState extends State<SignUpNumScreen> {
  TextEditingController numController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: numController,
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
            ),
            CustomButton(
              title: "Signup",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.verifyPhoneNumber(
                      phoneNumber: numController.text.toString(),
                      verificationCompleted: (e) {},
                      verificationFailed: (e) {
                        ReUse().loginErrorToast(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => VerifyScreen(
                                      token: token,
                                      verifyId: verificationId,
                                    ))));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        ReUse().loginErrorToast(e.toString());
                      });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
