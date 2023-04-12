part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class ImageUploadImageEvent extends ImageEvent {
  final File image;

  const ImageUploadImageEvent({
    required this.image,
  });

  @override
  List<Object> get props => [image];
}
