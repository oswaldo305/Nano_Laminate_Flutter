import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/bloc/image_user_bloc.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/services/FireBaseStorageService.dart';
import 'package:nano_laminate/widgets/archive/product_image.dart';

class FileUploadView extends StatefulWidget {

  final Archive archive;

  const FileUploadView({super.key, required this.archive});

  @override
  State<FileUploadView> createState() => _FileUploadViewState();
}

class _FileUploadViewState extends State<FileUploadView> {

  String url = "";
  String nombreArchivo = "";
  TextEditingController nombreController = TextEditingController();
  bool isEnable = true;
  bool _isLoading = false;
  late ImageUserBloc imageUserBloc;

  @override
  Widget build(BuildContext context) {

    imageUserBloc = BlocProvider.of<ImageUserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: const Text("Agrega un archivo"),
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
          cursorColor: Colors.black,
          controller: nombreController,
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
              nombreArchivo = value;
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
            value: isEnable,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                isEnable = value;
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
          debugPrint("nombre archivo: $nombreArchivo , url: $url");
          if(url.isEmpty || nombreArchivo.isEmpty){
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
            final urlFirebase = await uploadImage(File(url));
            ImageUser imageUser = ImageUser(nombre: nombreArchivo, idArchive: widget.archive.id!, status: isEnable, path: urlFirebase);
            debugPrint("imageUser: ${imageUser.nombre} , ${imageUser.idArchive} , ${imageUser.status} , ${imageUser.path}");
            imageUserBloc.addImageUser(imageUser);
            Navigator.pushReplacementNamed(context, "home");
          }
          // Navigator.pushReplacementNamed(context, 'home');
        } ,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal  : 80.0, vertical: 15.0),
          child: const Text('Ingresar', style: TextStyle(color: Colors.white),),
        ),
      ),
    );

  }

}