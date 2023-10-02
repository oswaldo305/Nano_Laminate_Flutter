part of 'image_user_bloc.dart';

abstract class ImageUserEvent {
  const ImageUserEvent();
}

class NewListImageUserEvent extends ImageUserEvent {

  final List<ImageUser> imagesUser;

  const NewListImageUserEvent(this.imagesUser);

}

class NewImageUserEvent extends ImageUserEvent {

  final ImageUser imageUser;

  const NewImageUserEvent(this.imageUser);

}
