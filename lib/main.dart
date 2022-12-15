import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/firebase_fireStore_operations/fireStore_mainscreen.dart';
import 'package:social_app/ui/auth/firebase_fireStore_operations/image_upload.dart';
import 'package:social_app/ui/auth/home_screen/home_screen.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';
import 'package:social_app/ui/auth/splash_screen/splash_screen.dart';

final urlLandscapeVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4';
final urlPortraitVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
final urlYoutubeVideo = 'https://youtube.com/watch?v=HSAa9yi0OMA';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //thdfofdjf;lkdjflsajf
        primarySwatch: Colors.blue,
      ),
      home: const ImageUploadingApi(),
    );
  }
}
