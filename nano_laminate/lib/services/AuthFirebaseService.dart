// ignore: file_names
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthFirebaseService extends ChangeNotifier{

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyB5WTQsto0T341Q1jdRszp0J1vzoABidjY';

  final storage = const FlutterSecureStorage();

  Future<String?> createUser( String email, String password ) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if( decodeResp.containsKey('idToken') ){

      await storage.write(key: 'token', value: decodeResp['idToken']);

      return null;

    }else{

      return decodeResp['error']['message'];

    }

  }

  Future<String?> login( String email , String password ) async {

    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String , dynamic> decodeResp = json.decode(resp.body);

    if( decodeResp.containsKey('idToken') ){

      await storage.write(key: 'token', value: decodeResp['idToken']);

      return null;

    }else{

      return decodeResp['error']['message'];

    }

  }

  Future logOut() async {

    await storage.delete(key: 'token'); 
    return;

  }

  Future<String> readToken() async {

    return await  storage.read(key: 'token') ?? '';

  }

}