import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nano_laminate/model/image_user_model.dart';

class ImageUserProvider {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<ImageUser>> getActiveImages(String idArchive) async {
    
    debugPrint("id archivo: $idArchive");
    final List<ImageUser> imagesUser = [];
    CollectionReference collectionReferenceImageUser = db.collection("image");
    QuerySnapshot queryImageUser = await collectionReferenceImageUser.get();

    if(queryImageUser.docs.isNotEmpty){
      for (var documento in queryImageUser.docs) {
        String imageUserJson = jsonEncode(documento.data());
        debugPrint("imageJson: $imageUserJson");
        Map<String, dynamic> imageUserMap = jsonDecode(imageUserJson);
        ImageUser imageUser = ImageUser.fromJson(imageUserMap);
        if(imageUser.status == true && imageUser.idArchive == idArchive){
          imageUser.id = documento.id;
          imagesUser.add(imageUser);
        }
        debugPrint(imageUserMap.toString());
      }
    }


    return imagesUser;
  }

  Future<List<ImageUser>> getImages(String idArchive) async {
    
    debugPrint("id archivo: $idArchive");
    final List<ImageUser> imagesUser = [];
    CollectionReference collectionReferenceImageUser = db.collection("image");
    QuerySnapshot queryImageUser = await collectionReferenceImageUser.get();

    if(queryImageUser.docs.isNotEmpty){
      for (var documento in queryImageUser.docs) {
        String imageUserJson = jsonEncode(documento.data());
        debugPrint("imageJson: $imageUserJson");
        Map<String, dynamic> imageUserMap = jsonDecode(imageUserJson);
        ImageUser imageUser = ImageUser.fromJson(imageUserMap);
        imageUser.id = documento.id;
        if(imageUser.idArchive == idArchive){
          imagesUser.add(imageUser);
        }
        
        debugPrint(imageUserMap.toString());
      }
    }


    return imagesUser;
  }

  Future<ImageUser> postImageUser(ImageUser imageUser) async {

    CollectionReference collectionReferenceImageUser = db.collection("image");
    DocumentReference documentReference = await collectionReferenceImageUser.add(imageUser.toJson());
    imageUser.id = documentReference.id;

    return imageUser;

  }

  Future updateImageUser(ImageUser imageUser) async {

    await db.collection("image").doc(imageUser.id).set(imageUser.toJson());

  }



}