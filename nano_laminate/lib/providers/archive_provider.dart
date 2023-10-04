

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_laminate/model/archive_model.dart';

class ArchiveProvider {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Archive>> getArchives() async {

    final List<Archive> archives = [];
    CollectionReference collectionReferenceArchives = db.collection("archive");
    QuerySnapshot queryArchives = await collectionReferenceArchives.get();

    for (var documento in queryArchives.docs) {
      String archiveJson = jsonEncode(documento.data());
      Map<String, dynamic> archiveMap = jsonDecode(archiveJson);
      Archive archive = Archive.fromJson(archiveMap);
      archive.id = documento.id;
      archives.add(archive);
      debugPrint(archiveMap.toString());
    }


    return archives;

  }

  Future<Archive> postArchives(Archive archive) async {

    CollectionReference collectionReferenceArchives = db.collection("archive");
    DocumentReference documentReference = await collectionReferenceArchives.add(archive.toJson());
    archive.id = documentReference.id;

    return archive;

  }


}