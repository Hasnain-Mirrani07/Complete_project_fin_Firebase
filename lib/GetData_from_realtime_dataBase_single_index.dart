//Get data for Appoointment =====
// getDataFromDatabase() async {
//   var value = FirebaseDatabase.instance.ref();
//   var getValue = await value.child('CalendarAppointmentCollection').get();
//   return getValue;
// }

// DataSnapshot? querySnapshot;

// viewmodel.getDataFromDatabase().then((results) {
// setState(() {
// if (results != null) {
// querySnapshot = results;
// _showCalendar();
// }
// });
// });





//show


_showCalendar() {
//   if (querySnapshot != null) {
//     var showData = querySnapshot?.value;
//     print("get data tttt ====   ${showData}");
//     Map<dynamic, dynamic>? values = showData as Map?;
//
//     List<dynamic> key = values!.keys.toList();
//
//     if (values != null) {
//       for (int i = 0; i < key.length; i++) {
//         data = values[key[i]];
//         viewmodel.appointmetnList.add(data);
//         print("get data  ------ $data");
//         DateTime startDate =
//         DateFormat("yyyy-MM-dd").parse(data['StartTime']);
//         DateTime endDate = DateFormat("yyyy-MM-dd").parse(data['EndTime']);
//
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }
// }