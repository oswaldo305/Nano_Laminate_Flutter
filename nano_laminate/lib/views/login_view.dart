import 'package:flutter/material.dart';
import 'package:nano_laminate/providers/user_provider.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';
import 'package:nano_laminate/services/notifications_service.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/widgets/auth_background_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String ? _userName;
  String ? _password;
  bool _isLoading = false;

  final authService = AuthFirebaseService();
  final userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              _loginForm(),

            ]
          ),
        ),
      ),
    );
  }
  
  _loginForm() {

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
          children: [

            SafeArea(
              child: Container(
                height: 120.0,
              ),
            ),

            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.only(
                  // media query
                  bottom: size.height * 0.01,
                  top: size.height * 0.15),
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                 color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color:
                            Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0),
                  ]
              ),
              child: Column(
                children: [
                  const Text("Iniciar Sesión", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                  const SizedBox(height: 15.0,),
                  _crearEmail(size.height, size.width),
                  const SizedBox(height: 30.0),
                  _crearPassword(),
                  const SizedBox(height: 30.0),
                  _crearBoton(),
                  _crearBotonGoogle(),
                  _crearBotonApple(),
                  _crearBotonNewAccount()
            
                ],
              ),
            ),
          ],
        ),
    );
  }
  
  _crearEmail(heigth, width) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.black,
        ),
        decoration: const InputDecoration(
          icon: Icon(Icons.person,
              color: Color.fromRGBO(150, 0, 19, 1)),
          hintText: '',
          labelText: 'Usuario',
          labelStyle: TextStyle(
              color:  Colors.black
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1)),
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onChanged: (String value){
          setState(() {
            _userName = value;
            debugPrint("User name: {$_userName}");
          });
        },
      ),
     );
  }
  
  _crearPassword() {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            style: const TextStyle(
                color: Colors.black    
            ),
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                  color: Color.fromRGBO(150, 0, 19, 1)
              ),
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                  color:  Colors.black
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1)),
              ),
            ),
            onChanged: (String value){
              _password = value;
              debugPrint("password: {$_password}");
            },
          ),
        );
  }
  
  _crearBoton() {
  
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>
        ((Set<MaterialState> states) => const Color.fromRGBO(150, 0, 19, 1)),
      ),
      onPressed: _isLoading ? null : () async {
        _login(_userName, _password);
        // Navigator.pushReplacementNamed(context, 'home');
      } ,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal  : 80.0, vertical: 15.0),
        child: const Text('Ingresar', style: TextStyle(color: Colors.white),),
      ),
    );

  }
  Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // El usuario canceló el inicio de sesión
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    print(e.toString());
    return null;
  }
}


  _crearBotonGoogle() {
  
  
   return ElevatedButton.icon(
     style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>
        ((Set<MaterialState> states) => const Color.fromARGB(255, 232, 236, 239)),
      ),

      onPressed: _isLoading ? null : () async {
        User? user = await signInWithGoogle();
        if (user != null) {
          Navigator.pushReplacementNamed(context, 'home');
          print("Inicio de sesión exitoso: ${user.displayName}");
          // Puedes redirigir al usuario o realizar otras acciones aquí
        } else {
          print("Inicio de sesión con Google fallido.");
        }
        
      } ,
      icon: Image.asset('assets/images/google.png', height: 24),
      label: const Text(
        'Iniciar sesión con Google',
        style: TextStyle(color: Color.fromARGB(255, 27, 27, 27)),
      ),
        
    );
    //SizedBox(height: 22);

  }

  _crearBotonApple() {
  
  
   return ElevatedButton.icon(

     style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>
        ((Set<MaterialState> states) => const Color.fromARGB(255, 0, 0, 0)),
      ),

      onPressed: () async {
        await authService.loginWithApple();
        Navigator.pushReplacementNamed(context, 'home');
      },
      icon: Image.asset('assets/images/apple.png', height: 24),
       label: const Text(
                'Iniciar sesión con Apple',
                style: TextStyle(color: Colors.white),
              ),
      
      
    );
    //SizedBox(height: 22);

  }

  _crearBotonNewAccount(){

    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'register'), 
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1)),
        shape: MaterialStateProperty.all( const StadiumBorder() )
      ),
      child: const Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, color: Colors.black87 ),)
    );

  }

  void _login(String? userName, String? password) async {
    _isLoading = true;

    final String? errorMessage = await authService.login(_userName!, _password!);
    final String adminEmail = await userProvider.getAdmin();

    if ( errorMessage == null ) {
      if(userName == adminEmail){
        UserPreference.isAdmin = true;
      }else{
        UserPreference.isAdmin = false;
      }
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      _isLoading = false;
      NotificationsService.showSnackbar(errorMessage);
    }

  }

  

}

