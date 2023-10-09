import 'package:flutter/material.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/utils/navigations_methosd.dart';
import 'package:nano_laminate/views/archive/archive_view.dart';

class ArchiveButtonWidget extends StatelessWidget {

  final Archive archive;

  const ArchiveButtonWidget({super.key, required this.archive});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        IconButton(
          iconSize: 80.0,
          onPressed: (){
            pushTopage(context, ArchiveView(archive: archive));
          }, 
          icon: const Icon(Icons.archive, color: Color.fromRGBO(150, 0, 19, 1)),
        ),
        const SizedBox(height: 5.0,),
        Text(archive.nombre, style: const TextStyle(color: Colors.black),),
      ],
    );
  }
}