import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail() async {
    try {
      // Implementa el inicio de sesión con correo electrónico aquí utilizando Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: 'correo@example.com',
        password: 'contraseña',
      );
      // El inicio de sesión con correo electrónico fue exitoso
      User? user = userCredential.user;
      print('Usuario: ${user?.email}');
    } catch (e) {
      // Maneja cualquier excepción durante el inicio de sesión con correo electrónico
      print('Error de inicio de sesión con correo electrónico: $e');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // El inicio de sesión con Facebook fue exitoso
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        print('Usuario: ${user?.displayName}');
      } else if (result.status == LoginStatus.cancelled) {
        // El usuario canceló el inicio de sesión con Facebook
        print('Inicio de sesión con Facebook cancelado');
      } else {
        // Hubo un error durante el inicio de sesión con Facebook
        print('Error de inicio de sesión con Facebook: ${result.message}');
      }
    } catch (e) {
      // Maneja cualquier excepción durante el inicio de sesión con Facebook
      print('Error de inicio de sesión con Facebook: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // El inicio de sesión con Google fue exitoso
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        print('Usuario: ${user?.displayName}');
      } else {
        // El usuario canceló el inicio de sesión con Google
        print('Inicio de sesión con Google cancelado');
      }
    } catch (e) {
      // Maneja cualquier excepción durante el inicio de sesión con Google
      print('Error de inicio de sesión con Google: $e');
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      try {
        final AuthorizationResult result = await SignInWithApple.authorize(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        if (result.status == AuthorizationStatus.authorized) {
          // El inicio de sesión con Apple fue exitoso
          final OAuthCredential credential = result.credential!;
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          User? user = userCredential.user;
          print('Usuario: ${user?.displayName}');
        } else if (result.status == AuthorizationStatus.cancelled) {
          // El usuario canceló el inicio de sesión con Apple
          print('Inicio de sesión con Apple cancelado');
        } else {
          // Hubo un error durante el inicio de sesión con Apple
          print('Error de inicio de sesión con Apple');
        }
      } catch (e) {
        // Maneja cualquier excepción durante el inicio de sesión con Apple
        print('Error de inicio de sesión con Apple: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: signInWithEmail,
              child: Text('Iniciar sesión con correo'),
            ),
            ElevatedButton(
              onPressed: signInWithFacebook,
              child: Text('Iniciar sesión con Facebook'),
            ),
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text('Iniciar sesión con Google'),
            ),
            if (Theme.of(context).platform == TargetPlatform.iOS)
              ElevatedButton(
                onPressed: () => signInWithApple(context),
                child: Text('Iniciar sesión con Apple'),
              ),
          ],
        ),
      ),
    );
  }
}
