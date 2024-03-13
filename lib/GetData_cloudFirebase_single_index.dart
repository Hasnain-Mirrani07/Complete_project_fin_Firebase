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

//test




//
// QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//     .collection('Hours')
// .where("userId", isEqualTo: userId)
//     .get();
//
// if (querySnapshot.docs.isNotEmpty) {
// List<String> officeHoursList = [];
// querySnapshot.docs.forEach((doc) {
// String day = doc['Day'];
// List<dynamic> periods = doc['Period'];
// officeHoursList.add('$day: ${periods.join(', ')}');
// });





//  checkAdvisoryId() async {
//     bool isExist = false;
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('joinAdvisor')
//         .where("advisoryId", isEqualTo: userId)
//         .where("studentUserId", isEqualTo: currentUserId)
//         .get();
//
//     if (querySnapshot.docs.length >= 1) {
//       isExist = true;
//     }
//     return isExist;
//   }