import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/ui/auth/home_screen/home_screen.dart';
import 'package:social_app/ui/widgets/custom_button.dart';
import 'package:social_app/utils/constants.dart';

import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  GoogleSignInAccount? _user;
  // final googleSignIn = GoogleSignIn();

  Future gooleSinginFu() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      print("fonction run");
      setState(() {});
    } catch (e) {
      print("Error : $e");
      ReUse().loginErrorToast("Google Sign has Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'TutorialKart',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: GestureDetector(
                    onTap: () {
                      _auth.sendPasswordResetEmail(email: nameController.text);
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: CustomButton(
                      title: "Login",
                      isloading: isLoading,
                      onPressed: () {
                        signIn();
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign UP',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const SignUpScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50)),
                    onPressed: () {
                      gooleSinginFu();
                      print("Function Call");
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text("Signup with Google")),
                // GestureDetector(
                //   onTap: () {},
                //   child: Padding(
                //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                //       child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               height: 100,
                //               width: 100,
                //               decoration: const BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                   "https://blog.hubspot.com/hubfs/image8-2.jpg",
                //                 )),
                //               ),
                //             ),
                //             const Padding(
                //               padding: EdgeInsets.only(left: 10),
                //               child: Text(
                //                 'Sign in with Googleee',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.black54,
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //             )
                //           ])),
                // )
              ],
            )),
      ),
    );
  }

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: nameController.text.toString(),
                password: passwordController.text.toString())
            .then((value) => setState(() {
                  isLoading = false;
                  ReUse().loginErrorToast(value.user!.email.toString());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HomeScreen()));
                }));
      } catch (e) {
        ReUse().loginErrorToast(e.toString());
        ReUse().loginErrorToast("Wrong Email or Password");
      }
    }
  }
}
