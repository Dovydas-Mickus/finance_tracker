import 'package:flutter/material.dart';
import 'package:finance_tracker/app.dart';
import 'package:finance_tracker/helper/object_box.dart';


late ObjectBox objectBox;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init(); // Initialize ObjectBox
  runApp(MyApp(objectBox: objectBox));
}
