import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/common/resources/assets_manager.dart';
import 'package:promina_task/common/resources/font_manager.dart';
import 'package:promina_task/common/resources/strings_manager.dart';
import 'package:promina_task/presentation/blocs/gallery/gallery_bloc.dart';

import '../../../common/dialogs.dart';
import '../../../common/resources/routes_manager.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/images/image_bloc.dart';

part 'widgets/gallery_actions_widget.dart';
part 'widgets/gallery_app_bar_widget.dart';
part 'widgets/gallery_grid_widget.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ImageBloc, ImageState>(
        listener: (context, state) async {
          if (state is ImageLoadingState) {
            showAlertDialog(
                context: context, isLoading: true, title: AppStrings.uploading);
          } else if (state is ImageFailureState) {
            Navigator.of(context).pop();
            showAlertDialog(context: context, title: state.failure.message);
          } else if (state is ImageSuccessState) {
            Navigator.of(context).pop();
            showAlertDialog(context: context, title: state.message);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(AppAssets.galleryBackground),
                  fit: BoxFit.cover,
                ),
              )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                child: Column(
                  children: [
                    const GalleryAppBarWidget(),
                    40.verticalSpace,
                    const GalleryActionsWidget(),
                    const GalleryGridWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
