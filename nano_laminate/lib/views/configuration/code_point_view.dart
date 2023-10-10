import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/user/user_bloc.dart';
import 'package:nano_laminate/model/code_model.dart';
import 'package:nano_laminate/model/usuario_model.dart';
import 'package:nano_laminate/providers/code_provider.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/utils/navigations_methosd.dart';
import 'package:nano_laminate/views/configuration/configuration_user_view.dart';

class CodePointView extends StatefulWidget {
  const CodePointView({super.key});

  @override
  State<CodePointView> createState() => _CodePointViewState();
}

class _CodePointViewState extends State<CodePointView> {

  final CodeProvider codeProvider = CodeProvider();

  final title = UserPreference.isAdmin ? "Registrar puntos" : "Canjear puntos";
  String nombreCodigo = "";
  TextEditingController nombreCodigoController = TextEditingController(), pointsController = TextEditingController();
  int points = 0;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: Text(title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                textInput("Codigo", const Icon(Icons.abc, color: Color.fromRGBO(150, 0, 19, 1),)),
                UserPreference.isAdmin ? numberInput("Puntos", const Icon(Icons.point_of_sale, color: Color.fromRGBO(150, 0, 19, 1),)) : Container(),
                _crearBoton()
              ],
            ),
          ),
          UserPreference.isAdmin ? Container() : Align(
            alignment: Alignment.bottomRight,
            child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 17.0, right: 20.0),
                  alignment: Alignment.bottomRight,
                  child: Text("Total puntos: ${userBloc.state.user!.puntos}", style: const TextStyle(color: Colors.black),),
                )
          )
        ],
      ),
    );
  }

  Container textInput(String hintText, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Center(
        child: TextFormField(
          controller: nombreCodigoController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            hoverColor: const Color.fromRGBO(150, 0, 19, 1),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1) ),

            ),
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              nombreCodigo = value;
            });
          } ,
        ),
      ),
    );
  }

  
  Container numberInput(String hintText, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Center(
        child: TextFormField(
          controller: pointsController,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            hoverColor: const Color.fromRGBO(150, 0, 19, 1),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1) ),

            ),
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              int? valueParse = int.tryParse(value);
              if(valueParse != null) points = valueParse;
            });
          } ,
        ),
      ),
    );
  }

  _crearBoton() {

    final buttonName = UserPreference.isAdmin ? "Agregar" : "Canejar";
  
    return Container(
      margin: const EdgeInsets.all(25.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>
          ((Set<MaterialState> states) => const Color.fromRGBO(150, 0, 19, 1)),
        ),
        onPressed: _isLoading ? null : () async {
          _isLoading = true;
          debugPrint("nombre archivo: $nombreCodigo");
          if(nombreCodigo.isEmpty){
            showDialog(context: context, builder: (_) => AlertDialog(
              title: const Text("Asegurate de llenar el campo codigo"),
              actions: [
                TextButton(
                  onPressed: (){
                    _isLoading = false;
                    Navigator.pop(_);
                  },
                 child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                )
              ],
            ));
          }else{
            if(UserPreference.isAdmin){
              bool isExist = await codeProvider.existCode(nombreCodigo);
              if(!isExist){
                Code code = Code(id: nombreCodigo, puntos: points, status: true);
                await codeProvider.postCode(code);
                _isLoading = false;
                // ignore: use_build_context_synchronously
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: const Text("Se agregó el codigo exitosamente"),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(_);
                      },
                    child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                    )
                  ],
                ));
              }else{
                // ignore: use_build_context_synchronously
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: const Text("Actualmente este codigo ya existe"),
                  actions: [
                    TextButton(
                      onPressed: (){
                        _isLoading = false;
                        Navigator.pop(_);
                      },
                    child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                    )
                  ],
                ));
              }
            }else{
              Code? code = await codeProvider.getCode(nombreCodigo);
              if(code != null){  
                if(code.status){
                  // ignore: use_build_context_synchronously
                  UserBloc userBloc = BlocProvider.of<UserBloc>(context);
                  int newPoints = userBloc.state.user!.puntos+code.puntos;
                  Usuario usuario = Usuario(puntos: newPoints);
                  userBloc.postUsuario(usuario);
                  code.status = false;
                  await codeProvider.updateCode(code);
                  // ignore: use_build_context_synchronously
                  pushAndReplaceTopage(context, const ConfigurationUserView());
                }else{
                  // ignore: use_build_context_synchronously
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text("El codigo digitado ya no se encuentra disponible"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          _isLoading = false;
                          Navigator.pop(_);
                        },
                      child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                      )
                    ],
                  ));
                }
              }else{
                // ignore: use_build_context_synchronously
                showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text("El codigo digitado no existe"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          _isLoading = false;
                          Navigator.pop(_);
                        },
                      child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                      )
                    ],
                  ));
              }
            }
          }
          // Navigator.pushReplacementNamed(context, 'home');
        } ,
        child: _isLoading ? const CircularProgressIndicator() : Container(
          padding: const EdgeInsets.symmetric(horizontal  : 80.0, vertical: 15.0),
          child: Text(buttonName, style: const TextStyle(color: Colors.white),),
        ),
      ),
    );

  }

}