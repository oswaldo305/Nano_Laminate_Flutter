

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:http/http.dart' as http;

class ArchiveProvider {


  final String _baseUrl = "nanolaminate-8fd37-default-rtdb.firebaseio.com";

  

  Future<List<Archive>> getArchives() async {

    final List<Archive> archives = [];

    final url = Uri.https(_baseUrl, "archive.json");

    final response = await http.get(url);

    Map<String, dynamic> archiveMap = json.decode(response.body);
    archiveMap.forEach((key, value) {
         final tempArchive = Archive.fromJson(value);
         tempArchive.id = key;
         archives.add(tempArchive);
    });

    debugPrint(archiveMap.toString());

    return archives;

  }

  Future<Archive> postArchives(Archive archive) async {

    final url = Uri.https(_baseUrl, "archive.json");
    final resp = await http.post(url, body: archive.toJson());
    final decodeData = json.decode(resp.body);

    archive.id = decodeData['name'];

    return archive;

  }


}