// final fireStore = FirebaseFirestore.instance.collection("Users").snapshots();
// Future<void> getCurrentUserData() async {
//   User? user = FirebaseAuth.instance.currentUser;
//
//   if (user != null) {
//     print("cccccc ${currentUserId.value}");
//     var db = FirebaseFirestore.instance;
//     db.collection('Users').doc("${currentUserId.value}").get().then(
//           (DocumentSnapshot doc) async {
//         final data = doc.data() as Map<String, dynamic>;
//         print("cccccc $data");
//         return doc;
//         // ...
//       },
//       onError: (e) => print("Error getting document: $e"),
//     );
//   }
// // }
