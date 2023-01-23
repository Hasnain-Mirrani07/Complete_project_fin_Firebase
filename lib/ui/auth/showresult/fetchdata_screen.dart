import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class FetchDataScreen extends StatefulWidget {
  FetchDataScreen({
    super.key,
  });

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool isLoading = true;
  final searchFilter = TextEditingController();
  final _editController = TextEditingController();

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
          Text("Firebase Anaimated Llist"),
          Expanded(
            child: FirebaseAnimatedList(
                query: databaseRef,
                defaultChild: Center(child: CircularProgressIndicator()),
                itemBuilder: (context, snapshot, animation, index) {
                  var _title = snapshot.child('title').value.toString();
                  final id = snapshot.child("id").value.toString();
                  final title = snapshot.child('title').value.toString();
                  print("id==>> $databaseRef");

                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                        title: Text(title),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert_sharp),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _showMyDialog(title, id);
                                      },
                                      child: const ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text("Edit"),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                      value: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          databaseRef.child(id).remove();
                                        },
                                        child: ListTile(
                                          title: Text("Delete"),
                                          leading: Icon(Icons.delete),
                                        ),
                                      )),
                                ]));
                  } else if (_title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(id),
                      // trailing: PopupMenuButton(
                      //     icon: Icon(Icons.more_vert_sharp),
                      //     itemBuilder: (BuildContext context) =>
                      //         <PopupMenuEntry>[
                      //           const PopupMenuItem(
                      //             value: 1,
                      //             child: ListTile(
                      //               leading: Icon(Icons.edit),
                      //             ),
                      //           ),
                      //           const PopupMenuItem(
                      //               value: 2,
                      //               child: ListTile(
                      //                 leading: Icon(Icons.delete),
                      //               )),
                      //         ]
                      //         )
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

  Future<void> _showMyDialog(String title, String id) async {
    _editController.text = title;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _editController,

                  // id = _editController.text;

                  decoration: InputDecoration(hintText: "Edit Data"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                try {
                  databaseRef.child(id).update({
                    'title': _editController.text.toLowerCase()
                  }).then((value) =>
                      ReUse().loginErrorToast("Data Updated Successfully"));
                  Navigator.of(context).pop();
                } catch (e) {
                  ReUse().loginErrorToast("Failed to update $e");
                }
              },
            ),
          ],
        );
      },
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