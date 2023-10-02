part of 'image_user_bloc.dart';

class ImageUserState extends Equatable {

  final List<ImageUser> images;

  const ImageUserState({
    images
  }) : images = images ?? const [];

  ImageUserState copyWith({
    List<ImageUser>? images
  }) => ImageUserState(
    images: images ?? this.images
  );
  
  @override
  List<Object> get props => [images];
}
