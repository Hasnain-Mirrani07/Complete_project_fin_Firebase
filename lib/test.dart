import 'package:flutter/material.dart';

class TestClass extends StatefulWidget {
  const TestClass({super.key});

  @override
  State<TestClass> createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  var index1 = 0;
  List item = [];
  List item2 = [];
  List item3 = [
    {"stringg": 1},
    {"string": 1},
  ];

  List item5 = ['balcoony', 'electricity', 'suii Gas'];
  List item4 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                child: const Text("button"),
                onPressed: () {
                  // var fixedLengthList = List<int>.filled(5, 1);
                  // fixedLengthList[0] = 87;
                  //   print(fixedLengthList);

                  // var growableList = [1, 2];
                  // print(growableList);

                  index1++;
                  Map object = {index1: index1};
                  item4.add(object);
                  print("item 4 ==>$item4");

                  // item2.add("string");

                  // print(item);
                  // print(item2);
                  // print(item3);
                  // print(item3[0]['string']);

                  //  item3[3] = value2;
                  //item4.clear();

                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Data {
  List item = [];

  void fu() {
    item.add(1);
  }
}
