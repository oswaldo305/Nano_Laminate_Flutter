

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_laminate/model/code_model.dart';

class CodeProvider {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Code?> getCode(String codigo) async {
    DocumentSnapshot documento = await db.collection("codigo").doc(codigo).get();
    if(documento.exists){
      String codigoJson = jsonEncode(documento.data());
      Code code = codeFromJson(codigoJson);
      code.id = codigo;

      return code;
    }else{
      return null;
    }

  }

  Future<bool> existCode(String codigo) async {

    bool isExist = false;
    DocumentSnapshot documento = await db.collection("codigo").doc(codigo).get();
    if(documento.exists){
      isExist = true;
    }

    return isExist;

  }

  Future postCode(Code code) async {

    await db.collection("codigo").doc(code.id).set(code.toDoc())
    .onError((e, _) => debugPrint("Error writing document: $e"));

  }

  Future updateCode(Code code) async {
    await db.collection("codigo").doc(code.id).set(code.toDoc())
    .onError((e, _) => debugPrint("Error writing document: $e"));
  }

}