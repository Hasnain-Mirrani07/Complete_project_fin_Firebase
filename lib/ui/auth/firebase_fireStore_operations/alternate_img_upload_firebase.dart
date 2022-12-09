// //Another method for img upload on Firebase
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import 'forget_password.dart';
// import 'home.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var spinner = false;
//   final storage = FirebaseStorage.instance;

//   Future<void> uploadFile(String filePath, String fileName) async {
//     File file = File(filePath);
//     try {
//       await storage.ref('test/$fileName').putFile(file);
//     } on FirebaseException catch (e) {
//       print(e);
//     }
//   }

//   //var auth=FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 100),
//         child: ModalProgressHUD(
//           inAsyncCall: spinner,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             'https://maktechblog.com/wp-content/uploads/2016/04/Google-Play-Movies-TV-new-icon.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 300,
//                   padding: EdgeInsets.all(10),
//                   child: TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         labelText: "Phone number,username,or email",
//                         labelStyle: TextStyle(fontSize: 12),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xff353b48)),
//                             borderRadius: BorderRadius.circular(5)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xff353b48)),
//                             borderRadius: BorderRadius.circular(5))),
//                   ),
//                 ),
//                 Container(
//                   width: 300,
//                   padding: EdgeInsets.all(10),
//                   child: TextField(
//                     controller: passwordController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xff353b48)),
//                           borderRadius: BorderRadius.circular(5)),
//                       labelText: "Password",
//                       labelStyle: TextStyle(fontSize: 12),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xff353b48)),
//                           borderRadius: BorderRadius.circular(5)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 280,
//                   child: MaterialButton(
//                     onPressed: () async {
//                       setState(() {
//                         spinner = true;
//                       });

//                       await FirebaseAuth.instance
//                           .signInWithEmailAndPassword(
//                               email: emailController.text,
//                               password: passwordController.text)
//                           .then((value) {
//                         setState(() {
//                           spinner = false;
//                         });

//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomePage()));
//                       }).onError((error, stackTrace) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("Invalid Email or Password"),
//                         ));
//                       });
//                     },
//                     child: Text(
//                       "Signin",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 MaterialButton(
//                     child: Text("Forgot Password"),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ForgetPassword()));
//                     }),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var result = await FilePicker.platform.pickFiles(
//                       allowMultiple: false,
//                       type: FileType.custom,
//                       allowedExtensions: ['png', 'jpg', 'gif'],
//                     );
//                     if (result == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("No Files Selected")));
//                       return;
//                     }
//                     var path = result.files.single.path;
//                     var fileName = result.files.single.name;
//                     uploadFile(path!, fileName);
//                   },
//                   child: Text("Upload a file"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
