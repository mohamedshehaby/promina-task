import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/common/di/di.dart';
import 'package:promina_task/common/resources/strings_manager.dart';
import 'package:promina_task/presentation/blocs/images/image_bloc.dart';
import 'package:promina_task/presentation/views/gallery_view/gallery_view.dart';
import 'package:promina_task/presentation/views/login_view/login_view.dart';

import '../../presentation/blocs/gallery/gallery_bloc.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String galleryRoute = '/gallery';
}

class RoutesGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute<LoginView>(
          builder: (_) => LoginView(),
        );
      case Routes.galleryRoute:
        return MaterialPageRoute<GalleryView>(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GalleryBloc>(
                create: (context) => instance()..add(GalleryGetGalleryEvent()),
              ),
              BlocProvider<ImageBloc>(
                create: (context) => instance(),
              )
            ],
            child: const GalleryView(),
          ),
        );
      default:
        return _unKnownRoute();
    }
  }

  static Route _unKnownRoute() {
    return MaterialPageRoute<Widget>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(
            child: Text(AppStrings.noRouteFound),
          ),
        );
      },
    );
  }
}
