
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserProvider {

  final databaseReference = FirebaseDatabase.instance.ref().child("image");
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> getAdmin() async {

    String adminEmail = "";
    CollectionReference collectionReferenceArchives = db.collection("admin");
    QuerySnapshot queryArchives = await collectionReferenceArchives.get();

    for (var documento in queryArchives.docs) {
      String adminJson = jsonEncode(documento.data());
      Map<String, dynamic> adminMap = jsonDecode(adminJson);
      adminEmail = adminMap['email'];
    }


    return adminEmail;

  }

}