import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
  Future addPerson(Map<String, dynamic> personInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Person')
        .doc(id)
        .set(personInfo);
  }

  Future<Stream<QuerySnapshot>> getPersonInfo() async {
    return FirebaseFirestore.instance.collection('Person').snapshots();
  }

  Future updatePerson(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('Person')
        .doc(id)
        .update(updateInfo);
  }

  Future deletePereson(String id) async {
    return await FirebaseFirestore.instance
        .collection('Person')
        .doc(id)
        .delete();
  }
}
