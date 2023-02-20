import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/Controller/splashScreen_controller.dart';
import 'package:social_app/test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test name', () {
    Data data = Data();
    data.fu();
  });
  test("description", () {
    final spsh = splasScreenController();
  });
}
