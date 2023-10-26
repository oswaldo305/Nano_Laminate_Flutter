import 'package:flutter/material.dart';
import 'package:nano_laminate/services/AuthFirebaseService.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/utils/alert_sesion.dart';
import 'package:nano_laminate/utils/navigations_methosd.dart';
import 'package:nano_laminate/views/base_page_view.dart';
import 'package:nano_laminate/views/configuration/code_point_view.dart';

class ConfigurationUserView extends StatefulWidget {
  const ConfigurationUserView({super.key});

  @override
  State<ConfigurationUserView> createState() => _ConfigurationUserViewState();
}

class _ConfigurationUserViewState extends State<ConfigurationUserView> {

  final authService = AuthFirebaseService();
  final codigoTextButton = UserPreference.isAdmin ? "Registrar codigos" : "Canjear codigo";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: const Text("Configuración"),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, right: 25.0, left: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(150, 0, 19, 1),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    title: Text(codigoTextButton),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Color.fromRGBO(150, 0, 19, 1),),
                    onTap: (){
                      pushTopage(context, const CodePointView());
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      
                      color: const Color.fromRGBO(150, 0, 19, 1),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    title: const Text("Cerrar Sesión"),
                    trailing: const Icon(Icons.logout, color:Color.fromRGBO(150, 0, 19, 1),),
                    onTap: () {
                      authService.logOut();
                      MyNotification().dispatch(context);
                      showAlertLogoutStatus(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 17.0, right: 20.0),
                  alignment: Alignment.bottomRight,
                  child: const Text("Version: 1.0.0", style: TextStyle(color: Colors.black),),
                )
          )
        ] 
      )
    );
  }
}