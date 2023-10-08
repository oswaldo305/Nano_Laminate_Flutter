import 'package:flutter/material.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';

class ConfigurationUserView extends StatefulWidget {
  const ConfigurationUserView({super.key});

  @override
  State<ConfigurationUserView> createState() => _ConfigurationUserViewState();
}

class _ConfigurationUserViewState extends State<ConfigurationUserView> {

  final authService = AuthFirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: const Text("Configuración"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(150, 0, 19, 1),
                width: 2,
              ),
            ),
            child: ListTile(
              title: const Text("Registrar codigos"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Color.fromRGBO(150, 0, 19, 1),),
              onTap: (){

              },
            ),
          ),
          const SizedBox(height: 15.0,),
          ListTile(
            title: const Text("Cerrar Sesión"),
            trailing: const Icon(Icons.logout, color:Color.fromRGBO(150, 0, 19, 1),),
            onTap: (){
              authService.logOut();
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      )
    );
  }
}