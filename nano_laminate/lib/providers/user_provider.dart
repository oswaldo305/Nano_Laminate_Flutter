
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_laminate/model/usuario_model.dart';

class UserProvider {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> isAdmin(String uid) async {

    bool isAdmin = false;
    DocumentSnapshot documento = await db.collection("admin").doc(uid).get();
    if(documento.exists){
      isAdmin = true;
    }


    return isAdmin;

  }

  Future<Usuario?> getUserbyUid(String uid) async {

    DocumentSnapshot documento = await db.collection("usuario").doc(uid).get();
    if(documento.exists){
      String usuarioJson = jsonEncode(documento.data());
      Usuario usuario = usuarioFromJson(usuarioJson);
      usuario.id = uid;

      return usuario;
    }else{
      return null;
    }

  }

  Future postUser(Usuario usuario) async {
    await db.collection("usuario").doc(usuario.id).set(usuario.toDoc())
    .onError((e, _) => debugPrint("Error writing document: $e"));
  }

  Future updateImageUser(Usuario usuario) async {

    await db.collection("usuario").doc(usuario.id).set(usuario.toDoc());

  }

}