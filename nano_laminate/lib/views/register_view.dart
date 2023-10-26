import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/user/user_bloc.dart';
import 'package:nano_laminate/model/usuario_model.dart';
import 'package:nano_laminate/providers/user_provider.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';
import 'package:nano_laminate/services/notifications_service.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/widgets/auth_background_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String ? _userName;
  String ? _password;

  bool _isLoading = false;

  final authService = AuthFirebaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _loginForm()
            ],
          ),
        )
      )
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
              margin: EdgeInsets.symmetric(
                  // media query
                  vertical: size.height > 600
                      ? size.height * 0.17 //antes era 0.17
                      : size.height * 0.05),
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
                  const Text('Registrarse', style: TextStyle(fontSize: 20.0)),
                  const SizedBox( height: 60.0 ),
                  _crearEmail(size.height, size.width),
                  const SizedBox(height: 30.0),
                  _crearPassword(),
                  const SizedBox(height: 30.0),
                  _crearBoton(),
                  _crearBotonGoogle(),
                  _crearBotonApple()
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
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onChanged: (String value){
          _userName = value;
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
            ),
            onChanged: (String value){
              _password = value;
            },
          ),
        );
  }
  
  _crearBoton() {

    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
  
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>
        ((Set<MaterialState> states) => const Color.fromRGBO(150, 0, 19, 1)),
      ),
      onPressed: _isLoading ? null : () async {
        
        _isLoading = true;

        final Map<String, dynamic> response = await authService.createUser(_userName!, _password!);

        if ( response.containsKey('localId')) {
          Usuario usuario = Usuario( id: response['localId'] , puntos: 0);
          userBloc.postUsuario(usuario);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'CheckAuthView');
          debugPrint("Correcto");
        } else {
          setState(() {
            _isLoading = false;
          });
          NotificationsService.showSnackbar(response['error']['message']);
        }

      } ,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: const Text('Registrarse'),
      ),
    );

  }

  _crearBotonGoogle() {
    
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final UserProvider userProvider = UserProvider();
  
    return ElevatedButton.icon(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>
          ((Set<MaterialState> states) => const Color.fromARGB(255, 232, 236, 239)),
        ),

        onPressed: _isLoading ? null : () async {
          _isLoading = true;
          User? user = await authService.loginWithGoole();
          if (user != null) {
            final Usuario? userExist = await userProvider.getUserbyUid(user.uid);
            if(userExist == null){
              Usuario usuario = Usuario( id: user.uid , puntos: 0);
              userBloc.postUsuario(usuario);
            }else{
              await userBloc.getUsuarioByUid(user.uid);
              UserPreference.isAdmin = await userProvider.isAdmin(user.uid);
            }
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, 'CheckAuthView');
            debugPrint("Inicio de sesión exitoso: ${user.displayName} , ${user.uid}");
            // Puedes redirigir al usuario o realizar otras acciones aquí
          } else {
            debugPrint("Inicio de sesión con Google fallido.");
          }
          
        } ,
        icon: Image.asset('assets/images/google.png', height: 24),
        label: const Text(
          'Iniciar sesión con Google',
          style: TextStyle(color: Color.fromARGB(255, 27, 27, 27)),
        ),
          
      );

  }

  _crearBotonApple() {
    
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final UserProvider userProvider = UserProvider();
  
   return ElevatedButton.icon(

     style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>
        ((Set<MaterialState> states) => const Color.fromARGB(255, 0, 0, 0)),
      ),

      onPressed: _isLoading ? null : () async {
        _isLoading = true;

        final User? user = await authService.loginWithApple();
        if (user != null) {
          final Usuario? userExist = await userProvider.getUserbyUid(user.uid);
          if(userExist == null){
            Usuario usuario = Usuario( id: user.uid , puntos: 0);
            userBloc.postUsuario(usuario);
          }else{
            await userBloc.getUsuarioByUid(user.uid);
            UserPreference.isAdmin = await userProvider.isAdmin(user.uid);
          }
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'CheckAuthView');
          debugPrint("Inicio de sesión exitoso: ${user.displayName} , ${user.uid}");
          // Puedes redirigir al usuario o realizar otras acciones aquí
        } else {
          debugPrint("Inicio de sesión con Google fallido.");
        }
      },
      icon: Image.asset('assets/images/apple.png', height: 24),
        label: const Text(
          'Iniciar sesión con Apple',
          style: TextStyle(color: Colors.white),
        ),
      
      
    );
    //SizedBox(height: 22);

  }

}
