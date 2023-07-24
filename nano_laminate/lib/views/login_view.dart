import 'package:flutter/material.dart';
import 'package:nano_laminate/widgets/auth_background_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [


              _loginForm(),

              const SizedBox( height: 50 ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( const StadiumBorder() )
                ),
                child: const Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, color: Colors.black87 ),)
              ),

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
                  const Text("Login", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                  const SizedBox(height: 15.0,),
                  _crearEmail(size.height, size.width),
                  const SizedBox(height: 30.0),
                  _crearPassword(),
                  const SizedBox(height: 30.0),
                  _crearBoton(),
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
              color: Color.fromRGBO(1, 97, 156, 1)),
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
                  color: Color.fromRGBO(1, 97, 156, 1)
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
        ((Set<MaterialState> states) => const Color.fromRGBO(1, 97, 156, 1)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: const Text('Ingresar'),
      ),
      onPressed: (){Navigator.pushReplacementNamed(context, 'home');} ,
    );

  }

}
