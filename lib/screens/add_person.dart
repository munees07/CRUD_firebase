import 'package:firebase_setup/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:random_string/random_string.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({super.key});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Firebase-CRUD',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> personInfo = {
                        "Name": nameController.text,
                        "Age": ageController.text,
                        "id": id,
                        "Place": placeController.text
                      };
                      await DataBaseServices()
                          .addPerson(personInfo, id)
                          .then((value) {
                        Fluttertoast.showToast(
                            msg: "Person details added successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    },
                    child: const Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
