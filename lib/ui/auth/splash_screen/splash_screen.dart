import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app/Controller/splashScreen_controller.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splasScreenController().loginCheck(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
