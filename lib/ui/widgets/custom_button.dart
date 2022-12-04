import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  bool isloading;
  VoidCallback onPressed;

  CustomButton(
      {super.key,
      required this.title,
      this.isloading = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: isloading ? CircularProgressIndicator() : Text(title),
        onPressed: onPressed);
  }
}
