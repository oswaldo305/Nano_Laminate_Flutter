import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nano_laminate/blocs/bloc/image_user_bloc.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/widgets/archive/image_user_button_widget.dart';

class ArchiveView extends StatefulWidget {

  final Archive archive;
  
  const ArchiveView({super.key, required this.archive});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {

  late ImageUserBloc imageUserBloc;

  @override
  void initState() {
    super.initState();
    imageUserBloc = BlocProvider.of<ImageUserBloc>(context);
    imageUserBloc.getImagesUser(widget.archive.id!);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: Text(widget.archive.nombre),
        actions: [
          IconButton(
            disabledColor: Colors.transparent,
            icon: const Icon(Icons.add),
            onPressed: () async {
              Navigator.pushNamed(context, 'file_upload_view', arguments: widget.archive);
            },
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: buildModulesGrid(size),
      ),
    );
  }

  Center textPrincipalContent() {
  return const Center(
      child: Text(
        'Agrega archivos a tu carpeta',
        style: TextStyle(fontSize: 18),
      ),
    );
}

  BlocBuilder<ImageUserBloc, ImageUserState> buildModulesGrid(size) {

    return BlocBuilder<ImageUserBloc, ImageUserState>(
      builder: (context, state){

        List<ImageUser> imagesUser = state.images;
        List<ImageUserButtonWidget> listImageUserButton = [];

        debugPrint("images user lenght: ${imagesUser.length}");

        if(imagesUser.isEmpty){
          return textPrincipalContent();
        }

        for(var image in imagesUser){
          ImageUserButtonWidget imageUserButton = ImageUserButtonWidget(imageUser: image);
          listImageUserButton.add(imageUserButton);
        }

        return buildGrid(size, listImageUserButton);

      }
    );

  }

  AlignedGridView buildGrid(Size size, List<ImageUserButtonWidget> listImageUserButton) {

    return AlignedGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: listImageUserButton.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(20.0),
          elevation: 4, // Elevación de la tarjeta
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
          ),
          child: Container(
            // color: Colors.amber,
            height: size.height * 0.3,
            margin: const EdgeInsets.all(20.0),
            child: listImageUserButton[index]
          ),
        );
      },
    );

  }
    

}