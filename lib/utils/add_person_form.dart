import 'package:flutter/material.dart';
import 'package:flutter_hive/models/person.dart';
import 'package:hive/hive.dart';

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({super.key});

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;

  @override
  void initState() {
    super.initState();

    /// Get reference to an already opened box
    box = Hive.box('peopleBox');
  }

  /// Add info to people box
  void _addInfo() async {
    Person newPerson = Person(
      name: _nameController.text,
      country: _countryController.text,
    );

    box.add(newPerson);
    print('Info added to box!');
  }

  /// Validator field
  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: Column(
        children: [
          const Text('Name'),
          TextFormField(
            controller: _nameController,
            validator: _fieldValidator,
          ),
          const SizedBox(
            height: 24.0,
          ),
          const Text('Home Country'),
          TextFormField(
            controller: _countryController,
            validator: _fieldValidator,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_personFormKey.currentState!.validate()) {
                    _addInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
