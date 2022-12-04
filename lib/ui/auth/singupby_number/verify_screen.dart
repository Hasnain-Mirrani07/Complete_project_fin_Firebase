import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';
import 'package:social_app/utils/constants.dart';

class VerifyScreen extends StatefulWidget {
  final String? verifyId;
  final int? token;

  VerifyScreen({super.key, required this.token, required this.verifyId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
