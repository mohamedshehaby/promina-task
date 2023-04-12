part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageSuccessState extends ImageState {
  final String message;

  const ImageSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ImageFailureState extends ImageState {
  final Failure failure;

  const ImageFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
