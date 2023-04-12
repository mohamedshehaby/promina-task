part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryLoadingState extends GalleryState {}

class GallerySuccessState extends GalleryState {
  final List images;

  const GallerySuccessState({
    required this.images,
  });

  @override
  List<Object> get props => [images];
}

class GalleryFailureState extends GalleryState {
  final Failure failure;

  const GalleryFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
