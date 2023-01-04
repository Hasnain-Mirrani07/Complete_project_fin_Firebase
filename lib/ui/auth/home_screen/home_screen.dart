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
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("AllowNotification"),
              content: const Text("AllowNotification content"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Don\t Allow"),
                ),
                TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Allow",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
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
                const Text("Not logout yet");
              }
            },
            child: const Icon(Icons.login_outlined))
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            Text("Home Screen"),
            SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDataScreen(),
                    ));
              },
            ),
            SizedBox(
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
              onPressed: createNotification,
              child: Text("notification"),
            )
          ],
        ),
      ),
    );
  }
}
