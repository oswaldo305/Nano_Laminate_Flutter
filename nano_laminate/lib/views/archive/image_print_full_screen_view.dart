import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nano_laminate/model/image_user_model.dart';

class ImagePrintFullScreen extends StatelessWidget {

  final ImageUser imageUser;

  const ImagePrintFullScreen({
    Key? key,
    required this.imageUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: Text("${imageUser.nombre[0].toUpperCase()} ${imageUser.nombre.substring(0)}"),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: const Icon(Icons.print)
          )
        ],
      ),
      body: SizedBox.expand(
        child: Hero(
          tag: 'my_image',
          child: getImage(imageUser.path, context),
        ),
      ),
    );
  }

  Widget getImage( String? picture, BuildContext context) {

    if ( picture == null || picture.isEmpty) {
      return const Image(
          image: AssetImage('assets/images/no-image.png'),
          fit: BoxFit.contain,
        );
    }

    if ( picture.startsWith('http') ){

      return FadeInImage(
        image: NetworkImage( picture ),
        placeholder: const AssetImage('assets/images/jar-loading.gif'),
        fit: BoxFit.contain,
      );
    }

    return Image.file(
        File( picture ),
        fit: BoxFit.contain,
      );
  }

}