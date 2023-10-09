import 'package:flutter/material.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/utils/navigations_methosd.dart';
import 'package:nano_laminate/views/archive/file_update_view.dart';
import 'package:nano_laminate/views/archive/image_print_full_screen_view.dart';

class ImageUserButtonWidget extends StatelessWidget {

  final ImageUser imageUser;

  const ImageUserButtonWidget({super.key, required this.imageUser});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(
          imageUser.nombre,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            overflow: TextOverflow.ellipsis,
            leadingDistribution: TextLeadingDistribution.proportional
          ),
        ),
        const SizedBox(height: 10.0,),
        GestureDetector(
          onTap: (){
            UserPreference.isAdmin ? 
            pushTopage(context, FileUpdateView(imageUser: imageUser)): 
            pushTopage(context, ImagePrintFullScreen(imageUser: imageUser));
          },
          child: FadeInImage(
            height: 170.0,
            image: NetworkImage( imageUser.path! ),
            placeholder: const AssetImage('assets/images/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}