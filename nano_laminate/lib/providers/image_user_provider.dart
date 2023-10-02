import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:http/http.dart' as http;

class ImageUserProvider {

  final String _baseUrl = "nanolaminate-8fd37-default-rtdb.firebaseio.com";
  final databaseReference = FirebaseDatabase.instance.ref().child("image");
  final FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<ImageUser>> getActiveImages(String idArchive) async {
    
    debugPrint("id archivo: $idArchive");
    final List<ImageUser> imagesUser = [];
    CollectionReference collectionReferenceImageUser = db.collection("image");
    QuerySnapshot queryImageUser = await collectionReferenceImageUser.get();

    for (var documento in queryImageUser.docs) {
      String imageUserJson = jsonEncode(documento.data());
      debugPrint("imageJson: $imageUserJson");
      Map<String, dynamic> imageUserMap = jsonDecode(imageUserJson);
      ImageUser imageUser = ImageUser.fromJson(imageUserMap);
      if(imageUser.status == true && imageUser.idArchive == idArchive){
        imageUserMap.forEach((key, value) {
          imageUser.id = key;
        });
        imagesUser.add(imageUser);
      }
      debugPrint(imageUserMap.toString());
    }


    return imagesUser;
  }

  Future<ImageUser> postImageUser(ImageUser imageUser) async {

    CollectionReference collectionReferenceImageUser = db.collection("image");
    DocumentReference documentReference = await collectionReferenceImageUser.add(imageUser.toJson());
    imageUser.id = documentReference.id;

    return imageUser;

  }



}