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

  }

  Future getImagesUser(String idArchive) async {

    final List<ImageUser> imagesUser = await imageUserProvider.getActiveImages(idArchive);
    debugPrint(" images user bloc: $imagesUser");
    add(NewListImageUserEvent(imagesUser));

  }

  Future addImageUser(ImageUser imageUser) async {

    final ImageUser imageUserResp = await imageUserProvider.postImageUser(imageUser);
    debugPrint(" images user bloc add: ${imageUserResp.toString()}");
    add(NewImageUserEvent(imageUserResp));

  }

}
