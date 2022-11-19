import 'package:flutter/material.dart';
import 'package:flutter_hive/models/person.dart';
import 'package:flutter_hive/utils/update_person_form.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Person person;

  const UpdateScreen({
    super.key,
    required this.index,
    required this.person,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: UpdatePersonForm(
          index: widget.index,
          person: widget.person,
        ),
      ),
    );
  }
}
