import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/data/network/failure.dart';

import '../../../domain/repositories/image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;
  ImageBloc(this.imageRepository) : super(ImageInitial()) {
    on<ImageUploadImageEvent>((event, emit) async {
      emit(ImageLoadingState());
      (await imageRepository.uploadImage(event.image)).fold((failure) {
        emit(ImageFailureState(failure: failure));
      }, (message) {
        emit(ImageSuccessState(message: message));
      });
    });
  }
}
