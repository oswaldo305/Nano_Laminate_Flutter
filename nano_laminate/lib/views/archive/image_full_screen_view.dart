import 'dart:io';

import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {

  final String imageURL;

  const ImageFullScreen({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
      ),
      body: SizedBox.expand(
        child: Hero(
          tag: 'my_image',
          child: getImage(imageURL, context),
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