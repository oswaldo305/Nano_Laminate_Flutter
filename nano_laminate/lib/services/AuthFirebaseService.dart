// ignore: file_names
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthFirebaseService extends ChangeNotifier{

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyB5WTQsto0T341Q1jdRszp0J1vzoABidjY';

  final storage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> createUser( String email, String password ) async {

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

      return decodeResp;

    }else{

      return decodeResp;

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

  Future loginWithGoole() async {
      try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      debugPrint("user1: ${googleSignInAccount.authHeaders}");
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      debugPrint("user: ${authResult.credential!.accessToken}");
      await storage.write(key: 'token', value: authResult.credential!.accessToken);
      return user;
    } catch (error) {
      debugPrint("Error al registrar con Google: $error");
      return null;
    }
  }

  Future loginWithApple() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final AuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      debugPrint("user1: ${result.identityToken.toString()}");
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user!;
      await storage.write(key: 'token', value: authResult.credential!.accessToken);
      debugPrint("user: ${user.toString()}");
      return user;
    } catch (error) {
      debugPrint("Error al registrar con Apple: $error");
      return null;
    }
  }

  Future logOut() async {

    await storage.delete(key: 'token'); 
    return;

  }

  Future<String> readToken() async {

    String? token = await storage.read(key: 'token');
    debugPrint("token: $token");
    return await storage.read(key: 'token') ?? '';

  }

}