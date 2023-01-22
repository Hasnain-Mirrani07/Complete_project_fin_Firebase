import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class FireStoreGetData extends StatefulWidget {
  const FireStoreGetData({
    super.key,
  });

  @override
  State<FireStoreGetData> createState() => _FireStoreGetDataState();
}

class _FireStoreGetDataState extends State<FireStoreGetData> {
  final fireStore = FirebaseFirestore.instance.collection("users").snapshots();

  bool isLoading = true;
  final searchFilter = TextEditingController();
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FireStore Get Data")),
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
          const Text("Firebase Anaimated List"),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('FireStore fddrgdg DAta Load Errorr');
              } else {
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final String id =
                            snapshot.data!.docs[index]['id'].toString(),
                        title = snapshot.data!.docs[index]['titlle'].toString();
                    return ListTile(
                        title: Text("titlee=> $title"),
                        subtitle: Text("id => $id"),
                        trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert_sharp),
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
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(id)
                                              .delete();
                                        },
                                        child: const ListTile(
                                          title: Text("Delete"),
                                          leading: Icon(Icons.delete),
                                        ),
                                      )),
                                ]));
                  },
                ));
              }
            },
          ),
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

                  decoration: const InputDecoration(hintText: "Edit Data"),
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
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(id)
                      .update({
                    'title': _editController.text.toLowerCase()
                  }).then((value) =>
                          ReUse().loginErrorToast("Data Updateed Successfully"));
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