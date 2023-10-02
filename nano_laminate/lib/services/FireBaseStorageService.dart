import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadImage(File file) async{

  final String nameFile = file.path.split("/").last;

  Reference ref = storage.ref().child("images").child(nameFile);
  final UploadTask uploadTask = ref.putFile(file);
  debugPrint(uploadTask.toString());

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  debugPrint(snapshot.toString());

  final String url = await snapshot.ref.getDownloadURL();
  debugPrint(url);


  return url;

}