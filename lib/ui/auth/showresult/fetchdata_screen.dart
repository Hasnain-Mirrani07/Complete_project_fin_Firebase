import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool isLoading = true;
  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show Data")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: searchFilter,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Text("Firebase Anaimated List"),
          Expanded(
            child: FirebaseAnimatedList(
                query: databaseRef,
                defaultChild: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Text("Loading"),
                itemBuilder: (context, snapshot, animation, index) {
                  var _title = snapshot.child('title').value.toString();

                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else if (_title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}


//     Expanded(
          //   child: StreamBuilder(
          //     stream: databaseRef.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //       } else {
          //         List<dynamic> list = [];
          //         Map<dynamic, dynamic> map =
          //             snapshot.data!.snapshot.value as Map;
          //         list = map.values.toList();
          //         return ListView.builder(
          //             itemCount: snapshot.data?.snapshot.children.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text(list[index]['title'].toString()),
          //                 subtitle: Text(list[index]['title'].toString()),
          //               );
          //             });
          //       }
          //     },
          //   ),
          // ),