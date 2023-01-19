import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ui/auth/login/login_screen.dart';
import 'package:social_app/ui/auth/notifications.dart';
import 'package:social_app/ui/auth/post_data/postdata_screen.dart';
import 'package:social_app/ui/auth/showresult/fetchdata_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  void creatNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            actionType: ActionType.Default));
  }

  @override
  void initState() {
    super.initState();
    // Only after at least the action method is srgerttrhrtyet, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home screen"), actions: [
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
                const Text("Not abc logout yet");
              }
            },
            child: const Icon(Icons.login_outlined))
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            const Text("Homee Screen"),
            const SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostDataScreen(),
                    ));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                title: "Show Data",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FetchDataScreen(),
                      ));
                }),
            ElevatedButton(
              onPressed: creatNotification,
              child: const Text("notification"),
            )
          ],
        ),
      ),
    );
  }
}
