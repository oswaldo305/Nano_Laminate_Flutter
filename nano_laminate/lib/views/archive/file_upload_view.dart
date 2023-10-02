import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nano_laminate/model/archive_model.dart';
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

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
              // uploadImage(file);
            },
            icon: const Icon(Icons.photo_camera_back_rounded)
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [ 
            
            ProductImage(url: url,),
            textInput("Nombre del archivo", const Icon(Icons.file_copy_rounded), nombreArchivo, nombreController),
            switchButton()

          ],
        ),
      ),
    );
  }

  Container textInput(String hintText, Icon icon, String text, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              text = value;
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

}