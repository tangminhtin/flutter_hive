import 'package:flutter/material.dart';
import 'package:flutter_hive/models/person.dart';
import 'package:flutter_hive/screens/info_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  /// Initialize hive
  await Hive.initFlutter();

  /// Registering the adapter
  Hive.registerAdapter(PersonAdapter());

  /// Open the peopleBox
  await Hive.openBox('peopleBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: const InfoScreen(),
    );
  }
}
