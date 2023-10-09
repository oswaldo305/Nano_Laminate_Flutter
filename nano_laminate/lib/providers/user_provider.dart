
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_laminate/model/usuario_model.dart';

class UserProvider {

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

  Future<Usuario> getUserbyUid(String uid) async {

    DocumentSnapshot documento = await db.collection("usuario").doc(uid).get();
    String usuarioJson = jsonEncode(documento.data());
    Usuario usuario = usuarioFromJson(usuarioJson);
    usuario.id = uid;

    return usuario;

  }

  Future postUser(Usuario usuario) async {
    await db.collection("usuario").doc(usuario.id).set(usuario.toDoc())
    .onError((e, _) => debugPrint("Error writing document: $e"));
  }

  Future updateImageUser(Usuario usuario) async {

    await db.collection("usuario").doc(usuario.id).set(usuario.toDoc());

  }

}