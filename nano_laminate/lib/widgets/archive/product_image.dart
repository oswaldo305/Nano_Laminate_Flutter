import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nano_laminate/views/archive/image_full_screen_view.dart';

class ProductImage extends StatelessWidget {

  final String? url;

  const ProductImage({
    Key? key, 
    this.url
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: size.height*0.3,
        child: Opacity(
          opacity: 0.9,
          child: getImage(url, context)
          
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5)
      )
    ]
  );


  Widget getImage( String? picture, BuildContext context) {

    if ( picture == null || picture.isEmpty) {
      return const Image(
          image: AssetImage('assets/images/no-image.png'),
          fit: BoxFit.contain,
        );
    }

    if ( picture.startsWith('http') ){

      return  GestureDetector(
          child: FadeInImage(
            image: NetworkImage( url! ),
            placeholder: const AssetImage('assets/images/jar-loading.gif'),
            fit: BoxFit.contain,
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 2),
                reverseTransitionDuration: const Duration(seconds: 2),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: ImageFullScreen(
                      imageURL: url!,
                    ),
                  );
                },
              )
            );
          }
        );
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'image_full_screen_widget', arguments: url);
      },
      child: Image.file(
        File( picture ),
        fit: BoxFit.cover,
      ),
    );
  }

}