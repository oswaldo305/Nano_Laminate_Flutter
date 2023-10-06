import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nano_laminate/blocs/archive/archive_bloc.dart';
import 'package:nano_laminate/blocs/image_user/image_user_bloc.dart';
import 'package:nano_laminate/model/archive_model.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/shared_preference/user_preference.dart';
import 'package:nano_laminate/widgets/archive/image_user_button_widget.dart';

class ArchiveView extends StatefulWidget {

  final Archive archive;
  
  const ArchiveView({super.key, required this.archive});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {

  late ImageUserBloc imageUserBloc;
  late ArchiveBloc archiveBloc;
  late bool isEnable;
  bool edit = false;
  late String nombreArchivo;

  @override
  void initState() {
    super.initState();
    imageUserBloc = BlocProvider.of<ImageUserBloc>(context);
    UserPreference.isAdmin ? imageUserBloc.getImagesUser(widget.archive.id!) : imageUserBloc.getActiveImagesUser(widget.archive.id!);
    nombreArchivo = widget.archive.nombre;
    isEnable = widget.archive.status;
  }

  @override
  Widget build(BuildContext context) {

    archiveBloc = BlocProvider.of<ArchiveBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: size.height*0.15,
        backgroundColor: const Color.fromRGBO(150, 0, 19, 1),
        title: edit ? textInput("Nombre archivo", const Icon(Icons.archive, color: Color.fromRGBO(150, 0, 19, 1),)) : Text(widget.archive.nombre),
        actions: [
          edit ? Switch(
            value: isEnable,
            activeColor: Colors.red,
            onChanged: (bool value) {
              setState(() {
                isEnable = value;
              });
              
            },
          ) : const Text(""),
          IconButton(
            disabledColor: Colors.transparent,
            icon: const Icon(Icons.add),
            onPressed: UserPreference.isAdmin ? () async {
              Navigator.pushNamed(context, 'file_upload_view', arguments: widget.archive);
            } : null,
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: buildModulesGrid(size),
      ),
      floatingActionButton: UserPreference.isAdmin ? CircleAvatar(
        backgroundColor:  edit ? Colors.red : Colors.grey,
        child: IconButton(
          color: edit ? Colors.red : Colors.grey,
          onPressed: (){
            if(edit && nombreArchivo.isNotEmpty){
              if(nombreArchivo != widget.archive.nombre || isEnable != widget.archive.status){
                widget.archive.nombre = nombreArchivo;
                widget.archive.status = isEnable;
                archiveBloc.updateArchives(widget.archive);
              }
            }
            setState(() {
              edit ? edit = false : edit = true;
            });
          },
          icon: const Icon(Icons.edit_document, color: Colors.white,)
        ),
      ): null,
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

  Container textInput(String hintText, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20.0),
      height: 20.0,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        initialValue: nombreArchivo,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: icon,
          hoverColor: Colors.white,
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(150, 0, 19, 1) ),
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white ),
          )
        ),
        onChanged: (value) {
          setState(() {
            nombreArchivo = value;
          });
        } ,
      ),
    );
  }
    

}