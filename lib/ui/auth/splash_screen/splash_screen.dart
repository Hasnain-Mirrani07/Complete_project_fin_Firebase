import 'package:flutter/material.dart';
import 'package:social_app/Controller/splashScreen_controller.dart';

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
  } //jskdhflakjdfalksjd

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Sacreen"),
      ),
    );
  }
}
