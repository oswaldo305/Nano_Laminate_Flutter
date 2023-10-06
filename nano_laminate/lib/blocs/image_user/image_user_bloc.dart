import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nano_laminate/model/image_user_model.dart';
import 'package:nano_laminate/providers/image_user_provider.dart';

part 'image_user_event.dart';
part 'image_user_state.dart';

class ImageUserBloc extends Bloc<ImageUserEvent, ImageUserState> {

  final ImageUserProvider imageUserProvider = ImageUserProvider();

  ImageUserBloc() : super(const ImageUserState()) {

    on<NewListImageUserEvent>((event, emit) {

      emit(state.copyWith(
        images: event.imagesUser
      ));

    });

    on<NewImageUserEvent>((event, emit){

      emit(state.copyWith(
        images: [...state.images, event.imageUser]
      ));

    });

    on<UpdateImageUserEvent>((event, emit){

      emit(state.copyWith(
        images: event.imagesUser
      ));

    });

  }

  Future getImagesUser(String idArchive) async {

    final List<ImageUser> imagesUser = await imageUserProvider.getImages(idArchive);
    debugPrint(" images user bloc: $imagesUser");
    add(NewListImageUserEvent(imagesUser));

  }

  Future getActiveImagesUser(String idArchive) async {

    final List<ImageUser> imagesUser = await imageUserProvider.getActiveImages(idArchive);
    debugPrint(" images user bloc: $imagesUser");
    add(NewListImageUserEvent(imagesUser));

  }

  Future addImageUser(ImageUser imageUser) async {

    final ImageUser imageUserResp = await imageUserProvider.postImageUser(imageUser);
    debugPrint(" images user bloc add: ${imageUserResp.toString()}");
    add(NewImageUserEvent(imageUserResp));

  }

  Future updateImageUser(ImageUser imageUser) async {

    await imageUserProvider.updateImageUser(imageUser);
    List<ImageUser> newImagesUser = _updateListImageUser(state.images, imageUser);
    add(UpdateImageUserEvent(newImagesUser));

  }

  List<ImageUser> _updateListImageUser(List<ImageUser> listImages, ImageUser imageUser){

    for(int i = 0; listImages.length<i; i++){
      if(listImages[i].id == imageUser.id){
        listImages[i] = imageUser;
      }
    }

    return listImages;

  }

  Future deleteImageUser(ImageUser imageUser) async {

    await imageUserProvider.deleteImageUser(imageUser);
    List<ImageUser> imagesUser = _deleteListImageUser(state.images, imageUser);
    add(UpdateImageUserEvent(imagesUser));

  }

  List<ImageUser> _deleteListImageUser(List<ImageUser> listImages, ImageUser imageUser) {

    listImages.removeWhere((image) => image.id == imageUser.id);
    return listImages;

  }

}
