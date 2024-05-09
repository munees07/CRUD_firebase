import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/screens/add_person.dart';
import 'package:firebase_setup/screens/edit_screen.dart';
import 'package:firebase_setup/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? personStream;

  getontheLoad() async {
    personStream = await DataBaseServices().getPersonInfo();
    setState(() {});
  }

  @override
  void initState() {
    getontheLoad();
    super.initState();
  }

  Widget allPersonInfos() {
    return StreamBuilder(
      stream: personStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      color: Colors.white.withOpacity(0.5),
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name : ${ds["Name"]}",
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditScreen(
                                                      id: ds["id"],
                                                      name: ds["Name"],
                                                      age: ds["Age"],
                                                      place: ds["Place"],
                                                    )));
                                      },
                                      icon: const Icon(Icons.edit))
                                ],
                              ),
                              Text("Age : ${ds["Age"]}",
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Place : ${ds["Place"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () async {
                                        await DataBaseServices()
                                            .deletePereson(ds["id"]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              const Gap(10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPersonScreen(),
                ));
          },
          child: const Icon(Icons.add)),
      body: Stack(
        children: [
          Image.asset(
              alignment: Alignment.centerLeft,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fitHeight,
              'assets/bookbg.jpg'),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [Expanded(child: allPersonInfos())],
            ),
          ),
        ],
      ),
    );
  }
}
