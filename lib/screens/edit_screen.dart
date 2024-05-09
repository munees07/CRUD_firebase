// ignore_for_file: use_build_context_synchronously

import 'package:firebase_setup/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.age,
      required this.place});

  final String id;
  final String name;
  final String age;
  final String place;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    placeController.text = widget.place;
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            const Gap(10),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(hintText: "Age"),
            ),
            const Gap(10),
            TextFormField(
              controller: placeController,
              decoration: const InputDecoration(hintText: "Place"),
            ),
            const Gap(20),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateInfo = {
                        "Name": nameController.text,
                        "Age": ageController.text,
                        "id": widget.id,
                        "Place": placeController.text
                      };
                      await DataBaseServices()
                          .updatePerson(widget.id, updateInfo);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Update',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
