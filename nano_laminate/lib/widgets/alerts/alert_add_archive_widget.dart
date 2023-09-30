import 'package:flutter/material.dart';

class AlertAddArchiveWidget extends StatelessWidget {
  const AlertAddArchiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("INGRESA EL NOMBRE DE TU NUEVA CARPETA: "),
      content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nombre de la carpeta',
            ),
          ),
        ),
      actions: [],
    );
  }
}