import 'package:flutter/material.dart';
import 'package:flutter_hive/models/person.dart';
import 'package:flutter_hive/screens/info_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as tin;

void main() async {
  /// Initialize hive
  await Hive.initFlutter();

  /// Registering the adapter
  Hive.registerAdapter(PersonAdapter());

  /// Open the peopleBox
  await Hive.openBox('peopleBox');

  const plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = tin.Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(encrypted.base64);
  print(decrypted);

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
