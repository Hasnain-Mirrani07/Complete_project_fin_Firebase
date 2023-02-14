import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/test.dart';
import 'package:social_app/testcode/chatgpt.dart';

const urlLandscapeVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4';
const urlPortraitVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
const urlYoutubeVideo = 'https://youtube.com/watch?v=HSAa9yi0OMA';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ReceivedAction? receivedAction = await AwesomeNotifications()
      .getInitialNotificationAction(removeFromActionEvents: false);
  // if(receivedAction?.channelKey == 'call_channel') setInitialPageToCallPage();
  // else setInitialPageToHomePage();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dmemo',
      theme: ThemeData(
        //thdfofdjf;lkdjflhdfghdfhdgfhs
        primarySwatch: Colors.blue,
      ),
      home: const ChatGptScreen(),
    );
  }
}
