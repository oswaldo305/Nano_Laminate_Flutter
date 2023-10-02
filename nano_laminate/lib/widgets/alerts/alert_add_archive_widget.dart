import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_laminate/blocs/archive/archive_bloc.dart';
import 'package:nano_laminate/model/archive_model.dart';

class AlertAddArchiveWidget extends StatefulWidget {
  const AlertAddArchiveWidget({Key? key}) : super(key: key);

  @override
  State<AlertAddArchiveWidget> createState() => _AlertAddArchiveWidgetState();
}

class _AlertAddArchiveWidgetState extends State<AlertAddArchiveWidget> {
  String _nombreArchive = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("INGRESA EL NOMBRE DE TU NUEVA CARPETA: "),
      content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1) ),
              ),
              border: OutlineInputBorder(),
              hintText: 'Nombre de la carpeta',
            ),
            onChanged: (text){
              _nombreArchive = text;
            },
          ),
        ),
      actions: [
        TextButton(
          onPressed: (){
            final archiveBloc = BlocProvider.of<ArchiveBloc>(context);
            if(_nombreArchive.isNotEmpty){  
              final Archive archive = Archive(nombre: _nombreArchive);
              archiveBloc.addArchive(archive);
              Navigator.pop(context);
            }
          }, 
          child: const Text("ACEPTAR", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)),)
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: const Text("CANCELAR", style: TextStyle(color: Color.fromRGBO(150, 0, 19, 1)))
        ),
      ],
    );
  }
}