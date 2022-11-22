import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive/models/person.dart';
import 'package:flutter_hive/screens/add_screen.dart';
import 'package:flutter_hive/screens/update_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;

  /// Delete info from people box
  void _deleteInfo(int index) async {
    contactBox.deleteAt(index);
    print('Item deleted from box at index: $index');
  }

  @override
  void initState() {
    super.initState();

    /// Get reference to an already opened box
    contactBox = Hive.box('peopleBox');
  }

  @override
  void dispose() {
    /// Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People Info'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBox.listenable(),
        builder: (BuildContext context, Box box, Widget? widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final currentBox = box;

                /// Decode Base64
                Codec<String, String> stringToBase64 = utf8.fuse(base64);
                String decodedPersonJson =
                    stringToBase64.decode(currentBox.getAt(index));

                Map<String, dynamic> personJson =
                    json.decode(decodedPersonJson);

                final Person personData = Person(
                  name: personJson['name'],
                  country: personJson['country'],
                );

                // final Person personData = currentBox.getAt(index);
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UpdateScreen(
                        index: index,
                        person: personData,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(personData.name),
                    subtitle: Text(personData.country),
                    trailing: IconButton(
                      onPressed: () => _deleteInfo(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
