import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/failure.dart';
import '../../../domain/repositories/image_repository.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final ImageRepository imageRepository;

  GalleryBloc({required this.imageRepository}) : super(GalleryInitial()) {
    on<GalleryGetGalleryEvent>((event, emit) async {
      emit(GalleryLoadingState());
      (await imageRepository.getGallery()).fold(
          (failure) => emit(GalleryFailureState(failure: failure)),
          (images) => emit(GallerySuccessState(images: images)));
    });
  }
}
