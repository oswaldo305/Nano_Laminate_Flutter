import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/image_user/image_user_bloc.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/services/FireBaseStorageService.dart';
import 'package:nano_laminate/widgets/archive/product_image.dart';

class FileUpdateView extends StatefulWidget {

  final ImageUser imageUser;

  const FileUpdateView({super.key, required this.imageUser});

  @override
  State<FileUpdateView> createState() => _FileUpdateViewState();
}

class _FileUpdateViewState extends State<FileUpdateView> {

  TextEditingController nombreController = TextEditingController();
  bool _isLoading = false;
  late ImageUserBloc imageUserBloc;
  String url = "";

  @override
  Widget build(BuildContext context) {

    imageUserBloc = BlocProvider.of<ImageUserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: const Text("Actualizar un archivo"),
        actions: [
          IconButton(
            onPressed: () async {
              File file = await openFilePicker();
              if(file.path.isEmpty) return;
              debugPrint(file.path.toString());
              setState(() {
                url = file.path;
              });
            },
            icon: const Icon(Icons.photo_camera_back_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [ 
              
              ProductImage(url: url,),
              textInput("Nombre del archivo", const Icon(Icons.file_copy_rounded, color: Color.fromRGBO(150, 0, 19, 1),)),
              switchButton(),
              _crearBoton()
      
            ],
          ),
        ),
      ),
    );
  }

  Container textInput(String hintText, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Center(
        child: TextFormField(
          initialValue: widget.imageUser.nombre,
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
              widget.imageUser.nombre = value;
            });
          } ,
        ),
      ),
    );
  }
  
  switchButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 5.0),
      child: Row(
        children: [
          const Text(
            "Habilitar archivo:",
            style: TextStyle(
              fontSize: 17.0
            ),
          ),
          const SizedBox(width: 10.0,),
          Switch(
            // This bool value toggles the switch.
            value: widget.imageUser.status,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                widget.imageUser.status = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<File> openFilePicker() async {

    File fileForFirebase;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Establece el tipo de archivo en personalizado
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'bmp'], // Lista de extensiones permitidas
    );

    if (result != null) {
      // El usuario seleccionó archivos
      PlatformFile file = result.files.first;
      fileForFirebase = File(file.path!);
    } else {
      fileForFirebase = File("");
    }

    return fileForFirebase;
  }

  _crearBoton() {
  
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
          if(widget.imageUser.path!.isEmpty || widget.imageUser.nombre.isEmpty){
            showDialog(context: context, builder: (_) => AlertDialog(
              title: const Text("Asegurate de seleccionar un archivo y llenar el campo nombre"),
              actions: [
                TextButton(
                  onPressed: (){
                    _isLoading = false;
                    Navigator.pop(context);
                  },
                 child: const Text("Aceptar", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),) 
                )
              ],
            ));
          }else{
            if(widget.imageUser.path! != url){
              final urlFirebase = await uploadImage(File(url));
              widget.imageUser.path = urlFirebase;
            }
            debugPrint("imageUser: ${widget.imageUser.nombre} , ${widget.imageUser.idArchive} , ${widget.imageUser.status} , ${widget.imageUser.path}");
            imageUserBloc.updateImageUser(widget.imageUser);
            Navigator.pushReplacementNamed(context, "home");
          }
          // Navigator.pushReplacementNamed(context, 'home');
        } ,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal  : 80.0, vertical: 15.0),
          child: const Text('Actualizar', style: TextStyle(color: Colors.white),),
        ),
      ),
    );

  }

}